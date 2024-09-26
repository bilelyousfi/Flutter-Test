import 'package:flutter/material.dart';
import '../helper/global.dart';
import '../widget/custom_loading.dart';
import 'home_screen.dart';
import 'package:get/get.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Adding a delay of 2 seconds before navigating to HomeScreen
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to HomeScreen
      Get.off(() => const HomeScreen());  // This will remove SplashScreen from the stack
    });
  }
  @override
  Widget build(BuildContext context) {
    //initializing device size
    mq = MediaQuery.sizeOf(context);

    return Scaffold(
      //body
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            //for adding some space
            const Spacer(flex: 2),


            Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.all(mq.width * .05),
                child:
                Image.asset('assets/images/logo.png', width: mq.width * .4),
              ),
            ),

            //for adding some space
            const Spacer(),

            //lottie loading
            const CustomLoading(),

            //for adding some space
            const Spacer(),
          ],
        ),
      ),
    );
  }

}