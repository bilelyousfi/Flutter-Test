import 'package:flutter/material.dart';
import '../helper/html_utils.dart';
import '../helper/my_dialog.dart';
import '../models/movies_models.dart';
import '../widget/circular_clipper.dart';

class DetailsScreen extends StatefulWidget {
  final MovieModel movie;
  DetailsScreen({required this.movie});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // Get screen height
    double screenHeight = MediaQuery.of(context).size.height;
    int starCount = (widget.movie.rating / 2).round();

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0), // Keep the transformation
                child: Hero(
                  tag: widget.movie.imageUrl,
                  child: ClipShadowPath(
                    clipper: CircularClipper(),
                    shadow: Shadow(blurRadius: 60.0),
                    child: Container(
                      height: screenHeight * 0.45, // Increased height for better visibility
                      width: double.infinity,
                      child: ClipPath(
                        clipper: CircularClipper(),
                        child: Image(
                          height: screenHeight * 0.55, // Match the height here as well
                          width: double.infinity,
                          fit: BoxFit.contain, // Use BoxFit.contain to avoid clipping
                          image: NetworkImage(widget.movie.imageUrl), // Use NetworkImage for URLs
                        ),
                      ),
                    ),

                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.only(left: 30.0),
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.white,
                    ),
                    IconButton(
                      padding: EdgeInsets.only(left: 6.0),
                      onPressed: () =>  MyDialog.success("Movie Add To Favorite!!"),
                      icon: Icon(Icons.favorite_border),
                      iconSize: 30.0,
                      color: Colors.red,
                    ),
                  ],
              ),
              Positioned.fill(
                bottom: 10.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RawMaterialButton(
                    padding: EdgeInsets.all(10.0),
                    elevation: 12.0,
                    onPressed: () => MyDialog.info("Coming Soonnn !!"),
                    shape: CircleBorder(),
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.play_arrow,
                      size: 60.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 20.0,
                child: IconButton(
                  onPressed: () => MyDialog.info("Coming Soonnn !!"),
                  icon: Icon(Icons.add),
                  iconSize: 40.0,
                  color: Colors.black,
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 25.0,
                child: IconButton(
                  onPressed: () => MyDialog.info("Coming Soonnn !!"),
                  icon: Icon(Icons.share),
                  iconSize: 35.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        Padding(
         padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.movie.name.toUpperCase(),
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.0),
          Text(
            widget.movie.genres.join(', '), // Join the genres into a single string
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            '⭐ ' * starCount + '☆ ' * (5 - starCount), // Display filled stars based on the rating
            style: TextStyle(fontSize: 25.0),
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Year',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    widget.movie.year.toString(),
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Country',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    widget.movie.country.toUpperCase(),
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Length',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    '${widget.movie.length} min',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 25.0),
          Container(
            height: 396.0,
            child: SingleChildScrollView(
              child: Text(
                stripHtml(widget.movie.summary),
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
        ),
        ),
        ],
      ),
    );
  }
}
