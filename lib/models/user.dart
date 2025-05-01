class User {
  final String name;
  final String currency;

  User({required String name, required String currency})
    : name = name.trim(),
      currency = currency {
    if (name.isEmpty) throw ArgumentError('O nome não pode ser vazio');
    if (!['BRL', 'USD', 'EUR'].contains(currency)) {
      throw ArgumentError('Moeda inválida: $currency');
    }
  }

  User copyWith({String? name, String? currency}) {
    return User(name: name ?? this.name, currency: currency ?? this.currency);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'] ?? '', currency: json['currency'] ?? 'BRL');
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'currency': currency};
  }
}
