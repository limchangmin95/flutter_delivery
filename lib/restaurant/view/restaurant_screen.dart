import 'package:actual/common/const/data.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final res = await dio.get("http://$ip/restaurant",
        options: Options(headers: {"authorization": "Bearer $accessToken"}));

    return res.data["data"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder(
              future: paginateRestaurant(),
              builder: (context, AsyncSnapshot<List> res) {
                if (!res.hasData) {
                  return Container();
                }

                return ListView.separated(
                  itemCount: res.data!.length,
                  separatorBuilder: (_, idx) {
                    return const SizedBox(
                      height: 16.0,
                    );
                  },
                  itemBuilder: (_, idx) {
                    final item = res.data![idx];

                    final pItem = RestaurantModel.fromJson(item);

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const RestaurantDetailScreen(),
                          ),
                        );
                      },
                      child: RestaurantCard.fromModel(
                        model: pItem,
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
