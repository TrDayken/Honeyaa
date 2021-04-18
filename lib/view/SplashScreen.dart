import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:honeyaa_clientside/view/startup/startup_viewmodel.dart';
import 'package:lottie/lottie.dart';

class StartupView extends HookWidget {
  const StartupView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController();
    return ViewModelBuilder<StartupViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: kcPrimaryColor,
        body: Center(
          child: Lottie.asset("assets/lottie/honey-bee.json", 
          controller: animationController, 
          onLoaded: (composition){
            animationController.addStatusListener((status) {
              if(status == AnimationStatus.completed){
                model.indicateAnimationComplete();
              }
            });

            animationController
            ..duration = composition.duration
            ..forward();
          }),
      ),
      onModelReady: (model) => SchedulerBinding.instance
          .addPostFrameCallback((_) => model.initialise()),
      viewModelBuilder: () => StartupViewModel(),
    );
  }
}
