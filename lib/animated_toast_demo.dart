import 'package:flutter/material.dart';

class ToastManager {
  static final ToastManager _instance = ToastManager._internal();
  late AnimationController controller;
  bool isInitialized = false;

  factory ToastManager() {
    return _instance;
  }

  ToastManager._internal();

  void initialize(TickerProvider vsync) {
    if (!isInitialized) {
      controller = AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: 500),
      );
      isInitialized = true;
    }
  }

  void showSuccess(BuildContext context,
      {required String headerMsg,
      required String description,
      required bool isSuccess,
      void Function()? onTap,
      void Function()? onClose}) {
    ToastMsg.showSuccess(
        isSuccess: isSuccess,
        description: description,
        context: context,
        headerMsg: headerMsg,
        controller: controller,
        duration: 3,
        onClose: onClose,
        onTap: onTap);
  }
}

class ToastMsg {
  static void showSuccess({
    required BuildContext context,
    required String headerMsg,
    required String description,
    required bool isSuccess,
    required AnimationController controller,
    int duration = 3,
    void Function()? onTap,
    void Function()? onClose,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(top: 15, left: 22),
          child: FutureBuilder(
            future: Future.delayed(const Duration(milliseconds: 500)),
            builder: (context, snapshot) {
              controller.reset();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSuccess ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                );
              } else {
                controller.forward();

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AnimatedBuilder(
                            animation: controller,
                            builder: (context, child) {
                              double width = Tween<double>(begin: 0, end: 325)
                                  .animate(controller)
                                  .value;

                              return Container(
                                decoration: BoxDecoration(
                                    color: Color(
                                        isSuccess ? 0XFF56A362 : 0XFFD84F56),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8))),
                                height: 67,
                                width: width,
                                child: controller.isCompleted
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 18),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 18),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(headerMsg,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14)),
                                                  Text(description,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 10)),
                                                ],
                                              ),
                                            ),
                                            Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                ))
                                          ],
                                        ),
                                      )
                                    : const Text(""),
                              );
                            },
                          ),
                          Positioned(
                            left: -25,
                            top: 5,
                            child: Icon(
                              isSuccess ? Icons.check : Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          right: 20,
          left: 20),
    ));
    // BotToast.showCustomNotification(
    //   onClose: onClose,
    //   duration: Duration(seconds: duration),
    //   toastBuilder: (CancelFunc? cancelFunc) {
    //     return GestureDetector(
    //       onTap: onTap,
    //       child: Padding(
    //         padding: EdgeInsets.only(
    //             top: MySize.getScaledSizeHeight(15),
    //             left: MySize.getScaledSizeWidth(22)),
    //         child: FutureBuilder(
    //           future: Future.delayed(const Duration(milliseconds: 500)),
    //           builder: (context, snapshot) {
    //             controller.reset();
    //             if (snapshot.connectionState == ConnectionState.waiting) {
    //               return Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   CustomSvgPicture(
    //                     isSuccess
    //                         ? AppAsset.successSplash
    //                         : AppAsset.failureSplash,
    //                     height: MySize.getScaledSizeHeight(55),
    //                     width: MySize.getScaledSizeWidth(55),
    //                   )
    //                 ],
    //               );
    //             } else {
    //               controller.forward();
    //
    //               return Padding(
    //                 padding: EdgeInsets.symmetric(
    //                     horizontal: MySize.getScaledSizeWidth(18)),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   mainAxisSize: MainAxisSize.min,
    //                   children: [
    //                     Stack(
    //                       clipBehavior: Clip.none,
    //                       children: [
    //                         AnimatedBuilder(
    //                           animation: controller,
    //                           builder: (context, child) {
    //                             double width = Tween<double>(begin: 0, end: 325)
    //                                 .animate(controller)
    //                                 .value;
    //
    //                             return Container(
    //                               decoration: BoxDecoration(
    //                                   color: Color(
    //                                       isSuccess ? 0XFF56A362 : 0XFFD84F56),
    //                                   borderRadius: const BorderRadius.all(
    //                                       Radius.circular(8))),
    //                               height: MySize.getScaledSizeHeight(67),
    //                               width: width,
    //                               child: controller.isCompleted
    //                                   ? Padding(
    //                                       padding: EdgeInsets.symmetric(
    //                                           horizontal:
    //                                               MySize.getScaledSizeWidth(
    //                                                   18)),
    //                                       child: Row(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         children: [
    //                                           Padding(
    //                                             padding: EdgeInsets.only(
    //                                                 left: MySize
    //                                                     .getScaledSizeWidth(
    //                                                         18)),
    //                                             child: Column(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment.center,
    //                                               crossAxisAlignment:
    //                                                   CrossAxisAlignment.start,
    //                                               children: [
    //                                                 TypoGraphy.text(
    //                                                     textAlign:
    //                                                         TextAlign.start,
    //                                                     headerMsg,
    //                                                     color:
    //                                                         ColorConstant.white,
    //                                                     fontWeight:
    //                                                         FontWeight.w600,
    //                                                     fontSize: MySize
    //                                                         .getScaledSizeHeight(
    //                                                             14)),
    //                                                 TypoGraphy.text(
    //                                                     textAlign:
    //                                                         TextAlign.start,
    //                                                     description,
    //                                                     color:
    //                                                         ColorConstant.white,
    //                                                     fontWeight:
    //                                                         FontWeight.w500,
    //                                                     fontSize: MySize
    //                                                         .getScaledSizeHeight(
    //                                                             10)),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                           Align(
    //                                               alignment: Alignment.topRight,
    //                                               child: Padding(
    //                                                 padding: EdgeInsets.only(
    //                                                     top: MySize
    //                                                         .getScaledSizeHeight(
    //                                                             8)),
    //                                                 child:
    //                                                     const CustomSvgPicture(
    //                                                         color: ColorConstant
    //                                                             .white,
    //                                                         AppAsset.crossIcon),
    //                                               ))
    //                                         ],
    //                                       ),
    //                                     )
    //                                   : const Text(""),
    //                             );
    //                           },
    //                         ),
    //                         Positioned(
    //                           left: MySize.getScaledSizeWidth(-25),
    //                           top: MySize.getScaledSizeHeight(5),
    //                           child: CustomSvgPicture(
    //                             isSuccess
    //                                 ? AppAsset.successSplash
    //                                 : AppAsset.failureSplash,
    //                             height: MySize.getScaledSizeHeight(55),
    //                             width: MySize.getScaledSizeWidth(55),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               );
    //             }
    //           },
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
