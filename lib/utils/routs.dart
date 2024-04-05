import 'package:flutter/cupertino.dart';
import 'package:reexamcore/screens/details/details_screen.dart';
import 'package:reexamcore/screens/home/home_screen.dart';
import 'package:reexamcore/screens/personal/personal_screen.dart';

Map<String,WidgetBuilder> myRouts={
  '/':(context) => const HomeScreen(),
  'details':(context) => const DetailsScreen(),
  'personal':(context) => const PersonalScreen(),

};