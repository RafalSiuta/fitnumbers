class ChartModel {
  double? dateTime;
  double? value;
  int? id;


  ChartModel(this.id, this.dateTime, this.value);


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['date_time'] = dateTime;
    map['value'] = value;

    return map;
  }

  ChartModel.fromMap(Map<String, dynamic> map) {
    id = map['id'] as int;
    dateTime = map['date_time'] as double;
    value = map['value'] as double;
  }
}