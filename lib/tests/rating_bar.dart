import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBar extends StatefulWidget {
  const RatingBar({super.key, required int initialRating, required Axis direction, required bool allowHalfRating, required int itemCount, required EdgeInsets itemPadding, required Null Function(dynamic rating) onRatingUpdate});

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Rating Bar Fixed'),
              RatingBar(
                initialRating: 3,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
              
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
