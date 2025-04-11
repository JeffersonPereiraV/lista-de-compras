class Item {
  String name;
  String description;
  double price;
  bool checked;

  Item({
    required this.name,
    this.description = '',
    this.price = 0.0,
    this.checked = false,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      description: json['description'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      checked: json['checked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'checked': checked,
    };
  }
}
