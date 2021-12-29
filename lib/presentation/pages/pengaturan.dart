import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/common/constants.dart';
import 'package:flutter_resto_dicoding/data/provider/scheduling_provider.dart';
import 'package:flutter_resto_dicoding/presentation/pages/resto_search.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({Key? key}) : super(key: key);

  @override
  _PengaturanState createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "Pengaturan",
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifikasi Restoran',
                  style: kHeading2,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    'Tampilkan rekomendasi restoran setiap pukul 11 siang secara acak',
                    style: kBody1,
                  ),
                )
              ],
            ),
            Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                if (scheduled.isScheduled != null) {
                  return Switch.adaptive(
                    value: scheduled.isScheduled!,
                    onChanged: (value) async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('switchValue', value);
                      scheduled.scheduledRestaurant(value);
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
