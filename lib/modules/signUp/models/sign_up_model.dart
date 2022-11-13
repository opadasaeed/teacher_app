class SignUpModel {
  Data? data;
  String? version;
  bool? success;
  int? status;

  SignUpModel({data, version, success, status});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    version = json['version'];
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (data != null) {
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
  String? nationalId;
  String? gender;

  Data(
      {id,
      name,
      email,
      wallet,
      createdAt,
      updatedAt,
      gender,
      token,
      image,
      nationalId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nationalId = json['national_id'];
    email = json['email'];
    wallet = json['wallet'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['wallet'] = wallet;
    data['national_id'] = nationalId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['token'] = token;
    data['gender'] = gender;
    return data;
  }
}
