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
              color: Color(0xffffff00),
            ),
          ),
          centerTitle: true,
          title: const AppTitleText(
            textAlign: TextAlign.center,
            text: Strings.benefitsOfThePremium,
            color: Color(0xffffff00),
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
                              'Key Features of Premium Access:',
                              style: TextStyle(
                                  color: Color(0xffffff00),
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
                          "Please be aware that your access to our services will be automatically renewed and charged to your designated payment method on record. This process will occur unless you take explicit action to cancel your subscription at least 24 hours prior to the expiration of the current billing cycle. To ensure you have full control over your ongoing subscription and to make any necessary adjustments, we encourage you to visit and review your Account Settings following your purchase. Here, you can manage your payment options, explore different subscription plans, and update your personal preferences to enhance your experience with our services. It's also the perfect place to stay informed about any upcoming changes or special offers that might interest you. Remember, managing your subscription is key to getting the most out of our offerings, and we're committed to making that process as straightforward and user-friendly as possible.",
                          style: TextStyle(color: Color(0xffffff00)),
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
                            color: Color(0xffffff00),
                            text:
                                'Technical issues are present. Service restoration is imminent. Kindly attempt access later',
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
                      backgroundColor: Colors.brown,
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
               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),  
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Assets.images.crown.image(height: 30),
                  const SizedBox(
                    width: 5,
                  ),
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
                  const SizedBox(width: 10),
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
                  const SizedBox(width: 5),
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
