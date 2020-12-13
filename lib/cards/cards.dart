import 'package:flutter/material.dart';

class card extends StatefulWidget {
  @override
  _cardState createState() => _cardState();
}

class _cardState extends State<card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  child: Postcard(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget Postcard() {
  return Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        ListTile(
          leading: Icon(Icons.arrow_drop_down_circle),
          title: const Text('Card title 1'),
          subtitle: Text(
            'Secondary Text',
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
        Image.network(
            'https://image.shutterstock.com/image-photo/happy-african-american-woman-having-600w-1839418558.jpg'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            FlatButton(
              onPressed: () {
                // Perform some action
              },
              child: const Text('ACTION 1'),
            ),
            FlatButton(
              onPressed: () {
                // Perform some action
              },
              child: const Text('ACTION 2'),
            ),
          ],
        ),
      ],
    ),
  );
}
