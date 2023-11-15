// UserDataModel(
//     {this.gender,
//     this.activity,
//     this.age,
//     this.weight,
//     this.height,
//     this.waist,
//     this.hips,
//     this.neck,
//     this.benchPressPower,
//     this.squatPower,
//     this.deadLiftPower,
//     this.proteinPercent,
//     this.carbPercent,
//     this.fatPercent});
//
//  bool? gender;
//  int? activity;
//  double? age;
//  double? weight;
//  double? height;
//  double? waist;
//  double? hips;
//  double? neck;
//  double? benchPressPower;
//  double? squatPower;
//  double? deadLiftPower;
//  double? proteinPercent;
//  double? carbPercent;
//  double? fatPercent;
//
// Map<String, dynamic> toJson() => {
//   "gender": gender,
//   "activity": activity,
//   "age": age,
//   "weight": weight,
//   "height": height,
// "waist": waist,
// "hips": hips,
// "neck": neck,
// "bench_press_power": benchPressPower,
// "squat_power": squatPower,
// "dead_lift_power": deadLiftPower,
// "protein_percent": proteinPercent,
// "carb_percent": carbPercent,
// "fat_percent": fatPercent
// };
class UserDataModel {

  UserDataModel({
        this.gender,
    this.activity,
    this.age,
    this.weight,
    this.height,
    this.waist,
    this.hips,
    this.neck,
    this.benchPressPower,
    this.squatPower,
    this.deadLiftPower,
    this.proteinPercent,
    this.carbPercent,
    this.fatPercent});

 bool? gender;
 int? activity;
 double? age;
 double? weight;
 double? height;
 double? waist;
 double? hips;
 double? neck;
 double? benchPressPower;
 double? squatPower;
 double? deadLiftPower;
 double? proteinPercent;
 double? carbPercent;
 double? fatPercent;
}