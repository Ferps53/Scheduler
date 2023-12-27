// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/model/tarefa.dart';
import 'package:todo_list/src/model/tarefa_list.dart';

class TarefaFormDialog extends StatefulWidget {
  final Tarefa? tarefa;

  const TarefaFormDialog(this.tarefa, {super.key});

  @override
  State<TarefaFormDialog> createState() => _TarefaFormDialogState();
}

class _TarefaFormDialogState extends State<TarefaFormDialog> {
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_formData.isEmpty) {
      final tarefa = widget.tarefa;

      if (tarefa != null) {
        time = TimeOfDay.fromDateTime(tarefa.expiryDate);
        date = tarefa.expiryDate;

        _formData['id'] = tarefa.id;
        _formData['title'] = tarefa.title;
        _formData['description'] = tarefa.description;

        _dateController.text = DateFormat('dd/MM/yyyy').format(date);
        _timeController.text =
            "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
      }
    }
    super.didChangeDependencies();
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    setState(() => _isLoading = true);

    if (!isValid) {
      setState(() => _isLoading = false);
      return;
    }
    _formKey.currentState?.save();
    try {
      _formData['expiryDate'] = date.toIso8601String();
      await Provider.of<TarefaList>(context, listen: false)
          .saveTarefa(_formData);
      Navigator.of(context).pop();
    } catch (error) {
      print(error.toString());
      return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Ocorreu um erro!"),
                content: const Text("Ocorreu um erro ao salvar a Tarefa"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ok"),
                  )
                ],
              ));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xff03A9F4),
              title: Text(
                  widget.tarefa == null ? "Criar Tarefa" : "Atualizar Tarefa"),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: _formData['title']?.toString(),
                        decoration: const InputDecoration(labelText: "Titulo"),
                        textInputAction: TextInputAction.next,
                        onSaved: (title) => _formData['title'] = title ?? '',
                        validator: (validator) {
                          final title = validator ?? '';
                          if (title.trim().isEmpty) {
                            return "O titulo é obrigatório";
                          }
                          if (title.length > 16) {
                            return "O titulo está muito longo";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['description']?.toString(),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        decoration:
                            const InputDecoration(labelText: "Descrição"),
                        textInputAction: TextInputAction.newline,
                        onSaved: (desc) =>
                            _formData['description'] = desc ?? '',
                        validator: (validator) {
                          final desc = validator ?? '';
                          if (desc.trim().isEmpty) {
                            return "A Descrição é obrigatória";
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textFormFieldData(context),
                          const SizedBox(width: 20),
                          textFormFieldHorario(context),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.red),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Row(
                              children: [Icon(Icons.delete), Text("Cancelar")],
                            ),
                          ),
                          _isLoading
                              ? const Padding(
                                  padding: EdgeInsets.only(right: 30),
                                  child: CircularProgressIndicator(
                                    color: Colors.green,
                                    strokeWidth: 4,
                                  ),
                                )
                              : TextButton(
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.green),
                                  onPressed: _submitForm,
                                  child: const Row(
                                    children: [
                                      Icon(Icons.save),
                                      Text("Salvar")
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Flexible textFormFieldData(BuildContext context) {
    return Flexible(
                          flex: 1,
                          child: TextFormField(
                              controller: _dateController,
                              decoration: const InputDecoration(
                                  labelText: "Data Limite"),
                              readOnly: true,
                              onTap: () async {
                                DateTime? novaData = await showDatePicker(
                                  locale: const Locale("pt", "BR"),
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030),
                                );
                                setState(() {
                                  novaData != null
                                      ? date = DateTime(
                                          novaData.year,
                                          novaData.month,
                                          novaData.day,
                                          time.hour,
                                          time.minute)
                                      : date;
                                  _dateController.text =
                                      DateFormat('dd/MM/yyyy').format(date);
                                });
                              }),
                        );
  }

  Flexible textFormFieldHorario(BuildContext context) {
    return Flexible(
                          flex: 1,
                          child: TextFormField(
                              controller: _timeController,
                              decoration:
                                  const InputDecoration(labelText: "Horário"),
                              readOnly: true,
                              onTap: () async {
                                TimeOfDay? novoHorario = await showTimePicker(
                                  builder: (context, child) {
                                    return Localizations.override(
                                      context: context,
                                      locale: const Locale('pt', 'BR'),
                                      child: child,
                                    );
                                  },
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                setState(() {
                                  novoHorario != null
                                      ? time = novoHorario
                                      : time;
                                  DateTime newDate = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      time.hour,
                                      time.minute);
                                  date = newDate;
                                  _timeController.text =
                                      "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                                });
                              }),
                        );
  }
}
