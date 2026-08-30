class Item {
  final String id;
  final String name;
  final String expiryDate;

  Item({required this.id, required this.name, required this.expiryDate});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'expiryDate': expiryDate};
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id:
          json['id'] as String? ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      name: json['name'] as String? ?? 'Unknown Item',
      expiryDate: json['expiryDate'] as String? ?? 'Unknown Date',
    );
  }
}
