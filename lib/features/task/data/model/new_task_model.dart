import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/task/data/model/new_task_model.freezed.dart';
part '../../../../generated/features/task/data/model/new_task_model.g.dart';

@freezed
class NewTaskModel with _$NewTaskModel {
  const NewTaskModel._();

  factory NewTaskModel({
    required String title,
    required String description,
    required DateTime expiresIn,
  }) = _NewTaskModel;

  factory NewTaskModel.fromJson(Map<String, Object?> json) =>
      _$NewTaskModelFromJson(json);
}
