class User {
  final String name;
  final String currency;

  const User({required this.name, required this.currency});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? 'Usuário',
      currency: json['currency'] ?? 'BRL',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'currency': currency};
  }
}
