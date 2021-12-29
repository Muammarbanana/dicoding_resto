import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/common/constants.dart';
import 'package:flutter_resto_dicoding/common/navigation.dart';
import 'package:flutter_resto_dicoding/data/api/api_service.dart';
import 'package:flutter_resto_dicoding/data/provider/resto_search_provider.dart';
import 'package:flutter_resto_dicoding/presentation/pages/resto_detail.dart';
import 'package:flutter_resto_dicoding/presentation/widgets/resto_card.dart';
import 'package:flutter_resto_dicoding/presentation/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class RestoSearch extends StatelessWidget {
  const RestoSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchTextFormController =
        TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Pencarian',
          style: kHeading1.copyWith(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: ChangeNotifierProvider<RestoSearchProvider>(
          create: (_) => RestoSearchProvider(apiService: ApiService()),
          child: Consumer<RestoSearchProvider>(
            builder: (context, state, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cari-Cari Restoran",
                    style: kHeading2,
                  ),
                  Text(
                    "Kamu bisa cari restoran berdasarkan nama, menu, atau kategori di sini!",
                    style: kBody1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SearchBar(
                    controller: searchTextFormController,
                    hintText: 'Cari Restoran',
                    onChanged: (value) {
                      state.fetchSearchedResto(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                      child:
                          getSearchResultView(state, searchTextFormController)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getSearchResultView(RestoSearchProvider state,
      TextEditingController searchTextFromController) {
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
              Navigation.intentWithData(
                  RestoDetail.routeName, state.result.restaurants[index].id);
            },
            child: RestoCard(
                name: state.result.restaurants[index].name,
                description: state.result.restaurants[index].description,
                pictureId: state.result.restaurants[index].pictureId,
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
      return const Center(
        child: Text(''),
      );
    }
  }
}
