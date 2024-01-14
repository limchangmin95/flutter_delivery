import 'package:actual/common/const/data.dart';
import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/common/model/pagination_params.dart';
import 'package:actual/common/repository/base_pagination_repository.dart';
import 'package:actual/dio/dio.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart'
    hide Headers; // dio의 헤더를 사용하지 않고 retrofit의 헤더를 사용한다는 의미
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = RestaurantRepository(
    dio,
    baseUrl: "http://$ip/restaurant",
  );

  return repository;
});

@RestApi()
abstract class RestaurantRepository
    implements IBasePaginationRepository<RestaurantModel> {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // http://$ip/restaurant/
  @override
  @GET("/")
  @Headers(
    {
      "accessToken": "true",
    },
  )
  Future<CursorPagination<RestaurantModel>> pagenate({
    @Queries() PaginationParams? params = const PaginationParams(),
  });

  // http://$ip/restaurant/:id
  @GET("/{id}")
  @Headers(
    {
      "accessToken": "true",
    },
  )
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
    // = @Path("id") required String id, 도 같음
  });
}
