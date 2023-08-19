import 'package:fitnumbers2/widgets/carousel/indicators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../providers/profile_provider/profile_provider.dart';
import '../cards/slider_card.dart';

class ActivityCarousel extends StatelessWidget {
  const ActivityCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    var cardHeight = 120.0;
    var cardWidth = 250.0;
    // var titleFontSize = SizeConfig.mainSubtitleFontSize;
    // var indicatorsBtnSize =
    //     SizeConfig.smallIndicatorsSize; //mainTitleFontSize;
    // var cardRadius = SizeConfig.cardBorderRadius;
    // var margin = SizeConfig.mainHorizontalMargin;
    // var indicatorDotsSize = SizeConfig.mainNavIndicatorSize;
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child){

          return Stack(
            children:[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CarouselSlider.builder(
                  itemCount: profileProvider.userActivityLevel.activityLevelListCounter,
                  carouselController: profileProvider.carouselController,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                    return SliderCard(
                      icon: profileProvider.userActivityLevelList[itemIndex].icon,
                      description: profileProvider.userActivityLevelList[itemIndex].description,
                      color: profileProvider.activityLevel == itemIndex
                          ? Theme.of(context).indicatorColor
                          : Theme.of(context).unselectedWidgetColor,
                    );
                  },
                  options: CarouselOptions(
                    height: 100,
                    aspectRatio: 3/2,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, fun){
                      profileProvider.onActivityChange(index);
                    }
                  ),
            ),
                  SliderIndicators(
                    items: profileProvider.userActivityLevelList,
                    itemCount: profileProvider.userActivityLevel.activityLevelListCounter,
                    mapIndicators: (i, url) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                        child: Icon(
                          Icons.circle,
                          size: 6.0,
                          color: profileProvider.activityLevel == i
                              ? Theme.of(context).indicatorColor
                              : Theme.of(context).unselectedWidgetColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                height: cardHeight,

                //color: Colors.red,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child:
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.arrow_left),
                        onPressed: profileProvider.goToPrevious
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: cardWidth,
                      ),
                      flex: 5,
                    ),
                    Expanded(
                      child:  IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.arrow_right),
                        onPressed: profileProvider.goToNext
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ), //next/prev buttons

            ]
          );
        });
  }
}
