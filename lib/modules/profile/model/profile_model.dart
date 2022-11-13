class ProfileModel {
  Data? data;

  ProfileModel({this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Profile? profile;
  List<Quizzes>? quizzes;
  List<Quizzes>? assignments;

  Data({this.profile, this.quizzes, this.assignments});

  Data.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    if (json['quizzes'] != null) {
      quizzes = <Quizzes>[];
      json['quizzes'].forEach((v) {
        quizzes!.add(Quizzes.fromJson(v));
      });
    }
    if (json['assignments'] != null) {
      assignments = <Quizzes>[];
      json['assignments'].forEach((v) {
        assignments!.add(Quizzes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    if (quizzes != null) {
      data['quizzes'] = quizzes!.map((v) => v.toJson()).toList();
    }
    if (assignments != null) {
      data['assignments'] = assignments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profile {
  String? name;
  String? email;
  String? phone;
  String? classroom_name;
  String? code;
  String? points;
  int? wallet;
  String? gender;

  Profile(
      {this.name,
      this.code,
      this.email,
      this.phone,
      this.points,
      this.classroom_name});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    classroom_name = json['classroom_name'];
    code = json['code'];
    wallet = json['wallet'];
    points = json['points'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['classroom_name'] = classroom_name;
    data['points'] = points;
    data['code'] = code;
    data['wallet'] = wallet;
    data['gender'] = gender;
    return data;
  }
}

class Quizzes {
  int? id;
  String? name;
  String? marks;
  int? isExam;
  int? total;
  String? percentage;

  Quizzes(
      {this.id,
      this.name,
      this.marks,
      this.isExam,
      this.total,
      this.percentage});

  Quizzes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    marks = json['marks'];
    isExam = json['is_exam'];
    total = json['total'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['marks'] = marks;
    data['is_exam'] = isExam;
    data['total'] = total;
    data['percentage'] = percentage;
    return data;
  }
}
