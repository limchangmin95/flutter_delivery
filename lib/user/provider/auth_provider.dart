import 'package:actual/common/view/root_tab.dart';
import 'package:actual/common/view/splash_screen.dart';
import 'package:actual/restaurant/view/basket_screen.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:actual/user/model/user_model.dart';
import 'package:actual/user/provider/user_me_provider.dart';
import 'package:actual/user/view/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => const RootTab(),
          routes: [
            GoRoute(
              path: 'restaurant/:rid',
              name: RestaurantDetailScreen.routeName,
              builder: (_, state) => RestaurantDetailScreen(
                id: state.pathParameters['rid']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => const LoginScreen(),
        ),
        GoRoute(
          path: '/basket',
          name: BasketScreen.routeName,
          builder: (_, __) => const BasketScreen(),
        ),
      ];

  void logout() {
    ref.read(userMeProvider.notifier).logout();
    notifyListeners();
  }

  // SplashScreen
  // 앱을 처음 시작했을때
  // 로그인 스크린으로 보내줄지
  // 홈화면으로 보내줄지 확인하는 과정이 필요하다.
  String? redirectLogic(BuildContext context, GoRouterState state) {
    print("redirectLogic START!!!!");
    final UserModelBase? user = ref.read(userMeProvider);

    final logginIn = state.location == '/login';

    print('user : $user');
    print('state.location : ${state.location}');
    print('logginIn : $logginIn');
    // 유저 정보가 없는데
    // 로그인중이면 그대로 로그인 페이지에 두고
    // 로그인중이 아니라면 로그인 페이지로 이동
    if (user == null) {
      return logginIn ? null : '/login';
    }

    // user가 null이 아님

    // UserModel
    // 사용자 정보가 있는 상태라면
    // 로그인중이거나 현재 위치가 SplashScreen이면
    // 홈으로 이동
    if (user is UserModel) {
      return logginIn || state.location == '/splash' ? '/' : null;
    }

    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }

    print('redirectLogic END!!!!');
    return null;
  }
}