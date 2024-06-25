import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todos_app/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Add Task Integration Test', () {
    testWidgets('Insert task', (WidgetTester tester) async {
      final mockSharedPreferences = MockSharedPreferences();

      SharedPreferences.setMockInitialValues({}); // Optional: Sets initial values for SharedPreferences

      app.main(preferences: mockSharedPreferences);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key('titleField')), 'Test Task');
      await tester.enterText(find.byKey(Key('descriptionField')), 'This is a test description');

      // Select a date range
      final DateTime now = DateTime.now();
      final DateTime startDate = now.add(Duration(days: 1));
      final DateTime endDate = now.add(Duration(days: 2));
      await tester.tap(find.byType(TableCalendar));
      await tester.pumpAndSettle();
      await tester.tap(find.text(startDate.day.toString()));
      await tester.pumpAndSettle();
      await tester.tap(find.text(endDate.day.toString()));
      await tester.pumpAndSettle();

      // Tap the save button
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verify that the task was added
      expect(find.text('Test Task'), findsOneWidget);
    });
  });
}
