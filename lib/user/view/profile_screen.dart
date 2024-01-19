import 'package:actual/common/const/colors.dart';
import 'package:actual/user/provider/user_me_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
        onPressed: () {
          ref.read(userMeProvider.notifier).logout();
        },
        child: const Text(
          '로그아웃',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
