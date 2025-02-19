class ClubEventModel {
  final String? id;
  final String clubDetailsId;
  final DateTime createdAt;
  final String sessionImages;
  final String sessionName;
  final String prizeGivingImage;
  final String prizeGivingTitle;

  ClubEventModel({
    this.id,
    required this.clubDetailsId,
    required this.createdAt,
    required this.sessionImages,
    required this.sessionName,
    required this.prizeGivingImage,
    required this.prizeGivingTitle,
  });

  Map<String, dynamic> toMap() {
    return {
      'club_details_id': clubDetailsId,
      'created_at': createdAt.toIso8601String(),
      'session_images': sessionImages,
      'session_name': sessionName,
      'prize_giving_image': prizeGivingImage,
      'prize_giving_title': prizeGivingTitle,
    };
  }

  factory ClubEventModel.fromMap(Map<String, dynamic> map) {
    return ClubEventModel(
      id: map['id'] ?? '',
      clubDetailsId: map['club_details_id'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
      sessionImages: map['session_images'] ?? '',
      sessionName: map['session_name'] ?? '',
      prizeGivingImage: map['prize_giving_image'] ?? '',
      prizeGivingTitle: map['prize_giving_title'] ?? '',
    );
  }
}
