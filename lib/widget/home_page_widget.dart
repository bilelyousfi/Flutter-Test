import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../apis/apis.dart';
import '../widget/custom_loading.dart';
import '../widget/horizontal_list_view.dart';
import '../widget/movie_selector.dart';

class HomePageWidget extends StatelessWidget {
  final Apis homeAPIS;
  final PageController pageController;

  const HomePageWidget({
    Key? key,
    required this.homeAPIS,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeAPIS.isLoading.value) {
        return const Center(child: CustomLoading());
      } else {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 250.0,
                width: double.infinity,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: homeAPIS.movies.length < 3 ? homeAPIS.movies.length : 3,
                  itemBuilder: (BuildContext context, int index) {
                    return movieSelector(context, pageController, homeAPIS.movies, index);
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              horizontalListView(homeAPIS.movies.sublist(3, 6), title: 'My List'),
              const SizedBox(height: 20.0),
              horizontalListView(homeAPIS.movies.sublist(6), title: 'Popular'),
            ],
          ),
        );
      }
    });
  }
}
