class SliderModel {
  final String? name;
  final String? unit;
  final double? minValue, maxValue;
  num sliderValue;

  SliderModel({
    this.name,
    this.unit,
    this.minValue,
    this.maxValue,
    this.sliderValue = 0,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'unit': unit,
        'minValue': minValue,
        'maxValue': maxValue,
        'sliderValue': sliderValue,
      };

  SliderModel.fromJson(Map<String, dynamic> json)
      : sliderValue = json['sliderValue'] as num,
        name = json['name'],
        unit = json['unit'],
        minValue = json['minValue'] as double, //as double
        maxValue = json['maxValue'] as double; //as double
}
