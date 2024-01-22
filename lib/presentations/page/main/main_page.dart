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

    controller = TabController(length: 5, vsync: this);
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
                  actions: [
                    
                    const SizedBox(width: 10,),
                    GestureDetector(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingPage()));
                    } ,child: const Icon(Icons.settings_rounded, color: Color(0xffffff00),),),
                    const SizedBox(width: 10,), 
                  ],
                  backgroundColor: Color(0xff1c1d21),
                  leading: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) =>const HistoryPage()));
                      },
                      child: const Icon(Icons.access_time_outlined, color: Color(0xffffff00)),
                    ),
                  centerTitle: true,
                  title:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     
                       const SizedBox(width: 3,),
                      Text('${ Config.appName.split(';').last}'  ,
                        style: const TextStyle(color: Color(0xffffff00)),
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
                          const VpnPage(),

                      
                    
              ),
            ));
      },
    );
  }
}
