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

  testWidgets('add note flow', (tester) async {
  final bloc = MockNotesBloc();

  when(() => bloc.state).thenReturn(
    NotesLoaded([]),
  );

  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider.value(
        value: bloc,
        child: NotesScreen(),
      ),
    ),
  );

  // открыть диалог
  await tester.tap(find.byKey(Key('add_button')));
  await tester.pumpAndSettle();

  // ввод текста
  await tester.enterText(find.byKey(Key('input')), 'New Note');

  // нажать add
  await tester.tap(find.byKey(Key('submit')));
  await tester.pump();

  verify(() => bloc.add(AddNoteEvent('New Note'))).called(1);
});


  expect(find.byKey(Key('notes_list')), findsOneWidget);
});
testWidgets('shows error message', (tester) async {
  final bloc = MockNotesBloc();

  when(() => bloc.state).thenReturn(
    NotesError('Something went wrong'),
  );

  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider.value(
        value: bloc,
        child: NotesScreen(),
      ),
    ),
  );

  expect(find.byKey(Key('error')), findsOneWidget);
  expect(find.text('Something went wrong'), findsOneWidget);
});

testWidgets('navigate to detail screen', (tester) async {
  final bloc = MockNotesBloc();

  when(() => bloc.state).thenReturn(
    NotesLoaded([
      Note(id: 1, title: 'Test', content: '')
    ]),
  );

  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider.value(
        value: bloc,
        child: NotesScreen(),
      ),
    ),
  );

  await tester.tap(find.byKey(Key('note_1')));
  await tester.pumpAndSettle();

  expect(find.byType(NoteDetailScreen), findsOneWidget);
});

