// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/model/tarefa.dart';
import 'package:todo_list/src/model/tarefa_list.dart';

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
        _formData['expiryDate'] = tarefa.expiryDate;
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
    final horas = date.hour.toString().padLeft(2, '0');
    final minutos = date.minute.toString().padLeft(2, '0');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Formulário de Tarefa"),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save),
          ),
        ],
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
                      validator: (_title) {
                        final title = _title ?? '';
                        if (title.trim().isEmpty) {
                          return "O titulo é obrigatório";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description']?.toString(),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: const InputDecoration(labelText: "Descrição"),
                      textInputAction: TextInputAction.next,
                      onSaved: (desc) => _formData['description'] = desc ?? '',
                      validator: (_desc) {
                        final desc = _desc ?? '';
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
                        InkWell(
                          onTap: () async {
                            TimeOfDay? novoHorario = await showTimePicker(
                              context: context,
                              initialTime: time,
                            );

                            if (novoHorario == null) {
                              return;
                            }
                            setState(() {
                              time = novoHorario;
                              DateTime newDate = DateTime(date.year, date.month,
                                  date.day, time.hour, time.minute);
                              date = newDate;
                              _formData['expiryDate'] = date.toIso8601String();
                            });
                          },
                          child: Card(
                            color: Colors.blue,
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "$horas:$minutos",
                                    style: const TextStyle(
                                      fontSize: 26,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.query_builder,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            DateTime? novaData = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2025),
                            );

                            if (novaData == null) {
                              return;
                            }

                            setState(() {
                              date = DateTime(novaData.year, novaData.month,
                                  novaData.day, time.hour, time.minute);
                              _formData['expiryDate'] = date.toIso8601String();
                            });
                          },
                          child: Card(
                            color: Colors.blue,
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "${date.day}/${date.month}/${date.year}",
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.calendar_month,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
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
