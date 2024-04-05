import 'package:flutter/cupertino.dart';
import 'package:reexamcore/screens/details/details_screen.dart';
import 'package:reexamcore/screens/edit/edit_screen.dart';
import 'package:reexamcore/screens/home/home_screen.dart';

Map<String,WidgetBuilder> routs ={
  '/':(context) => const HomeScreen(),
  'details':(context) => const DetailsScreen(),
  'edit':(context) => const EditScreen(),
};