class AppVersionModel {
  int? version;
  bool? success;
  int? status;
  Data? data;

  AppVersionModel({this.version, this.success, this.status, this.data});

  AppVersionModel.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    success = json['success'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    data['success'] = this.success;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? latestAndroidVersion;
  String? latestIosVersion;

  Data({this.latestAndroidVersion,this.latestIosVersion});

  Data.fromJson(Map<String, dynamic> json) {
    latestAndroidVersion = json['latest_android_version'];
    latestIosVersion = json['latest_ios_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latest_android_version'] = this.latestAndroidVersion;
    data['latest_ios_version'] = this.latestIosVersion;
    return data;
  }
}

