
class UserModel {
  int id;
  String name;
  String email;
  String phone;
  int orderCount;

  UserModel({
required this.id,
required this.name,
required this.email,
required this.phone,
required this.orderCount,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'orderCount': orderCount,
    };
  }

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['f_name'] ,
      email: json['email'] ,
      phone:json['phone'] ,
      orderCount: json['order_count'] ,
    );
  }

  
}
