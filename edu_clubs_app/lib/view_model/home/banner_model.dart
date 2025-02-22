class BannerModel {
  final String userId;
  final String bannerImage;
  final String bannerLink;

  BannerModel({
    required this.userId,
    required this.bannerImage,
    required this.bannerLink,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'banner_image': bannerImage,
      'banner_link': bannerLink,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      userId: map['user_id'] ?? '',
      bannerImage: map['banner_image'] ?? '',
      bannerLink: map['banner_link'] ?? '',
    );
  }
}
