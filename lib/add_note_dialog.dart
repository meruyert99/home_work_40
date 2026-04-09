class AddNoteDialog extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        key: Key('input'),
        controller: controller,
      ),
      actions: [
        TextButton(
          key: Key('submit'),
          onPressed: () {
            context.read<NotesBloc>().add(
                  AddNoteEvent(controller.text),
                );
            Navigator.pop(context);
          },
          child: Text('Add'),
        )
      ],
    );
  }
}
