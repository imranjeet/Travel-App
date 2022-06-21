import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/cubit/app_cubit_states.dart';
import 'package:travel_app/cubit/app_cubits.dart';
import 'package:travel_app/misc/colors.dart';
import 'package:travel_app/widgets/app_large_text.dart';
import 'package:travel_app/widgets/app_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  var images = {
    "balloning.png": "balloning",
    "hiking.png": "Hiking",
    "kayaking.png": "Kayaking",
    "snorkling.png": "Snorkling",
  };

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
        body: BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      if (state is LoadedState) {
        var info = state.places;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // menu text
            Container(
              padding: const EdgeInsets.only(top: 60, left: 20),
              child: Row(children: [
                const Icon(Icons.menu, size: 30, color: Colors.black54),
                Expanded(child: Container()),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.withOpacity(0.5),

                    
                  ),
                  child: const Center(
                    child: Icon(Icons.person),
                  ),
                )
              ]),
            ),
            const SizedBox(height: 30),
            // discover text
            Container(
                margin: const EdgeInsets.only(left: 20),
                child: AppLargeText(text: "Discover", size: 24)),
            const SizedBox(height: 20),
            // tabbar
            Container(
                child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                  labelPadding: const EdgeInsets.only(left: 20, right: 20),
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator:
                      CircleTabIndicator(color: AppColors.mainColor, radius: 4),
                  tabs: const [
                    Tab(text: "Places"),
                    Tab(text: "Inspiration"),
                    Tab(text: "Emotions"),
                  ]),
            )),
            Container(
                padding: const EdgeInsets.only(left: 20),
                height: 300,
                width: double.maxFinite,
                child: TabBarView(controller: _tabController, children: [
                  ListView.builder(
                    itemCount: info.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<AppCubits>(context)
                              .detailScreen(info[index]);
                        },
                        child: Container(
                            margin: const EdgeInsets.only(right: 20, top: 10),
                            width: 200,
                            height: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "http://mark.bslmeiyu.com/uploads/${info[index].img}"),
                                    fit: BoxFit.cover))),
                      );
                    },
                  ),
                  Text("there"),
                  Text("bye"),
                ])),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppLargeText(text: "Explore more", size: 20),
                  AppText(text: "See all", color: AppColors.textColor1)
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
                height: 120,
                width: double.maxFinite,
                // margin: const EdgeInsets.only(left: 20),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (_, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin:
                                  const EdgeInsets.only(right: 20, left: 20),
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "img/${images.keys.elementAt(index)}"),
                                      fit: BoxFit.cover))),
                          Container(
                            child: AppText(
                              text: images.values.elementAt(index),
                              color: AppColors.mainColor,
                            ),
                          ),
                        ],
                      );
                    })),
          ],
        );
      } else {
        return Center(
            child: AppLargeText(
          text: "Something is wrong...",
        ));
      }
    }));
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, paint);
  }
}
