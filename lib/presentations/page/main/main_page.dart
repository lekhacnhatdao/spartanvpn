import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';
import 'package:openvpn/presentations/page/main/history_page.dart';
import 'package:openvpn/presentations/page/main/settingpage.dart';
import 'package:openvpn/presentations/page/main/vpn_page.dart';
import 'package:openvpn/presentations/widget/impl/backround.dart';
import 'package:openvpn/utils/config.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return  SafeArea(
            bottom: false,
            child: Custombackground(
              widget: Scaffold(
                
                appBar: AppBar(
                  bottom: TabBar(
                    indicatorColor:  Color(0xfffe920e),
labelColor:const Color(0xfffe920e),
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.label
                   , controller: controller, tabs: const [
                    Icon(Icons.home),
                    Icon(Icons.access_alarm_rounded),
                    Icon(Icons.settings_rounded)
                  ]),
                  actions: [
                    
                   
                  ],
                  backgroundColor: Color(0xff1c1d21),
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     
                       const SizedBox(width: 3,),
                      Text('${ Config.appName.split(';').last}'  ,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                    
                  // BlocBuilder<AppCubit, AppState>(
                  //   builder: (context, state) {
                  //     return Container(
                  //       decoration: const BoxDecoration(
                  //         boxShadow: <BoxShadow>[
                  //           BoxShadow(
                  //             color: Colors.white12,
                  //             blurRadius: 10,
                  //           ),
                  //         ],
                  //         borderRadius: BorderRadius.all(Radius.circular(100)),
                  //       ),
                  //       padding: const EdgeInsets.symmetric(horizontal: 16),
                  //       child: CachedNetworkImage(
                  //         imageUrl: state.currentServer?.flag ?? 'assets/images/Frame.png',
                  //         height: 32,
                  //       ),
                  //     );
                  //   },
                  // )
                ),
                body:
                 TabBarView(controller:  controller, children: 
                [
 const VpnPage(),
 HistoryPage(),
 SettingPage()
                ]
                )
                         

                      
                    
              ),
            ));
      },
    );
  }
}
