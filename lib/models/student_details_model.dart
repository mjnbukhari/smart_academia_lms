import '../utlis/api_urls.dart';

class UserDetailsModel {
  bool? success;
  Student? student;
  String? message;

  UserDetailsModel({this.success, this.student, this.message});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    student =
        json['student'] != null ? Student.fromJson(json['student']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (student != null) {
      data['student'] = student!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Student {
  int? studentId;
  int? userId;
  int? parentId;
  String? avatar;
  String? name;
  String? rollNo;
  String? admissionNo;
  String? admissionDate;
  String? campus;
  String? clas;
  String? section;
  String? gender;
  String? email;
  String? role;
  List<Attendances>? attendances;
  List<Challans>? challans;
  List<Grades>? grades;
  Parent? parent;

  Student(
      {this.studentId,
      this.userId,
      this.parentId,
      this.avatar,
      this.name,
      this.rollNo,
      this.admissionNo,
      this.admissionDate,
      this.campus,
      this.clas,
      this.section,
      this.gender,
      this.email,
      this.role,
      this.attendances,
      this.challans,
      this.grades,
      this.parent});

  Student.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    userId = json['userId'];
    parentId = json['parentId'];
    avatar = json['avatar'] != null ? "${APIUrls.baseUrl}/${json['avatar']}" : null;
    name = json['name'];
    rollNo = json['rollNo'];
    admissionNo = json['admissionNo'];
    admissionDate = json['admissionDate'];
    campus = json['campus'];
    clas = json['clas'];
    section = json['section'];
    gender = json['gender'];
    email = json['email'];
    role = json['role'];
    if (json['Attendances'] != null) {
      attendances = <Attendances>[];
      json['Attendances'].forEach((v) {
        attendances!.add(Attendances.fromJson(v));
      });
    }
    if (json['Challans'] != null) {
      challans = <Challans>[];
      json['Challans'].forEach((v) {
        challans!.add(Challans.fromJson(v));
      });
    }
    if (json['Grades'] != null) {
      grades = <Grades>[];
      json['Grades'].forEach((v) {
        grades!.add(Grades.fromJson(v));
      });
    }
    parent =
        json['Parent'] != null ? Parent.fromJson(json['Parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = studentId;
    data['userId'] = userId;
    data['parentId'] = parentId;
    data['avatar'] = avatar;
    data['name'] = name;
    data['rollNo'] = rollNo;
    data['admissionNo'] = admissionNo;
    data['admissionDate'] = admissionDate;
    data['campus'] = campus;
    data['clas'] = clas;
    data['section'] = section;
    data['gender'] = gender;
    data['email'] = email;
    data['role'] = role;
    if (attendances != null) {
      data['Attendances'] = attendances!.map((v) => v.toJson()).toList();
    }
    if (challans != null) {
      data['Challans'] = challans!.map((v) => v.toJson()).toList();
    }
    if (grades != null) {
      data['Grades'] = grades!.map((v) => v.toJson()).toList();
    }
    if (parent != null) {
      data['Parent'] = parent!.toJson();
    }
    return data;
  }
}

class Attendances {
  int? attendanceId;
  int? studentId;
  String? date;
  String? status;

  Attendances({this.attendanceId, this.studentId, this.date, this.status});

  Attendances.fromJson(Map<String, dynamic> json) {
    attendanceId = json['attendanceId'];
    studentId = json['studentId'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attendanceId'] = attendanceId;
    data['studentId'] = studentId;
    data['date'] = date;
    data['status'] = status;
    return data;
  }
}

class Challans {
  int? challanId;
  int? studentId;
  String? month;
  String? amount;
  String? paymentStatus;
  String? challanImage;

  Challans(
      {this.challanId,
      this.studentId,
      this.month,
      this.amount,
      this.paymentStatus,
      this.challanImage});

  Challans.fromJson(Map<String, dynamic> json) {
    challanId = json['challanId'];
    studentId = json['studentId'];
    month = json['month'];
    amount = json['amount'];
    paymentStatus = json['paymentStatus'];
    challanImage = json['challanImage'] != null ? "${APIUrls.baseUrl}/${json['challanImage']}" : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['challanId'] = challanId;
    data['studentId'] = studentId;
    data['month'] = month;
    data['amount'] = amount;
    data['paymentStatus'] = paymentStatus;
    data['challanImage'] = challanImage;
    return data;
  }
}

class Grades {
  int? gradeId;
  int? studentId;
  String? name;
  String? photoOfGrade;
  String? type;

  Grades(
      {this.gradeId, this.studentId, this.name, this.photoOfGrade, this.type});

  Grades.fromJson(Map<String, dynamic> json) {
    gradeId = json['gradeId'];
    studentId = json['studentId'];
    name = json['name'];
    photoOfGrade = json['photoOfGrade'] != null ? "${APIUrls.baseUrl}/${json['photoOfGrade']}" : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gradeId'] = gradeId;
    data['studentId'] = studentId;
    data['name'] = name;
    data['photoOfGrade'] = photoOfGrade;
    data['type'] = type;
    return data;
  }
}

class Parent {
  int? parentId;
  String? password;
  String? name;
  String? avatar;
  String? phone;
  String? email;
  String? address;

  Parent(
      {this.parentId,
      this.password,
      this.name,
      this.avatar,
      this.phone,
      this.email,
      this.address});

  Parent.fromJson(Map<String, dynamic> json) {
    parentId = json['parentId'];
    password = json['password'];
    name = json['name'];
    avatar = json['avatar'] != null ? "${APIUrls.baseUrl}/${json['avatar']}" : null;
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parentId'] = parentId;
    data['password'] = password;
    data['name'] = name;
    data['avatar'] = avatar;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    return data;
  }
}
