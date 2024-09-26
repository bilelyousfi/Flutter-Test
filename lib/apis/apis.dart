import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/movies_models.dart';

class Apis extends GetxController {
  var movies = <MovieModel>[].obs; // Observable list of MovieModel
  var isLoading = true.obs; // Observable loading state

  @override
  void onInit() {
    super.onInit();
    fetchMovies(); // Fetch movies when the ViewModel initializes
  }

  // Function to fetch movies from the API
  Future<void> fetchMovies() async {
    isLoading.value = true; // Set loading to true before fetch
    try {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
      if (response.statusCode == 200) {
        // Map the JSON response to MovieModel instances
        final List<dynamic> jsonResponse = json.decode(response.body);
        movies.value = jsonResponse.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        // Handle error here
        print('Failed to load movies');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false; // Set loading to false after fetch
    }
  }
  Future<void> searchMovies(String searchTerm) async {
    isLoading.value = true; // Set loading to true before fetch
    try {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$searchTerm'));
      if (response.statusCode == 200) {
        // Map the JSON response to MovieModel instances
        final List<dynamic> jsonResponse = json.decode(response.body);
        movies.value = jsonResponse.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        // Handle error here
        print('Failed to load search results');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false; // Set loading to false after fetch
    }
  }
}
