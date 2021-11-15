// ignore: camel_case_types
class userInfo {
  String username;
  String fname;
  String lname;
  String nickname;
  String dob;
  String phone;

  userInfo(
      {required this.username,
      required this.fname,
      required this.lname,
      required this.nickname,
      required this.dob,
      required this.phone});

  Map<String, dynamic> toJson() => {
        'username': username,
        'fname': fname,
        'lname': lname,
        'nickname': nickname,
        'dob': dob,
        'phone': phone
      };
}
