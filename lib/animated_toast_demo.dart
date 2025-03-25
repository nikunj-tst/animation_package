import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

class AnimatedToast {
  static final AnimatedToast _instance = AnimatedToast._internal();
  late AnimationController controller;
  bool isInitialized = false;

  factory AnimatedToast() {
    return _instance;
  }

  AnimatedToast._internal();

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
      String? successImage,
      String? failureImage,
      Color? successColor,
      Color? failureColor,
      Color? headerColor,
      Color? descriptionColor,
      required bool isSuccess,
      void Function()? onTap,
      void Function()? onClose}) {
    ToastMsg.showSuccess(
        isSuccess: isSuccess,
        description: description,
        failureImage: failureImage,
        successImage: successImage,
        context: context,
        headerMsg: headerMsg,
        successColor: successColor,
        failureColor: failureColor,
        descriptionColor: descriptionColor,
        headerColor: headerColor,
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
    String? successImage,
    String? failureImage,
    Color? successColor,
    Color? headerColor,
    Color? descriptionColor,
    Color? failureColor,
    required bool isSuccess,
    required AnimationController controller,
    int duration = 3,
    void Function()? onTap,
    void Function()? onClose,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    BotToast.showCustomNotification(
      onClose: onClose,
      duration: Duration(seconds: duration),
      toastBuilder: (CancelFunc? cancelFunc) {
        return GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.02, left: screenWidth * 0.05),
            child: FutureBuilder(
              future: Future.delayed(const Duration(milliseconds: 500)),
              builder: (context, snapshot) {
                controller.reset();
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        isSuccess
                            ? successImage ?? "assets/success_splash.png"
                            : failureImage ?? "assets/failure_splash.png",
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.15,
                      )
                    ],
                  );
                } else {
                  controller.forward();

                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                                double width = Tween<double>(
                                        begin: 0, end: screenWidth * 0.8)
                                    .animate(controller)
                                    .value;

                                return Container(
                                  decoration: BoxDecoration(
                                      color: isSuccess
                                          ? successColor ??
                                              const Color(0XFF56A362)
                                          : failureColor ??
                                              const Color(0XFFD84F56),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8))),
                                  height: screenHeight * 0.08,
                                  width: width,
                                  child: controller.isCompleted
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.05),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: screenWidth * 0.05),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      headerMsg,
                                                      style: TextStyle(
                                                          color: headerColor ??
                                                              Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      description,
                                                      style: TextStyle(
                                                          color:
                                                              descriptionColor ??
                                                                  Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 10),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  cancelFunc!();
                                                },
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: const Icon(
                                                        Icons.close,
                                                        color: Colors.white)),
                                              )
                                            ],
                                          ),
                                        )
                                      : const Text(""),
                                );
                              },
                            ),
                            Positioned(
                                left: screenWidth * -0.06,
                                top: screenHeight * 0.007,
                                child: Image.asset(
                                  isSuccess
                                      ? successImage ??
                                          "assets/success_splash.png"
                                      : failureImage ??
                                          "assets/failure_splash.png",
                                  height: screenHeight * 0.07,
                                  width: screenWidth * 0.15,
                                )),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
