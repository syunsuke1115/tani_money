class UserModel {
  String? uid;
  String? email;
  String? nickname;
  bool? targetFrag;

  UserModel({this.uid,this.email, this.nickname,this.targetFrag});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        nickname: map['nickname'],
        targetFrag:map["targetFrag"],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nickname': nickname,
      "targetFrag": targetFrag,
    };
  }
}