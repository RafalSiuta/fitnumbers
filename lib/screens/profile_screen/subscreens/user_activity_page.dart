import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/choice_model/choice_model.dart';
import '../../../providers/profile_provider/profile_provider.dart';
import '../../../widgets/buttons/tile_button.dart';
import '../../../widgets/cards/slider_card.dart';
import '../../../widgets/carousel/carousel.dart';
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     SliderCard(
                //       icon: Icons.sports_martial_arts,
                //       description: "High activity",
                //     )
                //   ],
                // ),
                SizedBox(height: 20,),
                Divider(
                  indent: 70,
                  endIndent: 70,
                ),
                Expanded(
                  child: Scrollbar(
                    thickness: 0.5,

                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      itemCount: profileProvider.activityPowerData.activityPowerListCounter,
                      itemBuilder: (context, index){
                        final data = profileProvider.userPowerActivityList[index];
                        return SeekBar(
                          data.sliderValue.toDouble(),
                          btnPlus: (){
                            profileProvider.setPowerActivityData(index, operator: "+");
                          }, btnMinus: (){
                          profileProvider.setPowerActivityData(index, operator: "-");
                        }, onChange: (newVal){
                          profileProvider.setPowerActivityData(index, newValue: newVal,);
                        }, title: data.name,unit: data.unit,minValue: data.minValue, maxValue: data.maxValue,);
                      }, separatorBuilder: (context, item){
                      return  const SizedBox(height: 10,);
                    },),
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
