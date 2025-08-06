import '../../domain/entities/country.dart';

class CountryModel {
  const CountryModel({
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

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      code: json['code'] as String,
      name: json['name'] as String,
      emoji: json['emoji'] as String,
      capital: json['capital'] as String?,
      currency: json['currency'] as String?,
    );
  }

  Country toDomain() {
    return Country(
      code: code,
      name: name,
      emoji: emoji,
      capital: capital,
      currency: currency,
    );
  }
}
