class ClubEventModel {
  final String? id;
  final String clubDetailsId;
  final String sessionImages;
  final String sessionName;

  ClubEventModel({
    this.id,
    required this.clubDetailsId,
    required this.sessionImages,
    required this.sessionName,
  });

  Map<String, dynamic> toMap() {
    return {
      'club_details_id': clubDetailsId,
      'session_images': sessionImages,
      'session_name': sessionName,
    };
  }

  factory ClubEventModel.fromMap(Map<String, dynamic> map) {
    return ClubEventModel(
      id: map['id'] ?? '',
      clubDetailsId: map['club_details_id'] ?? '',
      sessionImages: map['session_images'] ?? '',
      sessionName: map['session_name'] ?? '',
    );
  }
}
