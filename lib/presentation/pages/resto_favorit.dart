import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/common/constants.dart';
import 'package:flutter_resto_dicoding/common/navigation.dart';
import 'package:flutter_resto_dicoding/data/provider/db_provider.dart';
import 'package:flutter_resto_dicoding/presentation/pages/resto_detail.dart';
import 'package:flutter_resto_dicoding/presentation/pages/resto_search.dart';
import 'package:flutter_resto_dicoding/presentation/widgets/resto_card.dart';
import 'package:provider/provider.dart';

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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Restoran Favoritmu",
              style: kHeading2,
            ),
            Text(
              "Ini daftar restoran yang kamu favoritkan!",
              style: kBody1,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ChangeNotifierProvider<DbProvider>(
                create: (_) => DbProvider(),
                child: Consumer<DbProvider>(
                  builder: (context, state, _) {
                    state.getAllRestaurants();
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.restaurant.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigation.intentWithData(RestoDetail.routeName,
                                state.restaurant[index].id);
                          },
                          child: RestoCard(
                              name: state.restaurant[index].name,
                              description: state.restaurant[index].description,
                              pictureId: state.restaurant[index].pictureId,
                              city: state.restaurant[index].city,
                              rating: state.restaurant[index].rating),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
