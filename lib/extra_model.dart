class ExtraModel {
  final String title;
  final double price;
  bool isSelected;

  ExtraModel({
    required this.title,
    required this.price,
    this.isSelected = false,
  });

  factory ExtraModel.fromJson(Map<String, dynamic> data) {
    return ExtraModel(
      title: data['title'],
      price: data['price'].toDouble(),
      isSelected: data['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'isSelected': isSelected,
    };
  }
}
