import 'package:fitnumbers2/widgets/seekbar/seekbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fitnumbers2/providers/profile_provider/profile_provider.dart';
import '../../../model/choice_model/choice_model.dart';
import '../../../widgets/buttons/tile_button.dart';

class UserDataPage extends StatelessWidget {
  const UserDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    const tileSize = 100.0;

    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child){
      return
        Column(
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TileButton(
                  choiceModel: ChoiceModel(
                    icon: FontAwesomeIcons.mars,
                    title: "male",
                    groupValue: profileProvider.isGenderSelected,
                    selectedValue: true,
                  ),
                  tileSize: tileSize,
                  onGenderSelect: (){
                    profileProvider.onGenderSelect(true);
                  },
                ),
                TileButton(
                  choiceModel: ChoiceModel(
                      icon: FontAwesomeIcons.venus,
                      title: "female",
                      groupValue: profileProvider.isGenderSelected,
                      selectedValue: false
                  ),
                  tileSize: tileSize,
                  onGenderSelect: (){
                    profileProvider.onGenderSelect(false);
                  },
                )
              ],
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                 itemCount: 3,
                  itemBuilder: (context, index){
                return SeekBar(
                  profileProvider.age,
                  btnPlus: (){}, btnMinus: (){

                }, onChange: (newVal){
                  profileProvider.setBodySlider(newValue: newVal, index:1);
                }, title: "Age",unit: "years",);
              }, separatorBuilder: (context, item){
                return  const Divider(
                  indent: 20,
                endIndent: 20,
                );
              },),
            )

          ],
        );
    });
  }
}
