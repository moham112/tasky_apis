class RegisterRequest {
  String? phone;
  String? password;
  String? displayName;
  int? experienceYears;
  String? address;
  String? level;

  RegisterRequest(
      {this.phone,
      this.password,
      this.displayName,
      this.experienceYears,
      this.address,
      this.level});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
    displayName = json['displayName'];
    experienceYears = json['experienceYears'];
    address = json['address'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['phone'] = phone;
    data['password'] = password;
    data['displayName'] = displayName;
    data['experienceYears'] = experienceYears;
    data['address'] = address;
    data['level'] = level;
    return data;
  }
}
