import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_workshop/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Find PASS IN DIALOG', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 3));
      await tester.tap(
        find.byKey(const Key('add-todo-btn')),
      );
      await Future.delayed(const Duration(seconds: 3));
      await tester.enterText(
          find.byKey(const Key('title-text-field')), "This is new todo");
      await Future.delayed(const Duration(seconds: 3));
      await tester.tap(find.byKey(const Key('submit')));
      await Future.delayed(const Duration(seconds: 3));
      expect(find.widgetWithText(Dialog, "Done!"), findsOneWidget);
    });
  });
}
