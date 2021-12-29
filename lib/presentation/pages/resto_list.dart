import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/common/constants.dart';
import 'package:flutter_resto_dicoding/common/navigation.dart';
import 'package:flutter_resto_dicoding/data/api/api_service.dart';
import 'package:flutter_resto_dicoding/data/provider/resto_provider.dart';
import 'package:flutter_resto_dicoding/presentation/pages/resto_detail.dart';
import 'package:flutter_resto_dicoding/presentation/pages/resto_search.dart';
import 'package:flutter_resto_dicoding/presentation/widgets/resto_card.dart';
import 'package:provider/provider.dart';

class RestoList extends StatelessWidget {
  const RestoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: const ImageIcon(
          AssetImage('assets/icons/noodles.png'),
          color: Colors.black,
        ),
        title: Text(
          "RestoranKoe",
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
              "Restoran Terbaik",
              style: kHeading2,
            ),
            Text(
              "Ini nih restoran-restoran yang sangat direkomandasikan buat kamu!",
              style: kBody1,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ChangeNotifierProvider<RestoProvider>(
                create: (_) => RestoProvider(
                  apiService: ApiService(),
                ),
                child: Consumer<RestoProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.state == ResultState.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.result.restaurants.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigation.intentWithData(RestoDetail.routeName,
                                  state.result.restaurants[index].id);
                            },
                            child: RestoCard(
                                name: state.result.restaurants[index].name,
                                description:
                                    state.result.restaurants[index].description,
                                pictureId:
                                    state.result.restaurants[index].pictureId,
                                city: state.result.restaurants[index].city,
                                rating: state.result.restaurants[index].rating),
                          );
                        },
                      );
                    } else if (state.state == ResultState.noData) {
                      return Center(child: Text(state.message));
                    } else if (state.state == ResultState.error) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Text('');
                    }
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
