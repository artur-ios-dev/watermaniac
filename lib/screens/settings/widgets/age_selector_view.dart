import 'package:flutter/material.dart';

typedef void AgeChangedCallback(int age);

class AgeSelectorView extends StatefulWidget {
  final AgeChangedCallback changed;
  final int value;

  AgeSelectorView({Key key, @required this.value, @required this.changed});

  @override
  State<StatefulWidget> createState() {
    return _AgeSeletorViewSatte(value != null ? value : 0);
  }
}

class _AgeSeletorViewSatte extends State<AgeSelectorView> {
  int _value = 0;

  _AgeSeletorViewSatte(this._value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Age'.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17.0),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(
                  '($_value)',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Slider(
              onChanged: (double value) {
                setState(() {
                  _value = value.round();
                });
              },
              value: _value.toDouble(),
              min: 0.0,
              max: 100.0,
              divisions: 100,
              onChangeEnd: (double value) {
                widget.changed(value.round());
              },
            ),
          ),
        ],
      ),
    );
  }
}
