
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';

import 'package:openvpn/presentations/page/main/server_page/allserver.dart';


class ServerPage extends StatefulWidget {
  const ServerPage({super.key});

  @override
  State<ServerPage> createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
        return Container(
         decoration: const BoxDecoration(
          color: Colors.white
              // gradient: LinearGradient(
              //     colors: state.isLoading
              //         ? [
              //             Colors.white,
              //             Colors.grey,
              //           ]
              //         : state.titleStatus == 'Connected'
              //             ? [Colors.white, Color(0xff5cffd1)]
              //             : [Colors.white, Colors.grey],
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter)
                  ),
          child: SafeArea(
            
            child: DecoratedBox(
                decoration: const BoxDecoration(
                    color: const Color(0xff1c1d21),
                 ),
                child: Scaffold(
                    backgroundColor:  Colors.transparent,
                    appBar: AppBar(
                      leading: TextButton(onPressed: () {
                        Navigator.pop(context);
                      }, child: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xffffff00),),),
                      title: const Text(
                        'All server',
                        style: TextStyle(color: Color(0xffffff00)),
                      ),
                      centerTitle: true,
                      // bottom: const TabBar(
                      //     indicatorSize: TabBarIndicatorSize.tab,
                      //     padding: EdgeInsets.symmetric(horizontal: 10),
                      //     labelStyle: TextStyle(color: Colors.white),
                      //     unselectedLabelColor: Colors.white,
                      //     dividerColor: Colors.transparent,
                      //     indicator: BoxDecoration(
                      //         borderRadius: BorderRadius.all(Radius.circular(10)),
                      //         gradient: LinearGradient(
                      //             colors: AppColors.listgradient,
                      //             begin: Alignment.centerLeft)),
                      //     tabs: [
                      //       Tab(
                      //         text: 'All server',
                      //       ),
                      //       Tab(
                      //         text: 'Premium server',
                      //       )
                      //     ]),
                    ),
                    body: //const TabBarView(children: [
                      const AllServer(),
                      // PretimunServer()
                      // Row(
                      //     children: [
                      //       CachedNetworkImage(
                      //         imageUrl: flag ? 'https://cdn.tgdd.vn/Files/2016/12/09/923744/khongxacdinh_213x379.jpg' : server.flag,
                      //         width: 35,
                      //       ),
                      //       const SizedBox(width: 16),
                      //       Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Row(
                      //             children: [
                      //               AppLabelText(
                      //                 text: server.country ?? '',
                      //               ),
                      //               const SizedBox(width: 8),
                      //               if (server.vip)
                      //                 const Icon(Icons.star, color: AppColors.colorYellow)
                      //             ],
                      //           ),
                      //           AppBodyText(
                      //             text: server.region ?? '',
                      //             size: 12,
                      //           )
                      //         ],
                      //       ),
                      //       const Spacer(),
                    //])
                    )),
          ),
        );
      }),
    );
  }
}
