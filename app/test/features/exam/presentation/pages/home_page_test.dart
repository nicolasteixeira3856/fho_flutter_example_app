import 'package:exam_app/features/exam/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';


void main() {
  testWidgets('HomePage should navigate to RandomNumbersPage on button tap', (WidgetTester tester) async {
    // Arrange
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/random-numbers',
          name: '/random-numbers',
          builder: (context, state) {
            final quantity = state.extra as int;
            return Scaffold(body: Text('Random Numbers: $quantity'));
          },
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));

    // Act
    await tester.enterText(find.byType(TextField), '5');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Random Numbers: 5'), findsOneWidget);
  });
}