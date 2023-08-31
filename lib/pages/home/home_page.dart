import 'package:datacar/pages/home/provider/home_provider.dart';
import 'package:datacar/pages/home/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {

    homeProvider = Provider.of<HomeProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        //appBar: appBar(),
        key: homeProvider.scaffoldKeyHome,
        endDrawer: const DrawerHome(),
        body: Container(),
      ),
    );
  }
}

