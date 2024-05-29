class RoomModel {
  final String title;
  final String description;
  final String capacity;
  bool isSelected;
  final String imagePath;
  final String view;
  final double price;

  RoomModel({
    required this.title,
    required this.description,
    required this.capacity,
    required this.isSelected,
    required this.imagePath,
    required this.view,
    required this.price,
  });

  factory RoomModel.fromJson(Map<String, dynamic> data) {
    return RoomModel(
      title: data['title'],
      description: data['description'],
      capacity: data['capacity'],
      isSelected: data['isSelected'],
      imagePath: data['imagePath'],
      view: data['view'],
      price: data['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'capacity': capacity,
      'isSelected': isSelected,
      'imagePath': imagePath,
      'view': view,
      'price': price,
    };
  }
}
