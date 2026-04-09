class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return Center(
              child: CircularProgressIndicator(key: Key('loading')),
            );
          }

          if (state is NotesEmpty) {
            return Center(
              child: Text('No notes', key: Key('empty')),
            );
          }

          if (state is NotesError) {
            return Center(
              child: Text(state.message, key: Key('error')),
            );
          }

          if (state is NotesLoaded) {
            return ListView.builder(
              key: Key('notes_list'),
              itemCount: state.notes.length,
              itemBuilder: (_, index) {
                final note = state.notes[index];

                return ListTile(
                  key: Key('note_${note.id}'),
                  title: Text(note.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NoteDetailScreen(note: note),
                      ),
                    );
                  },
                );
              },
            );
          }

          return SizedBox();
        },
      ),

      floatingActionButton: FloatingActionButton(
        key: Key('add_button'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddNoteDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
