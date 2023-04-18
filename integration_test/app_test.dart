import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end to end testing', () {
    testWidgets('Creating New Todo', (tester) async {
      main();
      await tester.pumpAndSettle();

      expect(find.text('Done!'), findsOneWidget);
    });
  });
}
