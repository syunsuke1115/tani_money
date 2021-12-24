class UserModel {
  String? uid;
  String? email;
  String? nickname;

  UserModel({this.uid, this.email, this.nickname});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        nickname: map['nickname'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nickname': nickname,
    };
  }
}