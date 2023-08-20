class NutritionModel {
  final String? title;
  final String? description;
  double? protein, carbohydrate, fat;

  NutritionModel(
      {this.title,
      this.description,
      this.protein,
      this.carbohydrate,
      this.fat});

  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'protein': protein,
    'carbohydrate': carbohydrate,
    'fat': fat,
  };

  NutritionModel.fromJson(Map<String, dynamic> json)
      : fat = json['fat'] as double,
        title = json['title'],
        description = json['description'],
        protein = json['protein'] as double, //as double
        carbohydrate = json['carbohydrate'] as double; //as double
}
