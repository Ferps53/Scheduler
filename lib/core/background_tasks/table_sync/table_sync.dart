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
    final db = await appDatabase.database;
    final listData = <TableSyncDto>[];

    for (final table in tables.keys) {
      final dbMapList = await db.query(table);
      final tableData = TableSyncDto(
        name: table,
        userId: int.parse(userId),
        rows: dbMapList,
      );
      listData.add(tableData);
    }

    final response = await dio.put<List<TableSyncDto>>(
      '${Environments.backendRoot}/table-sync',
      data: listData,
    );

    final batch = db.batch();

    if (response.data != null) {
      for (final tableData in response.data!) {
        batch.delete(tableData.name);

        for (final row in tableData.rows) {
          batch.insert(tableData.name, row);
        }
      }
      batch.commit();
    }
  }
}
