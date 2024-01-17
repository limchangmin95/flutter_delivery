import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginReponse {
  final String refreshToken;
  final String accessToken;

  LoginReponse({
    required this.refreshToken,
    required this.accessToken,
  });

  factory LoginReponse.fromJson(Map<String, dynamic> json) =>
      _$LoginReponseFromJson(json);
}
