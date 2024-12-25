class AuthRequest {
  String? phone;
  String? password;

  AuthRequest({this.phone, this.password});

  AuthRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}
