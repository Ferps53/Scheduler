part of '../screen/info_screen.dart';

class _InfoDeveloperCard extends StatelessWidget {
  const _InfoDeveloperCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage("assets/images/relaxed.jpg"),
        ),
        title: const Text("Desenvolvedor do App"),
        subtitle: const Text("Felipe Brostolin Ribeiro"),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.open_in_new),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
