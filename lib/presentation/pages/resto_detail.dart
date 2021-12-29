import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/common/constants.dart';
import 'package:flutter_resto_dicoding/data/api/api_service.dart';
import 'package:flutter_resto_dicoding/data/models/resto_model.dart';
import 'package:flutter_resto_dicoding/data/provider/db_provider.dart';
import 'package:flutter_resto_dicoding/data/provider/resto_detail_provider.dart';
import 'package:flutter_resto_dicoding/presentation/widgets/menu_card.dart';
import 'package:flutter_resto_dicoding/presentation/widgets/review_card.dart';
import 'package:provider/provider.dart';

class RestoDetail extends StatelessWidget {
  final String restoId;
  static const routeName = '/resto_detail';

  const RestoDetail({
    Key? key,
    required this.restoId,
  }) : super(key: key);

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<RestoDetailProvider>(
              create: (_) => RestoDetailProvider(
                  apiService: ApiService(), restoId: restoId),
            ),
            ChangeNotifierProvider<DbProvider>(
              create: (_) => DbProvider(),
            ),
          ],
          child: Consumer<RestoDetailProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.state == ResultState.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Hero(
                            tag: state.result.restaurant.pictureId,
                            child: Image.network(
                              'https://restaurant-api.dicoding.dev/images/large/' +
                                  state.result.restaurant.pictureId,
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 20,
                          child: Consumer<DbProvider>(
                            builder: (context, provider, child) {
                              return GestureDetector(
                                onTap: () async {
                                  final favoritedRestaurant = await provider
                                      .getRestaurantById(state.restoId);
                                  if (favoritedRestaurant is String) {
                                    if (favoritedRestaurant == 'Data Kosong') {
                                      final Restaurant restaurant = Restaurant(
                                          id: state.result.restaurant.id,
                                          name: state.result.restaurant.name,
                                          description: state
                                              .result.restaurant.description,
                                          pictureId:
                                              state.result.restaurant.pictureId,
                                          city: state.result.restaurant.city,
                                          rating:
                                              state.result.restaurant.rating);
                                      showMessage(context,
                                          'Restoran ditambahkan ke daftar favorit');
                                      provider.addRestaurant(restaurant);
                                      state.isFavorited = true;
                                    } else {
                                      showMessage(context, favoritedRestaurant);
                                    }
                                  } else {
                                    showMessage(context,
                                        'Restoran dihapus dari daftar favorit');
                                    provider.deleteRestaurant(state.restoId);
                                    state.isFavorited = false;
                                  }
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ImageIcon(
                                      const AssetImage(
                                          "assets/icons/heart.png"),
                                      color: (state.isFavorited)
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: -50,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.result.restaurant.name,
                                  style: kHeading1,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: ImageIcon(
                                        AssetImage(
                                            'assets/icons/map-marker.png'),
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      state.result.restaurant.city,
                                      style: kBody1,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                      clipBehavior: Clip.none,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32),
                          Text(
                            "Deskripsi",
                            style: kHeading2,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.result.restaurant.description,
                            textAlign: TextAlign.justify,
                            style: kBody1,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Menu Makanan",
                            style: kHeading2,
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    state.result.restaurant.menus.foods.length,
                                itemBuilder: (context, index) {
                                  return MenuCard(
                                      name: state.result.restaurant.menus
                                          .foods[index].name);
                                }),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Menu Minuman",
                            style: kHeading2,
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    state.result.restaurant.menus.drinks.length,
                                itemBuilder: (context, index) {
                                  return MenuCard(
                                      name: state.result.restaurant.menus
                                          .drinks[index].name);
                                }),
                          ),
                          const SizedBox(height: 16),
                          Text('Ulasan Konsumen', style: kHeading2),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                state.result.restaurant.customerReviews.length,
                            itemBuilder: (context, index) {
                              return ReviewCard(
                                  name: state.result.restaurant
                                      .customerReviews[index].name,
                                  review: state.result.restaurant
                                      .customerReviews[index].review,
                                  date: state.result.restaurant
                                      .customerReviews[index].date);
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state.state == ResultState.error) {
                return Center(child: Text(state.message));
              } else {
                return const Text('');
              }
            },
          ),
        ),
      ),
    );
  }
}
