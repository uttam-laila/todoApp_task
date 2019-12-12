import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/logics/logics.dart';
import '../lib/main.dart';
import '../lib/pages/addEditNotes.dart';

void main() {
  testWidgets('Testing the Starting page', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Test the first screen
    expect(find.text('TODO List'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byKey(ValueKey("addNotes")), findsOneWidget);

    // Navigate to 2nd screen
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Test the 2nd screen
    expect(find.byType(EditNote), findsOneWidget);
    expect(find.byKey(ValueKey('titleField')), findsOneWidget);
    expect(find.byKey(ValueKey('noteField')), findsOneWidget);
    expect(find.text('Add Notes'), findsOneWidget);

    // Enter notes details.
    await tester.enterText(find.byKey(ValueKey('titleField')), "Test01");
    await tester.enterText(find.byKey(ValueKey('noteField')), "Test01_ The Note Body");
    await tester.tap(find.text('Add Notes'));
    await tester.pumpAndSettle(Duration(milliseconds:400));

    // Test for success
    expect(find.text('Test01'), findsOneWidget);
    expect(find.text('Test01_ The Note Body'), findsOneWidget);

    // Checking validation logic
    var results = Logics.validateFormFields("");
    expect(results, 'This field can\'t be empty');

    results = Logics.validateFormFields("Some Text here");
    expect(results, null);

  });
}