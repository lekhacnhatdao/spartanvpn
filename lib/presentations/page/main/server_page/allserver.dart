import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvpn/domain/model/vpn/vpn_server_model.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';

import 'package:openvpn/presentations/route/app_router.gr.dart';
import 'package:openvpn/presentations/widget/impl/app_label_text.dart';
import 'package:openvpn/resources/assets.gen.dart';

class AllServer extends StatefulWidget {
  const AllServer({super.key});

  @override
  State<AllServer> createState() => _AllServerState();
}

class _AllServerState extends State<AllServer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      return Column(
        children: [
          // const AppLabelText(text: Strings.visualLocation),
          // const AppBodyText(
          //   text: Strings.visualLocationDes,
          //   color: AppColors.textSecondary,
          //   size: 10,
          // ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 16),
              itemBuilder: (context, index) {
                final server = state.servers[index];
                final isSelected = state.currentServer?.id == server.id;
                final free = state.servers[index].vip;
                final connecting = state.titleStatus == 'Connecting...' ||
                    state.titleStatus == 'Connected';
                final notconnected = state.titleStatus == 'Not connected';
                return _buildItem(server, isSelected, state.isVip, free,
                    connecting, notconnected);
              },
              itemCount: state.servers.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 3);
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildItem(VpnServerModel server, bool isSelected, bool isVip,
      bool free, bool connecting, bool notconnected) {
    return Container(
      height: 65,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xff020202),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1,
              color: isSelected
                  ? Colors.white
                  : Colors.white.withOpacity(0.2))),
      child: InkWell(
        onTap: isSelected
            ? null
            : () {
               
                  _handleItemTapped(server, isVip);
                
              },
        child: Container(
          height: 40,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                server.flag,
                height: 30,
              ),
            
             
                  Text(
                   
                         server.country.toString(),
                       
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                     
            
          
              if (isSelected)
                BlocBuilder<AppCubit, AppState>(
                  builder: (context, state) {
                    return AppLabelText(
                      color: state.colorStatus,
                      size: 10,
                    );
                  },
                ),
             
              
            
              server.vip && !isVip
                  ?Assets.images.crown.image(height: 25)
                  : isSelected
                      ? Icon(
                          Icons.offline_pin_rounded,
                          color: Color(0xffffff00),
                        )
                      : Icon(
                          Icons.radio_button_unchecked,
                          color: Colors.white.withOpacity(0.2),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleItemTapped(VpnServerModel server, bool isVip) {
    if (server.vip && !isVip) {
      AutoRouter.of(context).push(const PremiumRoute());
    } else {
      context.read<AppCubit>().autoConnect(server);
    }
  }
}
