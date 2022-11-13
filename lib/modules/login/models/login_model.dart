class LoginModel {
  Data? data;
  String? version;
  bool? success;
  int? status;

  LoginModel({this.data, this.version, this.success, this.status});

  LoginModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    version = json['version'];
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['version'] = version;
    data['success'] = success;
    data['status'] = status;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  dynamic wallet;
  String? createdAt;
  String? updatedAt;
  String? token;

  Data(
      {this.id,
      this.name,
      this.email,
      this.wallet,
      this.createdAt,
      this.updatedAt,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    wallet = json['wallet'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['wallet'] = wallet;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['token'] = token;
    return data;
  }
}
