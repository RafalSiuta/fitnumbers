import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/choice_model/choice_model.dart';
import '../../../providers/profile_provider/profile_provider.dart';
import '../../../widgets/buttons/tile_button.dart';
import '../../../widgets/cards/slider_card.dart';
import '../../../widgets/carousel/carousel.dart';
import '../../../widgets/responsive/column_row_builder.dart';
import '../../../widgets/seekbar/seekbar.dart';

class UserActivityPage extends StatelessWidget {
  const UserActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    const tileSize = 100.0;
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child){
          return
            Column(
              children: [
                SizedBox(height: 20,),
                ActivityCarousel(),
                SizedBox(height: 20,),
                Divider(
                  indent: 70,
                  endIndent: 70,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  child: ColumnBuilder(
                    itemCount: profileProvider.activityPowerData.activityPowerListCounter,
                    itemBuilder: (context, index) {
                      var data = profileProvider.userPowerActivityList[index];
                      return SeekBar(
                        data.sliderValue.toDouble(),
                        title: data.name,
                        unit: data.unit,
                        minValue: data.minValue,
                        maxValue: data.maxValue,
                        btnPlus: () {
                          profileProvider.setPowerActivityData(index, operator: "+");
                        },
                        btnMinus: () {
                          profileProvider.setPowerActivityData(index, operator: "-");
                        },
                        onChange: (newVal) {
                          profileProvider.setPowerActivityData(index,newValue: newVal);
                        },
                        onChangeEnd: (newValue) {},
                      );
                    },
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
