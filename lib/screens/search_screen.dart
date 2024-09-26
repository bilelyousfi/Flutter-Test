import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/screens/details_screen.dart';
import '../apis/apis.dart';
import '../models/movies_models.dart';

import '../widget/custom_loading.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Apis _apisController = Get.put(Apis()); // Initialize the Apis controller

  // Function to search movies using the Apis controller
  void _performSearch() {
    final searchTerm = _searchController.text.trim();
    if (searchTerm.isNotEmpty) {
      _apisController.searchMovies(searchTerm);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for a movie...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: _performSearch,
            ),
          ),
          onSubmitted: (value) {
            _performSearch();
          },
        ),
      ),
      body: Obx(() {
        // Observe the isLoading state from Apis controller
        if (_apisController.isLoading.value) {
          return Center(
            child: CustomLoading(), // Display your custom loading widget here
          );
        }

        if (_apisController.movies.isEmpty) {
          return Center(child: Text('No results found.'));
        }

        // Display the search results
        return ListView.builder(
          itemCount: _apisController.movies.length,
          itemBuilder: (context, index) {
            final movie = _apisController.movies[index];
            return ListTile(
              leading: movie.imageUrl.isNotEmpty
                  ? Image.network(movie.imageUrl, width: 50, fit: BoxFit.cover)
                  : Icon(Icons.movie),
              title: Text(movie.name),
              subtitle: Text(movie.year),
              onTap: () {
                // Navigate to the DetailsScreen when a movie is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(movie: movie),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
