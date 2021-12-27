import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/common/constants.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String review;
  final String date;

  // ignore: use_key_in_widget_constructors
  const ReviewCard({
    required this.name,
    required this.review,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: kHeading2,
            ),
            const SizedBox(width: 8),
            Text(
              date,
              style: kBody1,
            ),
            const SizedBox(height: 16),
            Text(
              review,
              style: kBody1,
            )
          ],
        ),
      ),
    );
  }
}
