import 'package:flutter/material.dart';

import 'appBarWidget.dart';
import 'homeBody.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen>createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const AppBarWidget(),
      ),
      backgroundColor: Colors.lightGreenAccent,
      body: const HomeBody(),
    );
  }
}