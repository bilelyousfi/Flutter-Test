class MovieModel {
  final String id;
  final String name;
  final String summary;
  final String imageUrl;
  final String country;
  final String year;
  final String length;
  final double rating;
  final List<String> genres; // Add genres as a list of strings

  MovieModel({
    required this.id,
    required this.name,
    required this.summary,
    required this.imageUrl,
    required this.country,
    required this.year,
    required this.length,
    required this.rating,
    required this.genres, // Add genres to the constructor
  });

  // Factory method to create a MovieModel from JSON
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    final show = json['show'];
    return MovieModel(
      id: show['id'].toString(),
      name: show['name'],
      summary: show['summary'] ?? 'No summary available',
      imageUrl: show['image'] != null ? show['image']['medium'] : '',
      country: show['network'] != null && show['network']['country'] != null
          ? show['network']['country']['name']
          : 'Unknown', // Extract country
      year: show['premiered'] != null ? show['premiered'].split('-')[0] : 'N/A', // Extract year from premiered date
      length: show['runtime'] != null ? show['runtime'].toString() : 'N/A', // Extract length (runtime)
      rating: (show['rating'] != null && show['rating']['average'] != null)
          ? show['rating']['average'].toDouble()
          : 0.0, // Extract rating, default to 0.0 if not available
      genres: show['genres'] != null
          ? List<String>.from(show['genres']) // Extract genres and convert to List<String>
          : [], // Default to an empty list if not available
    );
  }
}
