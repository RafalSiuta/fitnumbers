import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/profile_provider/profile_provider.dart';
import '../../../widgets/buttons/radio_tile.dart';
import '../../../widgets/responsive/column_row_builder.dart';
import '../../../widgets/seekbar/seekbar.dart';



class UserNutritionPage extends StatelessWidget {
  const UserNutritionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child){
          return
            Column(
              children: [
                SizedBox(height: 20,),


                Transform.scale(
                  scale: 0.8,
                  child: Switch(

                    value: profileProvider.isDefaultNutrition,
                    onChanged: (bool choice){
                      profileProvider.onNutritionModelSwitch(choice);
                    },
                  ),
                ),
                Divider(
                  indent: 70,
                  endIndent: 70,
                ),
                AnimatedOpacity(
                  opacity: profileProvider.isDefaultNutrition == false ? 1 : 0,
                  duration: const Duration(milliseconds: 400),
                  child: Visibility(
                    visible: profileProvider.isDefaultNutrition == false ? true : false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      child: ColumnBuilder(
                        itemCount: profileProvider.userNutritionData.nutritionListCounter,
                        itemBuilder: (context, index) {
                          var data = profileProvider.userNutritionDataList[index];
                          return SeekBar(
                            data.sliderValue.toDouble(),
                            title: data.name,
                            unit: data.unit,
                            minValue: data.minValue,
                            maxValue: data.maxValue,
                            btnPlus: () {
                              profileProvider.setNutritionData(index, operator: "+");
                            },
                            btnMinus: () {
                              profileProvider.setNutritionData(index, operator: "-");
                            },
                            onChange: (newVal) {
                              profileProvider.setNutritionData(index,newValue: newVal);
                            },
                            onChangeEnd: (newValue) {},
                          );
                        },
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: profileProvider.isDefaultNutrition == true ? 1 : 0,
                  duration: const Duration(milliseconds: 400),
                  child: Visibility(
                    visible: profileProvider.isDefaultNutrition == true ? true : false,
                    child: RadioTile(
                      title: "Test",
                      description: "description test",
                      value: 1,
                      groupValue: 1,
                      onChoice: (newVal){

                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Divider(
                  indent: 70,
                  endIndent: 70,
                ),

              ],
            );
        });
  }
}
