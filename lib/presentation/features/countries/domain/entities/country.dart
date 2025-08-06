import 'package:copy_with_extension/copy_with_extension.dart';

part 'country.g.dart';

@CopyWith()
class Country {
  const Country({
    required this.code,
    required this.name,
    required this.emoji,
    this.capital,
    this.currency,
  });

  final String code;
  final String name;
  final String emoji;
  final String? capital;
  final String? currency;
}
