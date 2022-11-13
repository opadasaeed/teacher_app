
import 'package:teacher_app/shared/local/useCases/shared_use_cases.dart';

class HomeModel {
  Data? data;

  HomeModel({this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
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
  List<Sliders>? sliders;
  List<Lessons2>? lessons;



  Data({this.sliders, this.lessons, });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(Sliders.fromJson(v));
      });
    }
    if (json['lessons'] != null) {
      lessons = <Lessons2>[];
      json['lessons'].forEach((v) {
        lessons!.add(Lessons2.fromJson(v));
      });
    }


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sliders != null) {
      data['sliders'] = sliders!.map((v) => v.toJson()).toList();
    }
    if (lessons != null) {
      data['lessons'] = lessons!.map((v) => v.toJson()).toList();
    }


    return data;
  }
}



class Sliders {
  String? name;
  String? image;

  Sliders({this.name, this.image});

  Sliders.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class Lessons2 {
  int? id;
  String? name;
  String? videoProvider;
  String? videoLink;
  String? encryptedVideoLink;
  String? image;
  String? price;
  String? price2;
  String? startDate;
  String? endDate;
  String? content;
  dynamic discount;

  bool? availableToday;
  int? remaining_days;
  String? views;
  int? exceed_percentage;
  int? bookingStatus;


  Lessons2({
    this.id,
    this.name,
    this.videoProvider,
    this.videoLink,
    this.remaining_days,
    this.price,
    this.price2,
    this.startDate,
    this.discount,
    this.endDate,
    this.content,

    this.availableToday,
    this.views,
    this.exceed_percentage,
    this.bookingStatus,


    this.encryptedVideoLink,
    this.image,

  });

  Lessons2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    discount = json['discount'];
    remaining_days = json['remaining_days'];
    exceed_percentage = json['exceed_percentage'];
    videoProvider = json['video_provider'];
    videoLink = json['video_link'];
    encryptedVideoLink = extractPayload(json['encrypted_video_link']);
    image = json['image'];
    price = json['price'].toString();
    price2 = json['price2'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    content = json['content'];
    views = json['views'].toString();

    availableToday = json['available_today'];
    bookingStatus = json['booking_status'];



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['discount'] = discount;
    data['remaining_days'] = remaining_days;
    data['exceed_percentage'] = exceed_percentage;
    data['video_provider'] = videoProvider;
    data['video_link'] = videoLink;
    data['encrypted_video_link'] = encryptedVideoLink;
    data['image'] = image;
    data['price'] = price;
    data['price2'] = price2;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['content'] = content;
    data['views'] = views;


    data['available_today'] = availableToday;
    data['booking_status'] = bookingStatus;

    return data;
  }
}

