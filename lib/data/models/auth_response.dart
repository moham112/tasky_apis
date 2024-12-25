class AuthResponse {
  String? sId;
  String? accessToken;
  String? refreshToken;

  AuthResponse({this.sId, this.accessToken, this.refreshToken});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }
}
