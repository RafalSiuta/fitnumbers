import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../../providers/settings_provider/settings_provider.dart';
import '../../../widgets/buttons/large_switch_tile.dart';
import '../../../widgets/buttons/radio_tile.dart';
import '../../../widgets/buttons/switch_tile.dart';
import '../../../widgets/dividers/list_divider.dart';
import '../../../widgets/headers/sliver_header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var tilePadding = 5.0;
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child){
        return Container(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate:  LargeSliverHeader(
                  title: "theme mode",
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),),
              SliverToBoxAdapter(
                  child: SwitchTile(
                    textValue1: "light theme",
                    textValue2:"dark theme",
                    switchValue: settingsProvider.currentTheme,
                    onChanged: (newVal){
                      settingsProvider.onThemeChange(newVal);
                    },
                  )
              ),
              const SliverToBoxAdapter(
                child: ListDivider(),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate:  LargeSliverHeader(
                  title: "units",
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),),
              SliverToBoxAdapter(
                  child: SwitchTile(
                    textValue1: "metric units",
                    textValue2:"imperial units",
                    switchValue: true,
                    onChanged: (newVal){

                    },
                  )
              ),
              const SliverToBoxAdapter(
                child: ListDivider(),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate:  LargeSliverHeader(
                  title: "nutrition",
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),),

              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: settingsProvider.nutritionSettingsList.nutritionListCounter,
                          (context,index){
                        var data = settingsProvider.nutritionSettings[index];
                        return
                          SwitchTile(
                            textValue1: data.firstOption,
                            textValue2: data.secondOption,
                            switchValue: data.value,
                            onChanged: (newVal){
                              settingsProvider.onNutritionOption(newVal, index);
                            },
                          );
                        //   RadioTile(
                        //     title: "test ${index}",
                        //     description: "description ${index}",
                        //     value: index,
                        //     groupValue: 2,
                        //     paddingVertical: tilePadding,
                        //     onChoice: (newVal){
                        //     }
                        // );
                      })
              ),
              const SliverToBoxAdapter(
                child: ListDivider(),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: LargeSliverHeader(
                  title: "Body weight",
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),),

              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: settingsProvider.weightOptionList.weightCountingListCounter,
                          (context,index){
                        var data = settingsProvider.weightSettings[index];
                        return RadioTile(
                            title: data.firstOption,
                            description: data.secondOption,
                            value: index,
                            groupValue: settingsProvider.weightChoice,
                            paddingVertical: tilePadding,
                            onChoice: (newVal){
                              settingsProvider.onBodyWeightOption(newVal);
                            }
                        );
                      })
              ),
              const SliverToBoxAdapter(
                child: ListDivider(),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate:  LargeSliverHeader(
                  title: "Store data",
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),),

              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: 4,
                          (context,index){
                        return RadioTile(
                            title: "test ${index}",
                            description: "description ${index}",
                            value: index,
                            groupValue: 2,
                            paddingVertical: tilePadding,
                            onChoice: (newVal){
                            }
                        );
                      })
              ),
              const SliverToBoxAdapter(
                child: ListDivider(),
              ),
              const SliverToBoxAdapter(
                  child: SizedBox(height: 50,)
              ),
              // SliverPersistentHeader(
              //     pinned: true,
              //     delegate: MyCustomSliverHeader(
              //       maxHeight: sliverMaxHeight,
              //       minHeight: sliverMinHeight,
              //       child: Column(
              //         children: [
              //           LargeTitle(
              //             anim: anim,
              //             title: 'options_title_advanced',
              //           ),
              //         ],
              //       ),
              //     )),
              // SliverList(
              //   delegate: SliverChildBuilderDelegate((context, index) {
              //     if (index == 0) {
              //       return Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           // SettingsHeader(
              //           //   slideAnim: anim,
              //           //   scaleAnim: scaleAnim,
              //           //   title: 'sets_advanced',
              //           //   dialogInfo: 'sets_advanced_info',
              //           // ),
              //           SliverPersistentHeader(
              //               pinned: true,
              //
              //              ),
              //
              //           // ColumnBuilder(
              //           //     itemCount:
              //           //     model.nutriSettingsList.nutriOptionListCounter,
              //           //     itemBuilder: (context, index) {
              //           //       final nutriOption =
              //           //       model.nutriSettingsList.nutriOptionList[index];
              //           //       return SettingsCard(
              //           //         durationIndex: index,
              //           //         isSymbol: true,
              //           //         isSelectedOption: nutriOption.value,
              //           //         symbol: nutriOption.symbol,
              //           //         topLeftCorner: index == 0 ? true : false,
              //           //         iconSize: setsIconFontSize,
              //           //         icon: FontAwesomeIcons.bacon,
              //           //         firstLine: nutriOption.firstOption,
              //           //         secondLine: nutriOption.secondOption,
              //           //         child: ScaledSwitch(
              //           //             value: nutriOption.value,
              //           //             onSwitch: (bool newValue) {
              //           //               model.onNutriOption(newValue, index);
              //           //               Provider.of<ProfileProvider>(context)
              //           //                   .getNutriSettings(model
              //           //                   .nutriSettingsList.nutriOptionList);
              //           //             }),
              //           //       );
              //           //     }),
              //           const ListDivider()
              //         ],
              //       );
              //     } else if (index == 1) {
              //       return Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           // SettingsHeader(
              //           //   slideAnim: anim,
              //           //   scaleAnim: scaleAnim,
              //           //   title: 'sets_weight',
              //           //   dialogInfo: 'sets_weight_info',
              //           // ),
              //           // ColumnBuilder(
              //           //   itemCount:
              //           //   model.weightOptionList.weightCountingListCounter,
              //           //   itemBuilder: (context, index) {
              //           //     final data =
              //           //     model.weightOptionList.weightOptionTypeList[index];
              //           //     return SettingsCard(
              //           //       durationIndex: index,
              //           //       isSymbol: true,
              //           //       isSelectedOption: true,
              //           //       isSubtitle: true,
              //           //       topLeftCorner: index == 0 ? true : false,
              //           //       iconSize: setsIconFontSize,
              //           //       // cornerRadius: SizeConfig.radius * 0.1,
              //           //       symbol: data.symbol,
              //           //       firstLine: data.textOne,
              //           //       secondLine: data.textTwo,
              //           //       child: IconBtn(
              //           //         size: setsIconFontSize,
              //           //         icon: model.weightOptionList.weightOption == index
              //           //             ? Icons.radio_button_checked
              //           //             : Icons.radio_button_unchecked,
              //           //         color: model.weightOptionList.weightOption == index
              //           //             ? Theme.of(context).accentColor
              //           //             : Theme.of(context).canvasColor,
              //           //         fillColor:
              //           //         Theme.of(context).scaffoldBackgroundColor,
              //           //         function: () {
              //           //           model.onBodyWeightOption(index);
              //           //           Provider.of<ProfileProvider>(context)
              //           //               .getWeightOptionValue(index);
              //           //         },
              //           //       ),
              //           //     );
              //           //   },
              //           // ),
              //           const ListDivider()
              //         ],
              //       );
              //     } else if (index == 2) {
              //       return Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           // SettingsHeader(
              //           //   slideAnim: anim,
              //           //   scaleAnim: scaleAnim,
              //           //   title: 'sets_primary',
              //           //   dialogInfo: 'sets_primary_info',
              //           // ),
              //           // ColumnBuilder(
              //           //   itemCount: model.savingTypeList.savingTypeListCounter,
              //           //   itemBuilder: (context, index) {
              //           //     final data = model.savingTypeList.savingTypeList[index];
              //           //     return SettingsCard(
              //           //       durationIndex: index,
              //           //       topLeftCorner: index == 0 ? true : false,
              //           //       iconSize: setsIconFontSize,
              //           //       isSelectedOption: true,
              //           //       isSubtitle: true,
              //           //       icon: data.icon,
              //           //       firstLine: data.textOne,
              //           //       secondLine: data.textTwo,
              //           //       child: IconBtn(
              //           //         size: setsIconFontSize,
              //           //         icon: model.savingTypeList.save == index
              //           //             ? Icons.radio_button_checked
              //           //             : Icons.radio_button_unchecked,
              //           //         color: model.savingTypeList.save == index
              //           //             ? Theme.of(context).accentColor
              //           //             : Theme.of(context).canvasColor,
              //           //         fillColor:
              //           //         Theme.of(context).scaffoldBackgroundColor,
              //           //         function: () {
              //           //           model.onSavingType(index);
              //           //         },
              //           //       ),
              //           //     );
              //           //   },
              //           // ),
              //           const ListDivider()
              //         ],
              //       );
              //     } else {
              //       return Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           // SettingsHeader(
              //           //   slideAnim: anim,
              //           //   scaleAnim: scaleAnim,
              //           //   title: 'sets_delete',
              //           //   dialogInfo: 'sets_advanced_delete',
              //           // ),
              //           // SettingsCard(
              //           //   topLeftCorner: true,
              //           //   durationIndex: 0,
              //           //   iconSize: setsIconFontSize,
              //           //   isSelectedOption: true,
              //           //   isSubtitle: true,
              //           //   icon: Icons.delete_forever,
              //           //   firstLine: 'option_delete',
              //           //   secondLine: 'option_remove_all',
              //           //   child: IcoBtn(
              //           //     size: setsIconFontSize,
              //           //     icon: Icons.delete,
              //           //     function: () {
              //           //       CustomDialog.showDialog(
              //           //         context,
              //           //         'sets_delete',
              //           //         WarningDialog(
              //           //           title: 'are_you_sure',
              //           //           onTap: () {
              //           //             Provider.of<ProfileProvider>(context)
              //           //                 .deleteAll();
              //           //             Navigator.pop(context);
              //           //           },
              //           //         ),
              //           //       );
              //           //     },
              //           //   ),
              //           // ),
              //           SizedBox(
              //             height: 50,
              //           )
              //         ],
              //       );
              //     }
              //   }, childCount: 4),
              // )
            ],
          ),
        );
      },
    );
  }
}


