import 'package:flutter/material.dart';
import '../models/movies_models.dart';
import '../screens/details_screen.dart';
import 'package:get/get.dart';


Widget movieSelector(BuildContext context, PageController pageController, List<MovieModel> movies, int index) {
  return AnimatedBuilder(
    animation: pageController,
    builder: (BuildContext context, Widget? child) {
      double value = 1;
      if (pageController.hasClients && pageController.position.haveDimensions) {
        value = (pageController.page ?? 0) - index;
        value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
      }
      return Center(
        child: SizedBox(
          height: Curves.easeInOut.transform(value) * 270.0,
          width: Curves.easeInOut.transform(value) * 420.0,
          child: child,
        ),
      );
    },
    child: GestureDetector(
      onTap: () {
        Get.to(() => DetailsScreen(movie: movies[index]));
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: const Offset(0.0, 4.0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Center(
                child: Hero(
                  tag: movies[index].imageUrl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      movies[index].imageUrl,
                      height: 220.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

