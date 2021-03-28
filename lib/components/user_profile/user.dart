class Users {
  String userId;
  String name;
  String email;
  String phoneNumber;
  String status;

  Users({this.userId, this.name, this.email, this.phoneNumber, this.status});

  Users.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['status'] = this.status;
    return data;
  }
}