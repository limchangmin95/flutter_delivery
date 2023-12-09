import 'package:actual/common/const/data.dart';
import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/common/secure_storage/secure_storage.dart';
import 'package:actual/dio/dio.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/provider/restaurant_provider.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
    final dio = ref.watch(dioProvider);

    final res =
        await RestaurantRepository(dio, baseUrl: "http://$ip/restaurant")
            .pagenate();

    return res.data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);
    if (data.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          itemCount: data.length,
          separatorBuilder: (_, idx) {
            return const SizedBox(
              height: 16.0,
            );
          },
          itemBuilder: (_, idx) {
            final pItem = data[idx];

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RestaurantDetailScreen(
                      id: pItem.id,
                    ),
                  ),
                );
              },
              child: RestaurantCard.fromModel(
                model: pItem,
              ),
            );
          },
        ),
      ),
    );
  }
}
