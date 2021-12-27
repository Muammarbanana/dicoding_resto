import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/common/constants.dart';
import 'package:flutter_resto_dicoding/data/api/api_service.dart';
import 'package:flutter_resto_dicoding/data/provider/resto_detail_provider.dart';
import 'package:flutter_resto_dicoding/presentation/widgets/menu_card.dart';
import 'package:flutter_resto_dicoding/presentation/widgets/review_card.dart';
import 'package:provider/provider.dart';

class RestoDetail extends StatelessWidget {
  final String title;
  final String restoId;

  // ignore: use_key_in_widget_constructors
  const RestoDetail({
    required this.title,
    required this.restoId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          title,
          style: kHeading1.copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider<RestoDetailProvider>(
          create: (_) =>
              RestoDetailProvider(apiService: ApiService(), restoId: restoId),
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
                    Hero(
                      tag: state.result.restaurant.pictureId,
                      child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/large/' +
                            state.result.restaurant.pictureId,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
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
                                  AssetImage('assets/icons/map-marker.png'),
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
                          const SizedBox(height: 16),
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
