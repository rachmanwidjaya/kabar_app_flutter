import 'dart:convert';

class UserEntity {
  final String? uid;
  final String? displayName;
  final String? email;
  bool emailVerified;
  final bool isAnonymous;
  final String? phoneNumber;
  final String? photoURL;
  String? accessToken;
  final String? refreshToken;
  final String? tenantId;
  final int followers;
  final int following;
  final int news;
  final String? bio;
  UserEntity({
    this.uid,
    this.displayName,
    this.email,
    this.emailVerified = true,
    this.isAnonymous = false,
    this.phoneNumber,
    this.photoURL,
    this.accessToken,
    this.refreshToken,
    this.tenantId,
    this.followers = 0,
    this.following = 0,
    this.news = 0,
    this.bio,
  });
  Map get toMap => {
        "uid": uid,
        "displayName": displayName,
        "email": email,
        "emailVerified": emailVerified,
        "isAnonymous": isAnonymous,
        "phoneNumber": phoneNumber,
        "photoURL": photoURL,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "tenantId": tenantId,
        "followers": followers,
        "following": following,
        "news": news,
        "bio": bio,
      };

  @override
  String toString() => jsonEncode(toMap);
}
