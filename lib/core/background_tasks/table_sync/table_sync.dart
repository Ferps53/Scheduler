import 'package:scheduler/core/background_tasks/table_sync/table_sync_dto.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/core/database/table_strategy.dart';
import 'package:scheduler/features/features.dart';

final tableSyncProvider = Provider<TableSync>((ref) {
  final dio = ref.read(dioProvider);
  final authDatasource = ref.read(authDatasourceProvider);
  final appDatabase = ref.read(databaseProvider);

  return TableSync(appDatabase, authDatasource, dio);
});

class TableSync {
  final AppDatabase appDatabase;
  final AuthDatasource authDatasource;
  final Dio dio;

  const TableSync(this.appDatabase, this.authDatasource, this.dio);

  Future<void> synchronizeDatabase() async {
    final userId = await authDatasource.getCurrentUserId();

    if (userId == null) {
      return;
    }

    final db = await appDatabase.database;
    final listData = <TableSyncDto>[];

    for (final table in tables.keys) {
      final dbMapList = await db.query(table);
      final dbConvertedJson = <Map<String, Object?>>[];
      for (final map in dbMapList) {
        if (table == 'task') {
          final task = TaskModel.fromDatabase(map);
          dbConvertedJson.add(task.toJson());
        }
      }

      final tableData = TableSyncDto(
        name: table,
        userId: int.parse(userId),
        rows: dbMapList,
      );

      listData.add(tableData);
    }

    final response = await dio.put<List>(
      '${Environments.backendRoot}/table-sync',
      data: listData,
    );

    final batch = db.batch();

    if (response.data != null) {
      final listRows = <TableSyncDto>[];

      for (final data in response.data!) {
        final tableSyncDto = TableSyncDto.fromJson(data);
        listRows.add(tableSyncDto);
      }

      for (final tableData in listRows) {
        if (tableData.name == 'task') {
          final taskJsonList = <Map<String, Object?>>[];
          for (var task in tableData.rows) {
            task = TaskModel.fromJson(task).toDatabaseMap();
            taskJsonList.add(task);
          }

          listRows.remove(tableData);
          listRows.add(
            TableSyncDto(
              name: tableData.name,
              userId: tableData.userId,
              rows: taskJsonList,
            ),
          );
        }
      }

      for (final tableData in listRows) {
        batch.delete(tableData.name);

        for (final row in tableData.rows) {
          batch.insert(tableData.name, row);
        }
      }
      batch.commit();
    }
  }
}
