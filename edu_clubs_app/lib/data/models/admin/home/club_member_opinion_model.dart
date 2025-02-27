class ClubMemberOpinionModel {
  final String userId;
  final String clubMemberName;
  final String clubNameWithPosition;
  final String clubOpinionDescription;

  ClubMemberOpinionModel({
    required this.userId,
    required this.clubMemberName,
    required this.clubNameWithPosition,
    required this.clubOpinionDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': "4902e25b-18ab-43cd-8e86-5d0cd57cf737",
      'club_member_name': clubMemberName,
      'club_name_with_position': clubNameWithPosition,
      'club_opinion_description': clubOpinionDescription,
    };
  }

  factory ClubMemberOpinionModel.fromMap(Map<String, dynamic> map) {
    return ClubMemberOpinionModel(
      userId: map['user_id'] ?? '',
      clubMemberName: map['club_member_name'] ?? '',
      clubNameWithPosition: map['club_name_with_position'] ?? '',
      clubOpinionDescription: map['club_opinion_description'] ?? '',
    );
  }
}
