import 'package:fitnumbers2/screens/calculations_screen/calculation_screen.dart';
import 'package:fitnumbers2/screens/nutrition_screen/nutrition_screen.dart';
import 'package:fitnumbers2/screens/profile_screen/profile_screen.dart';
import 'package:fitnumbers2/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../model/menu/nav_model.dart';
import '../model/menu/screen_model.dart';
import '../widgets/navigators/side_nav.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation _degOneTranslationAnimation, _degTwoTranslationAnimation;
  late Animation _animationRotation;
  late Animation<Offset> _menuAnimation;
  late PageController _pageController;
  int _currentPage = 0;

  _onPageChange(int page) {
    setState(() {
      _pageController.animateToPage(page,
          duration: const Duration(microseconds: 500), curve: Curves.easeIn);

      _currentPage = page;
    });
  }

  final List<ScreenModel> _pages = [
    ScreenModel(
      page:  WelcomeScreen(),
      title: NavModel(
        icon: Icons.dashboard
      ),
    ),
    ScreenModel(
      page:  CalculationScreen(),
      title: NavModel(
          icon: Icons.calculate
      ),
    ),
    ScreenModel(
        page: NutritionScreen(),
        title: NavModel(
            icon: Icons.flatware
        )),
    ScreenModel(
        page: ProfileScreen(),
        title: NavModel(
            icon: Icons.person
        )),
    ScreenModel(
        page: Center(child: Text("Edit"),),
        title: NavModel(
            icon: Icons.edit
        )),
  ];

  hideTrigger() {
    if (_animationController.isCompleted) {
      setState(() {
        _animationController.reverse();
      });
    }
  }

  trigger() {
    setState(() {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0)
    ]).animate(_animationController);
    _degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0)
    ]).animate(_animationController);

    _animationRotation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _menuAnimation = Tween<Offset>(
        begin: const Offset(0.0, 0.0), end: const Offset(-0.5, 0.0))
        .animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutBack));

    super.initState();

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var leadingIconSize = 18.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SideNav(
              leading: IconButton(
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.menu,
                  size: leadingIconSize,
                ),
                onPressed: () async {
                  await Navigator.pushNamed(context, '/settings');
                },
              ),
              itemCount: _pages.length,
              titles: _pages.map((e) => e.title!).toList(),
              selectedItem: _currentPage,
              onTap: (int sel) {
                _onPageChange(sel);
                hideTrigger();
              },
            ),
            Expanded(
              child: Center(
                  key: widget.key,
                  child: PageView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: NeverScrollableScrollPhysics()),
                      itemCount: _pages.length,
                      controller: _pageController,
                      onPageChanged: _onPageChange,
                      itemBuilder: (context, index) {
                        return _pages
                            .map((e) => e.page!)
                            .toList()
                            .elementAt(index);
                      })),
            ),

          ],
        ),
      ),
    );
  }
}
