testWidgets('empty → loading → loaded', (tester) async {
  final bloc = MockNotesBloc();

  when(() => bloc.state).thenReturn(NotesEmpty());

  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider.value(
        value: bloc,
        child: NotesScreen(),
      ),
    ),
  );

  expect(find.byKey(Key('empty')), findsOneWidget);

  whenListen(
    bloc,
    Stream.fromIterable([
      NotesLoading(),
      NotesLoaded([Note(id: 1, title: 'Test', content: '')])
    ]),
  );

  await tester.pump();

  expect(find.byKey(Key('loading')), findsOneWidget);

  await tester.pump();

  expect(find.byKey(Key('notes_list')), findsOneWidget);
});
