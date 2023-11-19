class NutritionModel {
  final String? name;
  final String? description;
  double? protein, carbohydrate, fat;

  NutritionModel(
      {this.name,
      this.description,
      this.protein,
      this.carbohydrate,
      this.fat});

  Map<String, dynamic> toMap() => {
    'name': name,
    'description': description,
    'protein': protein,
    'carbohydrate': carbohydrate,
    'fat': fat,
  };

  NutritionModel.fromJson(Map<String, dynamic> json)
      : fat = json['fat'] as double,
        name = json['name'],
        description = json['description'],
        protein = json['protein'] as double, //as double
        carbohydrate = json['carbohydrate'] as double; //as double
}
