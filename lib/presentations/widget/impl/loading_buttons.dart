import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:openvpn/resources/colors.dart';

class LoadingButtons extends StatelessWidget {
  const LoadingButtons({
    super.key,
    required this.isLoading,
    required this.icon,
    required this.text,
    this.backgroundColor = AppColors.accent,
    this.height = 52,
    this.onPressed,
    this.margin,
    required this.changeUI,
    required this.isDisconnect,
    this.duaration,
  });

  final bool isLoading;
  final bool changeUI;
  final bool isDisconnect;
  final Widget icon;
  final String text;
  final String? duaration;
  final Color backgroundColor;
  final Function()? onPressed;
  final EdgeInsetsGeometry? margin;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Align(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors:changeUI ? [Colors.white,Colors.white] : isLoading? [Colors.white,Colors.white]:  [Color(0xfffaa946), Color(0xfffe9006)], begin: Alignment.topLeft, end: Alignment.bottomRight),

 shape: BoxShape.circle
              ),
             
              
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // ignore: lines_longer_than_80_chars
                    gradient: LinearGradient(
                      colors: isLoading
                          ? [Color(0xff030200), Color(0xff030200)]
                          : changeUI
                              ? [Color(0xff030200), Color(0xff1030200)]
                              : [
                                 Color(0xff030200), Color(0xff030200)
                                ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                    )),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width/18,
            child: Align(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                padding: const EdgeInsets.all(23),
                child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) =>  LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: changeUI ? [Colors.white,Colors.white] : isLoading? [Colors.white,Colors.white]: [ Color(0xfffaa946), Color(0xfffe9006)],
                        ).createShader(bounds),
                    child: Align(
                        child: isLoading
                            ? Padding(
                              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/38),
                              child: LoadingAnimationWidget.fourRotatingDots(
                                color: Colors.red,
                                size: 80
                              
                              ),
                            )
                          :icon
                            
                            //  Container(
                            //     decoration: const BoxDecoration(
                            //         image: DecorationImage(
                            //           image:
                            //               AssetImage('assets/images/giphy.gif'),
                            //         ),
                            //         shape: BoxShape.circle),
                            //   )
                           )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
