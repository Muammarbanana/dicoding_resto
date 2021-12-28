import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/common/constants.dart';

class RestoCard extends StatelessWidget {
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  const RestoCard({
    Key? key,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Hero(
              tag: pictureId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/small/' +
                      pictureId,
                  fit: BoxFit.fill,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: kHeading2,
                ),
                Row(
                  children: [
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: ImageIcon(
                        AssetImage('assets/icons/map-marker.png'),
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      city,
                      style: kBody1,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: ImageIcon(
                        AssetImage('assets/icons/star.png'),
                        color: kPrimary,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      rating.toString(),
                      style: kBody1,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
