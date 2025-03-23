class ClubEventModel {
  final String? id;
  final String clubDetailsId;
  final String sessionImages;
  final String sessionName;
  final String sessionDate;

  ClubEventModel({
    this.id,
    required this.clubDetailsId,
    required this.sessionImages,
    required this.sessionName,
    required this.sessionDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'club_details_id': clubDetailsId,
      'session_images': sessionImages,
      'session_name': sessionName,
      'session_date': sessionDate,
    };
  }

  factory ClubEventModel.fromMap(Map<String, dynamic> map) {
    return ClubEventModel(
      id: map['id'] ?? '',
      clubDetailsId: map['club_details_id'] ?? '',
      sessionImages: map['session_images'] ?? '',
      sessionName: map['session_name'] ?? '',
      sessionDate: map['session_date'] ?? '',
    );
  }
}
