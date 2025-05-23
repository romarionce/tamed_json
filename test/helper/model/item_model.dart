class ItemModel {
  const ItemModel({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;

  @override
  String toString() => 'ItemModel(id: $id, title: $title)';
}
