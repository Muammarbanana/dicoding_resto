import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/common/constants.dart';

class MenuCard extends StatelessWidget {
  final String name;

  const MenuCard({
    Key? key,
    required this.name,
  }) : super(key: key);

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
