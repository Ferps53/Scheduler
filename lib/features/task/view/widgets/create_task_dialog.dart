import 'package:intl/intl.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';
import 'package:scheduler/features/task/data/model/new_task_model.dart';
import 'package:scheduler/features/task/domain/entities/entities.dart';
import 'package:scheduler/features/task/view/providers/task_provider.dart';

class CreateTaskBottomModal extends StatelessWidget {
  const CreateTaskBottomModal({super.key, this.task});
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
                  const Spacer(
                    flex: 2,
                  ),
                  Text(
                    task != null ? 'Editar Tarefa' : 'Nova Tarefa',
                    style: context.titleLarge,
                  ),
                  const Spacer(),
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
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.fromDateTime(DateTime.now());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.task != null && widget.task!.expiresIn != null) {
      _date = widget.task!.expiresIn!;
      _time = TimeOfDay.fromDateTime(widget.task!.expiresIn!);

      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
    }

    _dateExpirationController.text = _dateFormat.format(_date);
    _hourExpirationController.text =
        '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _hourExpirationController.dispose();
    _dateExpirationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                if (value != null && value.trim().isEmpty) {
                  return 'Escreva um título para sua tarefa';
                }
                return null;
              },
              diposeController: false,
            ),
            CustomTextField(
              icon: Icons.description,
              label: 'Descrição',
              controller: _descriptionController,
              diposeController: false,
              validator: (value) {
                if (value != null && value.trim().isEmpty) {
                  return 'Escreva um título para sua tarefa';
                }
                return null;
              },
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
                        locale: const Locale('pt', 'BR'),
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
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: _time,
                        builder: (context, child) => Localizations.override(
                          context: context,
                          locale: const Locale('pt', 'BR'),
                          child: child!,
                        ),
                      );

                      if (time != null) {
                        _time = time;
                        _date = DateTime(
                          _date.year,
                          _date.month,
                          _date.day,
                          _time.hour,
                          _time.minute,
                        );
                      }
                      _hourExpirationController.text =
                          '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}';
                    },
                    diposeController: false,
                  ),
                )
              ],
            ),
            _SaveButton(
              taskEntity: widget.task,
              formKey: _formKey,
              titleController: _titleController,
              descriptionController: _descriptionController,
              date: _date,
            ),
          ],
        ),
      ),
    );
  }
}

class _SaveButton extends ConsumerWidget {
  const _SaveButton({
    required TaskEntity? taskEntity,
    required GlobalKey<FormState> formKey,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required DateTime date,
  })  : _formKey = formKey,
        _titleController = titleController,
        _descriptionController = descriptionController,
        _date = date,
        _taskEntity = taskEntity;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _titleController;
  final TextEditingController _descriptionController;
  final DateTime _date;
  final TaskEntity? _taskEntity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider);
    return switch (task) {
      AsyncLoading() => const GlassTextLoadingButton(),
      _ => GlassTextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final newTaskModel = NewTaskModel(
                id: _taskEntity?.id,
                title: _titleController.text,
                description: _descriptionController.text,
                expiresIn: _date,
              );
              if (_taskEntity == null) {
                await ref.read(taskProvider.notifier).createTask(newTaskModel);
                if (context.mounted) context.pop();
              } else {
                await ref.read(taskProvider.notifier).updateTask(newTaskModel);
                if (context.mounted) context.pop();
              }
            }
          },
          buttonLabel: 'Salvar',
          textSize: 24,
        ),
    };
  }
}
