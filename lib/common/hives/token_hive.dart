import 'package:hive_flutter/hive_flutter.dart';

class TokenHive {
  TokenHive._();

  static Future<TokenHive> build() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_tokenStore);

    return TokenHive._();
  }

  static late final Box<dynamic> _box;

  final _accessTokenKey = '_accessToken';
  final _refreshTokenKey = '_refreshToken';

  static const _tokenStore = '_tokenStore';

  static String get tokenStore => _tokenStore;

  String get accessToken => _box.get(_accessTokenKey, defaultValue: '')!;
  int? get refreshTokenId => _box.get(_refreshTokenKey, defaultValue: null);

  Future<void> setAccessToken(String token) => _box.put(_accessTokenKey, token);

  Future<void> setRefreshTokenId(int? tokenId) =>
      _box.put(_refreshTokenKey, tokenId);

  Future<void> setTokens(String accessToken, int? refreshTokenId) async {
    await setAccessToken(accessToken);
    await setRefreshTokenId(refreshTokenId);
  }

  Future<void> init() => setTokens('', null);
}
