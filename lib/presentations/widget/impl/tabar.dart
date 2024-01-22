import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:openvpn/resources/assets.gen.dart';

class Tabbarpage extends StatefulWidget {
  const Tabbarpage({super.key});

  @override
  State<Tabbarpage> createState() => _TabbarpageState();
}

class _TabbarpageState extends State<Tabbarpage> with TickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
     controller = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TabBarView(children: [
        Assets.images.security.image(),
        Assets.images.connecting.image()
      ]),
      bottom: TabBar(controller : controller ,tabs: [
        TextButton( onPressed: () { }, child: Icon(Icons.arrow_back)),
        TextButton(onPressed: () {}, child: Icon(Icons.arrow_forward_ios_outlined, ))
      ]),
    );
  }
}