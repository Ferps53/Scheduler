// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/model/tarefa.dart';
import 'package:todo_list/src/model/tarefa_list.dart';

import '../widgets/date_card.dart';
import '../widgets/hour_card.dart';

class TarefaFormScreen extends StatefulWidget {
  const TarefaFormScreen({super.key});

  @override
  State<TarefaFormScreen> createState() => _TarefaFormScreenState();
}

class _TarefaFormScreenState extends State<TarefaFormScreen> {
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final tarefa = arg as Tarefa;

        _formData['id'] = tarefa.id;
        _formData['title'] = tarefa.title;
        _formData['description'] = tarefa.description;
        date = tarefa.expiryDate;
        time = TimeOfDay.fromDateTime(tarefa.expiryDate);
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
    final horas = time.hour.toString().padLeft(2, '0');
    final minutos = time.minute.toString().padLeft(2, '0');
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !_isLoading,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          backgroundColor: Colors.lightGreen,
          onPressed: _submitForm,
          child: const Icon(
            Icons.save,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Formulário de Tarefa"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
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
                      decoration: const InputDecoration(labelText: "Descrição"),
                      textInputAction: TextInputAction.newline,
                      onSaved: (desc) => _formData['description'] = desc ?? '',
                      validator: (validator) {
                        final desc = validator ?? '';
                        if (desc.trim().isEmpty) {
                          return "A Descrição é obrigatória";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 7,
                          child: InkWell(
                            onTap: () async {
                              TimeOfDay? novoHorario = await showTimePicker(
                                context: context,
                                initialTime: time,
                              );
                              setState(() {
                                novoHorario != null ? time = novoHorario : time;
                                DateTime newDate = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    time.hour,
                                    time.minute);
                                date = newDate;
                              });
                            },
                            child: HourCard(horas: horas, minutos: minutos),
                          ),
                        ),
                        Flexible(
                          flex: 10,
                          child: InkWell(
                            onTap: () async {
                              DateTime? novaData = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                              );

                              setState(() {
                                novaData != null ? date = novaData : date;
                              });
                            },
                            child: DateCard(date: date),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
