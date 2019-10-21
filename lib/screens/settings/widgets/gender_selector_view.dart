import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watermaniac/screens/settings/Gender.dart';

typedef void GenderChangedCallback(Gender gender);

class GenderSelectorView extends StatefulWidget {
  final GenderChangedCallback changed;
  final Gender value;

  GenderSelectorView({Key key, @required this.value, @required this.changed});

  @override
  State<StatefulWidget> createState() {
    return _GenderSelectorViewState(value);
  }
}

class _GenderSelectorViewState extends State<GenderSelectorView> {
  Gender _selectedGender;

  _GenderSelectorViewState(this._selectedGender);

  void _setGender(Gender gender) {
    widget.changed(gender);

    setState(() {
      _selectedGender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            'Gender'.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: FlatButton.icon(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: SvgPicture.asset(
                    'assets/icons/male.svg',
                    height: 20.0,
                    width: 20.0,
                    color: _selectedGender == Gender.male
                        ? const Color(0xFF6fa1ea)
                        : Colors.grey,
                  ),
                  onPressed: () {
                    _setGender(Gender.male);
                  },
                  label: Text('Male'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: FlatButton.icon(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: SvgPicture.asset(
                    'assets/icons/female.svg',
                    height: 20.0,
                    width: 20.0,
                    color: _selectedGender == Gender.female
                        ? const Color(0xFFf5bad3)
                        : Colors.grey,
                  ),
                  onPressed: () {
                    _setGender(Gender.female);
                  },
                  label: Text('Female'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}