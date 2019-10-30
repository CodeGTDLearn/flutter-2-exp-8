import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeFlatButton extends StatelessWidget {
  final Function _showDataPicker;
  final String textButton;

  AdaptativeFlatButton(this.textButton, this._showDataPicker);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid

        //Android Style
        ? FlatButton(
            child: Text(
              textButton,
              style: Theme.of(context).textTheme.button,
            ),
            onPressed: this._showDataPicker,
          )

        //IOs Style
        : CupertinoButton(
            child: Text(
              textButton,
              style: Theme.of(context).textTheme.button,
            ),
            onPressed: this._showDataPicker,
          );
  }
}
