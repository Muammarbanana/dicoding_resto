import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/common/constants.dart';

class MenuCard extends StatelessWidget {
  final String name;

  // ignore: use_key_in_widget_constructors
  const MenuCard({
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: kHeading2,
            ),
          ),
        ),
      ),
    );
  }
}
