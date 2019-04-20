# Flutter Menu

Flutter experiment using Firebase Firestore database.  Image and text are dynamic.   The layout of the app is fixed and require App store updates.  

#### Dynamic tab title and header image:

```dart
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
```

```dart
class TabsBloc {

  // tabs data structure and offline assets
  final List<TabItem> _tabs = <TabItem>[
    TabItem(text: 'About', type: 'about', header: 'assets/header-about.jpg'),
    TabItem(text: 'List', type: 'list', header: 'assets/header-list.jpg'),
    TabItem(text: 'Grid', type: 'grid', header: 'assets/header-grid.jpg'),
  ];

  StreamController<List<TabItem>> _tabsController =
      StreamController<List<TabItem>>();

  // cloud firestore data structure
  // tabs -> 0 -> text: Location, type: about
  // tabs -> 1 -> text: Special, type: list
  // tabs -> 2 -> text: Burgers type: grid
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
```

![Screenshot](menu.gif)
