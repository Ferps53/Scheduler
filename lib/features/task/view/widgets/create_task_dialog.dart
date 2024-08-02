import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';
import 'package:scheduler/features/task/domain/entities/entities.dart';

class TaskFullscreenDialog extends StatelessWidget {
  const TaskFullscreenDialog({super.key, this.task});
  final TaskEntity? task;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: GlassCard(
        isFrosted: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    'Nova Tarefa',
                    style: context.titleLarge,
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: context.pop,
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
              _TaskForm(task: task),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskForm extends StatefulWidget {
  const _TaskForm({this.task});

  final TaskEntity? task;

  @override
  State<_TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<_TaskForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateExpirationController = TextEditingController();
  final _hourExpirationController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.fromDateTime(DateTime.now());

  @override
  void initState() {
    super.initState();

    if (widget.task != null && widget.task!.expiresIn != null) {
      date = widget.task!.expiresIn!;
      time = TimeOfDay.fromDateTime(widget.task!.expiresIn!);

      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
    }

    _dateExpirationController.text = _dateFormat.format(date);
    _hourExpirationController.text =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              icon: Icons.label,
              label: 'Título',
              controller: _titleController,
              validator: (value) {
                return 'a';
              },
              diposeController: false,
            ),
            CustomTextField(
              icon: Icons.description,
              label: 'Descrição',
              controller: _descriptionController,
              diposeController: false,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: CustomTextField(
                    icon: Icons.calendar_month,
                    label: 'Data Expiração',
                    controller: _dateExpirationController,
                    readOnly: true,
                    diposeController: false,
                    onTap: () async {
                      final newDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (newDate != null) {
                        _dateExpirationController.text =
                            _dateFormat.format(newDate);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Flexible(
                  child: CustomTextField(
                    icon: Icons.timer_outlined,
                    label: 'Hora Expiração',
                    controller: _hourExpirationController,
                    readOnly: true,
                    onTap: () {
                      showTimePicker(context: context, initialTime: time);
                    },
                    diposeController: false,
                  ),
                )
              ],
            ),
            GlassTextButton(
              onPressed: () {},
              buttonLabel: 'Salvar',
              textSize: 24,
            ),
          ],
        ),
      ),
    );
  }
}
