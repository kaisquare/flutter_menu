/*
Created by kaisquare on 1/25/19.
Copyright © 2019 kaisquare. All rights reserved.
Single App License
*/

import 'package:flutter/material.dart';
import 'tabs_bloc.dart';
import 'models/tab_item.dart';
import 'list_page.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {

  final TabsBloc _tabsBloc = TabsBloc();

  @override
  Widget build(BuildContext context) {

    Stream<List<TabItem>> tabsStream = _tabsBloc.tabs;

    List<TabItem> _tabs = _tabsBloc.initTabs;

    return StreamBuilder(
      initialData: _tabs,
      stream: tabsStream,
      builder: (_, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.red,
          ),
          home: HomeScreen(snapshot.data),
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  final List<TabItem> tabs;
  HomeScreen(this.tabs);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _tabController;

  List<Tab> _allPages;

  String _headerPath;

  @override
  void initState() {
    super.initState();
    int initIndex = 1;
    _tabController =
        TabController(vsync: this, length: widget.tabs.length, initialIndex: initIndex);
    _tabController.addListener(_onTabBar);
    _allPages = widget.tabs.map<Tab>((TabItem item) {
      return Tab(text: item.text);
    }).toList();
    _headerPath = widget.tabs.elementAt(initIndex).header;
  }

  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    setState(() {
      _tabController = TabController(
          vsync: this, length: widget.tabs.length, initialIndex: 1);
      _tabController.addListener(_onTabBar);
      _allPages = widget.tabs.map<Tab>((TabItem item) {
        return Tab(text: item.text);
      }).toList();
    });

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<TabItem> _tempTabItem = TabsBloc().initTabs;

  _onTabBar() {
    int index = _tabController.index;
    String path= _tempTabItem.elementAt(index).header;

    setState(() {
     _headerPath = path;
    });
  }

  @override
  Widget build(BuildContext context) {

    double _aspectHeight = (MediaQuery.of(context).size.width * .4);

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverPersistentHeader(
                delegate: _ImageHeader(_aspectHeight, _headerPath),
                pinned: false,
                floating: true,
              )
            ];
          },
          body: Column(
            children: <Widget>[
              Container(
                color: Colors.red[800],
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  tabs: _allPages,
                ),
              ),
              Flexible(
                child: TabBarView(
                  controller: _tabController,
                  children: widget.tabs.map<Widget>((TabItem item) {
                    switch (item.type) {
                      case 'list':
                        return ListPage();
                        break;
                      default:
                        return Center(
                          child: Text(item.type),
                        );
                    }
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageHeader extends SliverPersistentHeaderDelegate {
  _ImageHeader(this._height, this._path);

  final double _height;
  final String _path;

  @override
  double get maxExtent {
    return _height;
  }

  @override
  double get minExtent {
    return 0;
  }


  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return AspectRatio(
      aspectRatio: 2.5,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage(_path),
              fit: BoxFit.cover
            )),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
