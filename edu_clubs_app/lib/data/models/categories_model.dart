class ClubCategoryModel {
  final String? id;
  final String clubName;
  final String? createdAt;
  final String iconImg;
  final String description;

  ClubCategoryModel({
    this.id,
    required this.clubName,
    this.createdAt,
    required this.iconImg,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'club_name': clubName,
      'icon_img': iconImg,
      'description': description,
    };
  }

  factory ClubCategoryModel.fromMap(Map<String, dynamic> map) {
    return ClubCategoryModel(
      id: map['id'],
      clubName: map['club_name'] ?? '',
      createdAt: map['created_at'] ?? '',
      iconImg: map['icon_img'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
