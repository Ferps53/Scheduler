// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarefa_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TarefaModelImpl _$$TarefaModelImplFromJson(Map<String, dynamic> json) =>
    _$TarefaModelImpl(
      id: (json['id'] as num).toInt(),
      titulo: json['titulo'] as String,
      idUsusario: json['idUsusario'] as String,
      descricao: json['descricao'] as String,
      fgConcluida: json['fgConcluida'] as bool?,
      fgLixeira: json['fgLixeira'] as bool?,
      dataEnvioLixeira: json['dataEnvioLixeira'] as String?,
      dataCriacao: json['dataCriacao'] as String?,
      dataExpiracao: json['dataExpiracao'] as String?,
      dataConclusao: json['dataConclusao'] as String?,
    );

Map<String, dynamic> _$$TarefaModelImplToJson(_$TarefaModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titulo': instance.titulo,
      'idUsusario': instance.idUsusario,
      'descricao': instance.descricao,
      'fgConcluida': instance.fgConcluida,
      'fgLixeira': instance.fgLixeira,
      'dataEnvioLixeira': instance.dataEnvioLixeira,
      'dataCriacao': instance.dataCriacao,
      'dataExpiracao': instance.dataExpiracao,
      'dataConclusao': instance.dataConclusao,
    };
