import 'package:flutter/material.dart';
import 'package:openvpn/presentations/page/main/privacy_page.dart';
import 'package:openvpn/presentations/page/main/terms_page.dart';
import 'package:openvpn/presentations/widget/impl/Customprenium.dart';
import 'package:openvpn/presentations/widget/impl/ratting.dart';
import 'package:openvpn/utils/config.dart';
import 'package:share_plus/share_plus.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1c1d21),
      appBar: AppBar(
        // leading: GestureDetector(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: const Icon(
        //       Icons.arrow_back_ios_new_outlined,
        //       color: Color(0xffffff00),
        //     )),
        automaticallyImplyLeading: false,
        title: const Text(
          'Setting',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Custompretimum(),
          SizedBox(
            height: 10,
          ),
          //ignore: lines_longer_than_80_chars

          // ignore: lines_longer_than_80_chars
          // SettingListTile(title: 'Recent'  ,svgWidget: Assets.icons.icClock.svg(), onPressed: (){
          //   // ignore: lines_longer_than_80_chars
          //   Navigator.push(context, MaterialPageRoute(builder: (_)=>  const HistoryPage()));
          // },),
          // ignore: lines_longer_than_80_chars

          // ignore: lines_longer_than_80_chars
          SettingListTile(
            title: 'Feedback',
            svgWidget: const Icon(Icons.sms, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const RatingDialog();
                },
              );
              // _launchURL(Config.storeAppUrl);
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return const RatingDialog();
              //   },
              // );
            },
          ),
          SettingListTile(
            title: 'Share app',
            svgWidget: const Icon(
              Icons.share_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              // ignore: lines_longer_than_80_chars
              Share.share(Config.storeAppUrl);
            },
          ),
          //ignore: lines_longer_than_80_chars

          // ignore: lines_longer_than_80_chars
          SettingListTile(
            title: 'Privacy Policy',
            svgWidget: const Icon(Icons.shield, color: Colors.white),
            onPressed: () {
              // ignore: lines_longer_than_80_chars
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PrivacyPage()));
            },
          ),
          SettingListTile(
            title: 'Terms of Use',
            svgWidget:
                const Icon(Icons.assignment_outlined, color: Colors.white),
            onPressed: () {
              // ignore: lines_longer_than_80_chars
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const TermsPage()));
            },
          ),
          // ignore: lines_longer_than_80_chars
          const SizedBox(
            height: 40,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Version: ${Config.version}',
              style: TextStyle(color: Colors.white, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}

class SettingListTile extends StatelessWidget {
  const SettingListTile({
    super.key,
    required this.svgWidget,
    required this.title,
    this.onPressed,
    this.color,
    this.ispre,
    this.islast,
  });
  final Widget svgWidget;
  final String title;
  final VoidCallback? onPressed;
  final Color? color;
  final bool? ispre;
  final bool? islast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.1),
            //     spreadRadius: 1, // Độ rộng mà drop shadow lan ra
            //     blurRadius: 3, // Độ mờ của drop shadow
            //     offset: const Offset(0, 3), // Vị trí của drop shadow
            //   )
            // ],
          ),
          child: ListTile(
            onTap: onPressed,
            leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Color(0xffFB5607), shape: BoxShape.circle),
                child: svgWidget),
            title: Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            trailing: InkWell(
                // ignore: lines_longer_than_80_chars
                child: islast ?? false
                    ? const Text(Config.version)
                    : ispre ?? false
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            // ignore: lines_longer_than_80_chars
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(0xffFB5607),
                            ),
                            child: const Text(
                              'Try now',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        : const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.black,
                          )),
          ),
        ),
      ],
    );
  }
}
// class RatingDialog extends StatefulWidget {
//   const RatingDialog({super.key});

//   @override
//   _RatingDialogState createState() => _RatingDialogState();
// }

// class _RatingDialogState extends State<RatingDialog> {
  // int _rating = 5;

  // @override
  // Widget build(BuildContext context) {
  //   return AlertDialog(
  //     backgroundColor: AppColors.scaffoldBackgroundColor,
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         ClipRRect(
  //           borderRadius: const BorderRadius.only(
  //             topLeft: Radius.circular(20),
  //             topRight: Radius.circular(20),
  //           ),
  //           child: Image.asset(
  //             Assets.images.imageRatebg.path,
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         const AppBodyText(
  //           text: 'Do you like ${Strings.appName} ?',
  //           textAlign: TextAlign.center,
  //           size: 20,
  //           color: AppColors.black,
  //         ),
  //         AppBodyText(
  //           text: Platform.isIOS
  //               ? 'Tap a star to rate on the App Store'
  //               : 'Tap a star to rate on the Google Play',
  //           textAlign: TextAlign.center,
  //           size: 14,
  //           color: AppColors.black,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             for (int i = 1; i <= 5; i++)
  //               GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     _rating = i;
  //                   });
  //                 },
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(5.0),
  //                   child: i <= _rating
  //                       ? Assets.icons.icStar.svg(width: 35)
  //                       : Assets.icons.icUnStar.svg(width: 35),
  //                 ),
  //               ),
  //           ],
  //         ),
  //         const SizedBox(height: 16),
  //         AppButtons(
  //           text: 'Submit',
  //           textColor: AppColors.whiteText,
  //           backgroundColor: AppColors.colorBlue,
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //             debugPrint('User rated: $_rating stars');
  //             if (_rating > 3) {
  //               _launchURL(Config.storeAppUrl);
  //               // StoreRedirect.redirect(
  //               //   androidAppId: "com.Padoventi.JackpotVPN",
  //               // );
  //             }
  //           },
  //         ),
  //         const SizedBox(height: 10),
  //         GestureDetector(
  //           onTap: () {
  //             Navigator.pop(context);
  //           },
  //           child: const Padding(
  //             padding: EdgeInsets.symmetric(vertical: 10.0),
  //             child: AppLabelText(
  //               size: 20,
  //               text: 'Not now',
  //               color: AppColors.colorBlue,
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
//}

