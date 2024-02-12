import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:q_bot/core/view_models/home_view_model.dart';
import 'package:q_bot/ui/views/base_view.dart';
import 'package:q_bot/ui/widgets/q_card_waiting_widget.dart';
import 'package:q_bot/ui/widgets/q_card_widget.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseView<HomeViewModel>(
      onModelReady: (model) async {
        /// Always on display enabled
        WakelockPlus.enable();

        /// Calling all the necessary API through ViewModel
        await model.getCounter();

        await model.getCounterWaiting();

        await model.getCounterHold();

        /// Periodic timer for continuous API call
        model.myTime =
            Timer.periodic(const Duration(seconds: 10), (timer) async {
          await model.getCounter();

          await model.getCounterWaiting();

          await model.getCounterHold();
        });
      },
      onModelClose: (model) {
        /// Closing the timer
        model.myTime!.cancel();
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  /// Top Center main logo
                  ///
                  Image.asset(
                    'assets/images/eye.jpg',
                    height: size.width * 0.100,
                    width: size.width * 0.100,
                  ),
                  // SvgPicture.asset(
                  //   'assets/images/q_bot.svg',
                  //   height: size.width * 0.056,
                  //   width: size.width * 0.056,
                  // ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(),
                        SizedBox(
                          width: size.width * 0.55,
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFB9DA8C),
                                      // Color(0xFFB8DA8D),
                                      // Color(0xFF6BC3A5),
                                      // Color(0xFF67C3A7),
                                      Color(0xFF38BCBD),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    // stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                height: 60,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.24,
                                      child: const Center(
                                        child: Text(
                                          'TOKEN',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 24,
                                      width: 1,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.24,
                                      child: const Center(
                                        child: Text(
                                          'COUNTER',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ScrollLoopAutoScroll(
                                  scrollDirection: Axis.vertical,
                                  duration: const Duration(seconds: 500),
                                  gap: 0,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: model.counter.length,
                                      itemBuilder: (context, index) {
                                        // print(
                                        //     'Token ID at index $index: ${model.counter[index].tokenId}');
                                        return QCardWidget(
                                          token: model.counter[index].tokenId
                                              .toString(),
                                          counterNo: model
                                              .counter[index].counter
                                              .toString(),
                                          textSize: 40,
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.2,
                              height: 60,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFB9DA8C),
                                    Color(0xFF38BCBD),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  // stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'NEXT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                            ),
                            model.counterWaiting.length > 6
                                ? Expanded(
                                    child: SizedBox(
                                      width: size.width * 0.2,
                                      child: ScrollLoopAutoScroll(
                                        scrollDirection: Axis.vertical,
                                        duration: const Duration(seconds: 500),
                                        gap: 0,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              model.counterWaiting.length >
                                                      (model.counter.length * 2)
                                                  ? (model.counter.length * 2)
                                                  : model.counterWaiting.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) =>
                                              QCardWaitingWidget(
                                            token: model
                                                .counterWaiting[index].tokenId
                                                .toString(),
                                            counterCategory: model
                                                .counterWaiting[index]
                                                .tCounterCategories,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: SizedBox(
                                      width: size.width * 0.2,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              model.counterWaiting.length >
                                                      (model.counter.length * 2)
                                                  ? (model.counter.length * 2)
                                                  : model.counterWaiting.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: QCardWaitingWidget(
                                                    token: model
                                                        .counterWaiting[index]
                                                        .tokenId
                                                        .toString(),
                                                    counterCategory: model
                                                        .counterWaiting[index]
                                                        .tCounterCategories,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                                  )
                          ],
                        ),
                        Container(
                          width: 2,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  // Color(0xFFB8DA8D),
                                  // Color(0xFF6BC3A5),
                                  // Color(0xFF67C3A7),
                                  Color(0xFF38BCBD),
                                  Color(0xFFB9DA8C),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                // stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.2,
                              height: 60,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFB9DA8C),
                                    // Color(0xFFB8DA8D),
                                    // Color(0xFF6BC3A5),
                                    // Color(0xFF67C3A7),
                                    Color(0xFF38BCBD),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  // stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp,
                                ),
                                borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'HOLD',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                            ),
                            model.counterHold.length > 6
                                ? Expanded(
                                    child: SizedBox(
                                      width: size.width * 0.2,
                                      child: ScrollLoopAutoScroll(
                                        scrollDirection: Axis.vertical,
                                        duration: const Duration(seconds: 500),
                                        gap: 0,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: model.counterHold.length >
                                                  (model.counter.length * 2)
                                              ? (model.counter.length * 2)
                                              : model.counterHold.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) =>
                                              QCardWaitingWidget(
                                            token: model
                                                .counterHold[index].tokenId
                                                .toString(),
                                            counterCategory: model
                                                .counterHold[index]
                                                .tCounterCategories,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: SizedBox(
                                      width: size.width * 0.2,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: model.counterHold.length >
                                                  (model.counter.length * 2)
                                              ? (model.counter.length * 2)
                                              : model.counterHold.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: QCardWaitingWidget(
                                                    token: model
                                                        .counterHold[index]
                                                        .tokenId
                                                        .toString(),
                                                    counterCategory: model
                                                        .counterHold[index]
                                                        .tCounterCategories,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                                  )
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),

              /// Qbot logo in bottom right
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  'assets/images/q_bot.svg',
                  height: size.width * 0.028,
                  width: size.width * 0.028,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
