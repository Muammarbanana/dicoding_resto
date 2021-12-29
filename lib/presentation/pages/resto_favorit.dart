import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/common/constants.dart';
import 'package:flutter_resto_dicoding/presentation/pages/resto_search.dart';

class RestoFavorit extends StatelessWidget {
  const RestoFavorit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "Restoran Favorit",
          style: kHeading1.copyWith(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RestoSearch()),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
