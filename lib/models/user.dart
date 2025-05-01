class User {
  String name;
  String currency;

  User({required this.name, required this.currency});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'] ?? '', currency: json['currency'] ?? 'BRL');
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'currency': currency};
  }
}
