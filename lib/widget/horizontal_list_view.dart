import 'package:flutter/material.dart';
import '../models/movies_models.dart';
import '../screens/details_screen.dart';
import 'movie_card.dart';
import 'package:get/get.dart';
Widget horizontalListView(List<MovieModel> movies, {String title = '', bool showTitle = true}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (showTitle && title.isNotEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
      SizedBox(
        height: 220.0,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                MovieCard(
                  movie: movies[index],
                  onTap: () {
                    Get.to(() => DetailsScreen(movie: movies[index])); // Navigate to DetailsScreen

                  },
                ),
                Container(
                  width: 120.0,
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    movies[index].name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ],
  );
}
