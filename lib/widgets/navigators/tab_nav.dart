import 'package:flutter/material.dart';

class TabNav extends StatefulWidget {
  const TabNav( {required this.list, required this.tabTitles,super.key});
  final List<Widget>? list;
  final List<String> tabTitles;

  @override
  State<TabNav> createState() => _TabNavState();
}

class _TabNavState extends State<TabNav> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  List<Tab>? tabs;

  final int _tabCounter = 0;

  @override
  void initState() {
    tabs = widget.tabTitles.map((e) => Tab(text: e, height: 40,)).toList();
    _tabController = TabController(initialIndex: _tabCounter, length: widget.list!.length, vsync: this);
    super.initState();

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: TabBar(
            indicatorWeight: .5,
              dividerColor: Theme.of(context).tabBarTheme.dividerColor,
              controller: _tabController,
              tabs: tabs!),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: widget.list!,
              // const BouncingScrollPhysics(
              // parent: BouncingScrollPhysics()),
          ),
        ),
      ],
    );
  }
}
