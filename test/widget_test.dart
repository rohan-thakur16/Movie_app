import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_api/screens/home_screen.dart';

void main() {
  testWidgets('HomePage widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Verify that 'Most Popular Tv Shows' header is present
    expect(find.text('Most Popular Tv Shows'), findsOneWidget);

    // Verify that 'Top 10 Tv Shows' header is present
    expect(find.text('Top 10 Tv Shows'), findsOneWidget);

    // Test the search bar
    expect(find.byType(TextField), findsOneWidget);

    // Test if the search bar is clickable and navigates to another page
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();

  });
}
