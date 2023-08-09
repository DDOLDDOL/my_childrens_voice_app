import 'package:my_childrens_voice_app/api/api.dart';
import 'package:my_childrens_voice_app/common/commons.dart';

class AuthenticationRepository {
  const AuthenticationRepository(this._client);

  final RestApiClient _client;

  Future<User> fetchUser() async {
    // final response = await _client.get(
    //   '',
    // );

    // if (response.hasException) throw response.exception!;

    return const User('김자녀', isCaregiver: true);
  }
}