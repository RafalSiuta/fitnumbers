import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/profile_provider/profile_provider.dart';
import '../../../widgets/buttons/radio_tile.dart';
import '../../../widgets/buttons/large_switch_tile.dart';
import '../../../widgets/dividers/list_divider.dart';
import '../../../widgets/headers/widget_header.dart';
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                WidgetHeader(
                  title: "macronutrients",
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                LargeSwitchTile(
                  title1: "default",
                  title2: "custom",
                  switchValue: profileProvider.isCustomNutrition,
                  onChanged: (bool choice){
                    profileProvider.onNutritionModelSwitch(choice);
                  },
                ),
                const ListDivider(),
                AnimatedOpacity(
                  opacity: profileProvider.isCustomNutrition == true ? 1 : 0,
                  duration: const Duration(milliseconds: 400),
                  child: Visibility(
                    visible: profileProvider.isCustomNutrition == true ? true : false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      child: ColumnBuilder(
                        itemCount: profileProvider.userNutritionData.customNutritionListCounter,
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
                            onChangeEnd: (newValue) {

                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: profileProvider.isCustomNutrition == false ? 1 : 0,
                  duration: const Duration(milliseconds: 400),
                  child: Visibility(
                    visible: profileProvider.isCustomNutrition == false ? true : false,
                    child: ColumnBuilder(
                      itemCount: profileProvider.userNutritionData.defaultNutritionListCounter,
                      itemBuilder: (context, index) {
                        var data = profileProvider.userNutritionDefaultList[index];
                        return  RadioTile(
                          title: data.name,
                          description: data.description,
                          value: index,
                          groupValue: profileProvider.defaultNutritionChoice,
                          onChoice: (newVal){
                              profileProvider.onDefaultNutritionChoice(newVal);
                          }
                        );
                      },
                    ),

                  ),
                ),
                const SizedBox(height: 20,),
                const ListDivider(),
                // Divider(
                //   indent: 70,
                //   endIndent: 70,
                // ),

              ],
            );
        });
  }
}
