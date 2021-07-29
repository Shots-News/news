class UserInfoModel {
  final String? uid;
  final String? name;
  final String? email;
  final bool? isVerified;
  final String? phone;
  final String? userImg;

  UserInfoModel({this.uid, this.name, this.email, this.isVerified, this.phone, this.userImg});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      "verify": isVerified,
      "number": phone,
      'image': userImg,
    };
  }
}
