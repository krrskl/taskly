final String getCountriesQuery = '''
  query GetCountries {
    countries {
      code
      emoji
      name
      currency
      capital
    }
  }
''';
