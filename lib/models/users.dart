class Users {
  String? email;
  String? full_name;
  String? status;
  String? ttl;

  Users({this.email, this.full_name, this.status, this.ttl});

  Users.fromJson(Map<String, dynamic> json){
    email=json['email'];
    full_name=json['full_name'];
    status=json['status'];
    ttl=json['ttl'];
  }

}