// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:datacar/config/data_car_colors.dart';
import 'package:datacar/config/data_car_style.dart';
import 'package:datacar/initial_page.dart';
import 'package:datacar/pages/categories/categories_page.dart';
import 'package:datacar/pages/home/provider/home_provider.dart';
import 'package:datacar/pages/splash/providers/splash_provider.dart';
import 'package:datacar/services/authenticate_firebase.dart';
import 'package:datacar/services/shared_preferences_static.dart';
import 'package:datacar/widgets_utils/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({Key? key}) : super(key: key);

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {

  late HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {

    homeProvider = Provider.of<HomeProvider>(context);

    return appDrawer();
  }

  Widget appDrawer(){

    Widget divide = const Divider(color: Colors.grey,);
    double photoH = sizeH * 0.17;

    Widget photoW = Container(
      width: photoH,height: photoH,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: DataCarColors.primary
      ),
      child: Center(
        child: Icon(Icons.person,size: sizeH * 0.06,color: Colors.white),
      ),
    );

    if(homeProvider.userFirebase != null && homeProvider.userFirebase!.photoURL != null){

      photoW = ClipOval(
        child: CachedNetworkImage(
          width: photoH,
          height: photoH,
          fit: BoxFit.cover,
          imageUrl: homeProvider.userFirebase!.photoURL!,
          progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      );
    }

    return Container(
      width: sizeW * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.only( bottomLeft: Radius.circular(25.0),topLeft: Radius.circular(50.0),bottomRight: Radius.circular(0.0),topRight: Radius.circular(0.0)),
      ),
      child: Column(
        children: [
          SizedBox(height: sizeH * 0.05,),
          photoW,
          SizedBox(height: sizeH * 0.05,),
          titleDrawer(type: 1),divide,
          Expanded(child: Container()),
          titleDrawer(type: 0),
          SizedBox(height: sizeH * 0.05,),
        ],
      ),
    );
  }

  Widget titleDrawer({required int type}){
    String title = '';
    if(type == 1){ title = 'Mis categorias'; }
    if(type == 0){ title = 'Cerrar Sesión'; }

    return InkWell(
      child: Container(
        width: sizeW,
        margin: EdgeInsets.only(left: sizeW * 0.05, top: sizeH * 0.02,right: sizeW * 0.03),
        child: Text(title,textAlign: TextAlign.left,
            style: DataCarStyles().stylePrimary(size: sizeH * 0.02,
                color: DataCarColors.primary,
                fontWeight: FontWeight.bold)
        ),
      ),
      onTap: () async {
        Navigator.of(context).pop();
        if(type == 0){ await type0(); }
        if(type == 1){ await type1(); }
      },
    );
  }

  Future type1() async {
    Navigator.push(context,MaterialPageRoute<void>(
        builder: (context) => const CategoriesPage()
    ),);
  }

  Future type0() async {
    bool? res = await alertTitle(title: 'Cerrar Sesión?');
    if(res != null && res){
      await AuthenticateFirebaseUser().signOutFirebase();
      SharedPreferencesLocal.walletLogin = 0;
      Provider.of<SplashProvider>(contextHome,listen: false).initSplash();
    }
  }
}

