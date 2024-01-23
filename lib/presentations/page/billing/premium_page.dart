import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';

import 'package:openvpn/presentations/widget/impl/custompretimum.dart';
import 'package:openvpn/presentations/widget/index.dart';
import 'package:openvpn/resources/assets.gen.dart';
import 'package:openvpn/resources/colors.dart';
import 'package:openvpn/resources/strings.dart';

@RoutePage()
class PremiumPage extends StatefulWidget {
  const PremiumPage({Key? key}) : super(key: key);

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Scaffold(
        backgroundColor: const Color(0xff1c1d21),
        appBar: AppBar(
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.clear,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: const AppTitleText(
            textAlign: TextAlign.center,
            text: Strings.benefitsOfThePremium,
            color: Colors.white,
          ),
        ),
        body: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
                  
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10) +
                        const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.only(top: 0),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child:  Column(
                      children: [
                        const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Special service package:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        const CustomPretimum(
                          text: Strings.removeAds,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const CustomPretimum(
                          text: Strings.superFastServer,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const CustomPretimum(
                          text: Strings.unlockAllPremium,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const CustomPretimum(
                          text: Strings.customerSupport,
                        ),
                       
                        const SizedBox(height: 20),
                        _buildSubscriptionItem(state.subscriptions, state),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Your payment will include your account, and your subscription will be automatically renewed unless canceled at least 24 hours before the current period ends. You can control your subscriptions in the Account Settings after making a purchase",

                          style: TextStyle(color: Colors.white,),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.width / 3.3,
              child: state.subscriptions.isEmpty
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16) +
                          const EdgeInsets.only(bottom: 24),
                      child: const Column(
                        children: [
                          AppTitleText(
                            textAlign: TextAlign.center,
                            color: Colors.white,
                            text:
                                '',
                          )
                        ],
                      ),
                    )
                  : AppButtons(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      text: Strings.getPremiumNow,
                      textColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      onPressed: () async {
                        await context.read<AppCubit>().subscribe();
                      },
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSubscriptionItem(
      List<ProductDetails> subscriptions, AppState state) {
    // if (subscriptions.isEmpty) {
    //   // If subscriptions list is empty, provide default values for display
    //   subscriptions = [
    //     ProductDetails(
    //       id: 'default_id_1',
    //       title: 'No ads for a year',
    //       description: 'Default Description 1',
    //       price: '100.000đ',
    //       rawPrice: 100.00,
    //       currencyCode: 'VND',
    //     ),
    //   ];
    // }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: subscriptions.take(3).map((e) {
          return GestureDetector(
            onTap: () {
              context.read<AppCubit>().setSubscription(e);
            },
            child: Container(
              width: MediaQuery.of(context).size.width/1.1,
               padding:  EdgeInsets.symmetric(horizontal:12, vertical: 10),  
              decoration: BoxDecoration(
               
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(14),
                  // border: GradientBoxBorder(
                  //   gradient: LinearGradient(
                  //     colors: state.selectedSubscription?.id == e.id
                  //         ? AppColors.listgradient
                  //         : [Colors.transparent, Colors.transparent],
                  //     begin: Alignment.topCenter,
                  //     end: Alignment.bottomCenter,
                  //   ),
                  // ),
                  border: Border.all(
                      width: 1,
                      color: state.selectedSubscription?.id == e.id
                          ? const Color(0xffffff00)
                          : Colors.transparent)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 
                  Row(
                    children: [
                      Assets.images.crown.image(height: 30),
                                      
                             SizedBox(width: 8,),          
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                             state.selectedSubscription?.id == e.id
                          ? Text('${e.title.split('(').firstOrNull ?? ''}',
                              style: const TextStyle(
                                  color: Color(0xffffff00), fontSize: 15))
                          : Align(
                              child: Text(
                                e.title.split('(').firstOrNull ?? '',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          
                      state.selectedSubscription?.id == e.id
                          ? Text('${e.price}',
                              style: const TextStyle(
                                color: Color(0xffffff00),
                                fontSize: 20,
                              ))
                          : Text(
                              ' ${e.price}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: AppColors.primary,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  
     
                  state.selectedSubscription?.id == e.id ? const Icon(Icons.adjust, color: Color(0xffffff00),) :
                  Icon(
                          Icons.radio_button_unchecked,
                          color: Colors.white.withOpacity(0.2),
                        ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
