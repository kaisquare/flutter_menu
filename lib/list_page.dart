import 'package:flutter/material.dart';
import 'models/menu_item.dart';

// TODO: implement list bloc for list layout

class ListPage extends StatelessWidget {
  final List<Item> _items = <Item>[
    Item(title: 'Title', desc: 'Description', price: 'price'),
    Item(title: 'Title', desc: 'Description', price: 'price'),
    Item(title: 'Title', desc: 'Description', price: 'price'),
    Item(title: 'Title', desc: 'Description', price: 'price'),
    Item(title: 'Title', desc: 'Description', price: 'price'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      color: Colors.grey[200],
      child: ListView(
        children: _items.map<ItemCard>((Item item) {
          return ItemCard();
        }).toList(),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/combo.jpg'))
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Cheese Burger Combo',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Expanded(
                      child: Text(
                        'Cheese burger, medium frys, and medium drink',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(),
                        ),
                        Text('\$4.99', style: TextStyle(fontSize: 18, color: Colors.red[800]),),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
