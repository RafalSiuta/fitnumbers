class NutritionSettingsModel {

  NutritionSettingsModel(
      {this.value, this.symbol, this.firstOption, this.secondOption});

  final String? symbol;
  final String? firstOption;
  final String? secondOption;
  bool? value;

  Map<String, dynamic> toMap() => {
        'symbol': symbol,
        'firstOption': firstOption,
        'secondOption': secondOption,
        'value': value,
      };

  NutritionSettingsModel.fromJson(Map<String, dynamic> json)
      : value = json['value'] as bool,
        symbol = json['symbol'],
        firstOption = json['firstOption'],
        secondOption = json['secondOption'];
}
