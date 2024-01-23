import 'dart:io';

import 'package:flutter/material.dart';
import 'package:openvpn/presentations/widget/impl/app_body_text.dart';
import 'package:openvpn/utils/config.dart';
import 'package:url_launcher/url_launcher.dart';


Future<void> _launchURL(String link) async {
  final url = Uri.parse(link);
  await launchUrl(url, mode: LaunchMode.externalApplication);
}
class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 5;

  @override
  Widget build(BuildContext context) {
    return 
       Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/10, vertical: MediaQuery.of(context).size.height/4),
                 decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                 ),
    
         child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                
              ),
              child: AppBar(
                
                
                leading: TextButton(onPressed: (){
                Navigator.pop(context);
                
              },child: const Icon(Icons.clear_rounded, color: Colors.black,)),
              
          
              
              ),
            ),
            // ClipRRect(
            //   borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(20),
            //     topRight: Radius.circular(20),
            //   ),
            //   child: 
              

            // ),
           
            
            const SizedBox(
              height: 30,
            ),
            const AppBodyText(
              text: 'Are you fond of ${Config.appName} ?',
              textAlign: TextAlign.center,
              size: 20,
              color: Colors.black,
              
            ),
            const SizedBox(height: 10,),
            AppBodyText(
              text: Platform.isIOS
                  ? 'Select a star to leave a review on the App Store'
                  : 'Choose a star to give your feedback on Google Play',
              textAlign: TextAlign.center,
              size: 14,
              color:  Colors.black,
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = i;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: i <= _rating
                          ? 
                          const Icon(Icons.star, color:Colors.amber ,size: 50,) :  Icon(Icons.star, color: Colors.black.withOpacity(0.1),size: 50,),
                    ),
                  ),
              ],
            ),
         
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
  Navigator.of(context).pop();
                debugPrint('User rated: $_rating stars');
                if (_rating > 3) {
                  _launchURL(Config.storeAppUrl);
                  // StoreRedirect.redirect(
                  //   androidAppId: "com.Padoventi.JackpotVPN",
                  // );
                }
              },
           child: Container(
            height: 50,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Align(child: Text('Send Feedback', style: TextStyle(
color: Colors.white
            ),))),
            ),
          const SizedBox(height: 30,)
          ],),
       )
        ;
   
  }
}

