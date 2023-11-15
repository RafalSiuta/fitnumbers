import 'dart:ui';

import '../chart_model/chart_model.dart';

class CalculationModel {
  int? id;
  String? symbol;
  String? title;
  String? shortTitle;
  bool? isFavorite;
  double? value;
  String? unit;
  String? description;
  String? longDescription;
  String? formulaMale;
  String? formulaFemale;
  String? imagePath;
  List<ChartModel>? chartList;
  Color? infoColor;

  CalculationModel({this.id,
    this.symbol,
    this.title,
    this.shortTitle,
    this.unit,
    this.description,
    this.longDescription,
    this.value,
    this.formulaMale,
    this.formulaFemale,
    this.isFavorite = false,
    this.imagePath = '',
    this.chartList,
    this.infoColor
  });

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'symbol': symbol,
        'title': title,
        'short_title': shortTitle,
        'value': value,
        'unit': unit,
        'description': description,
        'long_description': longDescription,
        'is_favorite': isFavorite,
        'img_path': imagePath,
        'info_color': infoColor
      };

  CalculationModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        symbol = json['symbol'],
        title = json['title'],
        shortTitle = json['short_title'],
        value = json['value'] as double,
        unit = json['unit'],
        description = json['description'],
        longDescription = json['long_description'],
        isFavorite = json['is_favorite'] as bool,
        infoColor = json['info_color'] as Color,
        imagePath = json['img_path'];
}