class Customer {
  String cid;
  String name;
  String email;
  String phone;
  String? businessName;
  String? city;
  Customer({
    required this.cid,
    required this.name,
    required this.email,
    required this.phone,
    this.businessName,
    this.city,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        cid: json['cid'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        businessName: json['businessName'],
        city: json['city']);
  }

  Map<String, dynamic> toJson() {
    return {
      'cid': cid,
      'name': name,
      'email': email,
      'phone': phone,
      'businessName': businessName,
      'city': city,
    };
  }
}
