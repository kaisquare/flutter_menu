import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/tab_item.dart';

class TabsBloc {

  // tabs data structure and offline assets
  final List<TabItem> _tabs = <TabItem>[
    TabItem(text: 'About', type: 'about', header: 'assets/header-about.jpg'),
    TabItem(text: 'List', type: 'list', header: 'assets/header-list.jpg'),
    TabItem(text: 'Grid', type: 'grid', header: 'assets/header-grid.jpg'),
  ];

  StreamController<List<TabItem>> _tabsController =
      StreamController<List<TabItem>>();

  // obtain new data from firebase
  TabsBloc() {
    Firestore.instance.collection('tabs').snapshots().listen((snapshot) {
      _tabsController.sink.add(
        snapshot.documents.map((doc) {
          return TabItem(
            text: doc['text'].toString(),
            type: doc['type'].toString(),
            // header: doc['header'].toString()
          );
        }).toList(),
      );
    });
  }

  Stream<List<TabItem>> get tabs => _tabsController.stream;

  List<TabItem> get initTabs => _tabs;

  void dispose() {
    _tabsController.close();
  }
}
