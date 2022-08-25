import 'package:flutter/material.dart';
import 'package:flop/screens/home/main.dart';
import 'package:flop/screens/home/search.dart';
import 'package:flop/screens/home/bibli.dart';

List<Widget> homeScreensOptions(context) {
  return <Widget>[
    home(context),
    search(context),
    bibli(context),
  ];
}
