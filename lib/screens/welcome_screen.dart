import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/misc/colors.dart';
import 'package:travel_app/widgets/app_large_text.dart';
import 'package:travel_app/widgets/responsive_button.dart';

import '../cubit/app_cubits.dart';
import '../widgets/app_text.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List images = [
    'welcome-one.png',
    'welcome-two.png',
    'welcome-three.png',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (_, index) {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("img/${images[index]}"),
                      fit: BoxFit.cover)),
              child: Container(
                  margin: const EdgeInsets.only(top: 150, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppLargeText(text: "Trips"),
                          AppText(
                            text: "Discover",
                            size: 30,
                          ),
                          SizedBox(height: size.height * 0.02),
                          Container(
                              width: size.width * 0.7,
                              child: AppText(
                                text:
                                    "Mountain hikes give you an incredible sense of freedom along with endurance test",
                                color: AppColors.textColor2,
                              )),
                          SizedBox(height: size.height * 0.033),
                          GestureDetector(
                              onTap: () {
                                BlocProvider.of<AppCubits>(context).getData();
                              },
                              child: Container(
                                width: 200,
                                child: Row(
                                  children: [
                                    ResponsiveButton(width: size.width * 0.3),
                                  ],
                                )))
                        ],
                      ),
                      Column(
                          children: List.generate(3, (indexDots) {
                        return Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            width: size.width * 0.013,
                            height: index == indexDots
                                ? size.height * 0.025
                                : size.height * 0.013,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: index == indexDots
                                    ? AppColors.mainColor
                                    : AppColors.mainColor.withOpacity(0.3)));
                      }))
                    ],
                  )),
            );
          }),
    );
  }
}
