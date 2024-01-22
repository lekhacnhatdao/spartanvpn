import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:openvpn/presentations/page/billing/premium_page.dart';
import 'package:openvpn/resources/assets.gen.dart';

class Custompretimum extends StatefulWidget {
  const Custompretimum({super.key});

  @override
  State<Custompretimum> createState() => _CustompretimumState();
}

class _CustompretimumState extends State<Custompretimum> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const PremiumPage()));
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Assets.images.bgPre.image().image, fit: BoxFit.cover),
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Attractive package click to\n explore',
                  style: TextStyle(color: Colors.pink),
                ),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Row(
                    children: [

                      Text(
                        'Go Premium',
                        style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                      SizedBox(width: 5,),
                       Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
            ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 10,
            ),
             SizedBox(
              width: MediaQuery.of(context).size.width / 10,
            ),
          ],
        ),
      ),
    );
  }
}
