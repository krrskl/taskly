import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskly/presentation/features/countries/domain/entities/country.dart';
import 'package:taskly/presentation/features/countries/presentation/widgets/country_card.dart';
import 'package:taskly/presentation/i18n/translations.g.dart';

void main() {
  group('CountryCard Widget Tests', () {
    Country createTestCountry({
      String emoji = '🇺🇸',
      String name = 'United States',
      String code = 'US',
      String? capital = 'Washington, D.C.',
      String? currency = 'USD',
    }) {
      return Country(
        emoji: emoji,
        name: name,
        code: code,
        capital: capital,
        currency: currency,
      );
    }

    Widget createTestWidget(Widget child) {
      return TranslationProvider(
        child: MaterialApp(home: Material(child: child)),
      );
    }

    testWidgets('should display country emoji', (WidgetTester tester) async {
      final country = createTestCountry();

      await tester.pumpWidget(createTestWidget(CountryCard(country: country)));

      expect(find.text('🇺🇸'), findsOneWidget);
    });

    testWidgets('should display country name', (WidgetTester tester) async {
      final country = createTestCountry();

      await tester.pumpWidget(createTestWidget(CountryCard(country: country)));

      expect(find.text('United States'), findsOneWidget);
    });

    testWidgets('should display country code', (WidgetTester tester) async {
      final country = createTestCountry();

      await tester.pumpWidget(createTestWidget(CountryCard(country: country)));

      expect(find.text('US'), findsOneWidget);
    });

    testWidgets('should display capital when provided', (
      WidgetTester tester,
    ) async {
      final country = createTestCountry();

      await tester.pumpWidget(createTestWidget(CountryCard(country: country)));

      expect(find.textContaining('Capital: Washington, D.C.'), findsOneWidget);
    });

    testWidgets('should display currency when provided', (
      WidgetTester tester,
    ) async {
      final country = createTestCountry();

      await tester.pumpWidget(createTestWidget(CountryCard(country: country)));

      final richTextFinder = find.byWidgetPredicate(
        (widget) =>
            widget is RichText && widget.text.toPlainText().contains('USD'),
      );
      expect(richTextFinder, findsOneWidget);
    });

    testWidgets('should not display capital when capital is null', (
      WidgetTester tester,
    ) async {
      final country = createTestCountry(capital: null);

      await tester.pumpWidget(createTestWidget(CountryCard(country: country)));

      expect(find.textContaining('Capital:'), findsNothing);
    });

    testWidgets('should not display currency when currency is null', (
      WidgetTester tester,
    ) async {
      final country = createTestCountry(currency: null);

      await tester.pumpWidget(createTestWidget(CountryCard(country: country)));

      final richTextFinder = find.byWidgetPredicate(
        (widget) =>
            widget is RichText &&
            widget.text.toPlainText().contains('Currency:'),
      );
      expect(richTextFinder, findsNothing);
    });

    testWidgets('should display all information when all fields are provided', (
      WidgetTester tester,
    ) async {
      final country = createTestCountry();

      await tester.pumpWidget(createTestWidget(CountryCard(country: country)));

      expect(find.text('🇺🇸'), findsOneWidget);
      expect(find.text('United States'), findsOneWidget);
      expect(find.text('US'), findsOneWidget);
      expect(find.textContaining('Capital: Washington, D.C.'), findsOneWidget);

      final currencyFinder = find.byWidgetPredicate(
        (widget) =>
            widget is RichText &&
            widget.text.toPlainText().contains('Currency: USD'),
      );
      expect(currencyFinder, findsOneWidget);
    });
  });
}
