class ClubAdvisorsModel {
  final String? id;
  final String? createdAt;
  final String clubDetailsId;
  final String advisorName;
  final String advisorType;
  final String advisorEmail;
  final String advisorInfoLink;
  final String advisorImageLink;

  ClubAdvisorsModel({
    this.id,
    this.createdAt,
    required this.clubDetailsId,
    required this.advisorName,
    required this.advisorType,
    required this.advisorEmail,
    required this.advisorInfoLink,
    required this.advisorImageLink,
  });

  Map<String, dynamic> toMap() {
    return {
      'club_details_id': clubDetailsId,
      'advisor_name': advisorName,
      'advisor_type': advisorType,
      'advisor_email': advisorEmail,
      'advisor_info_link': advisorInfoLink,
      'advisor_image_link': advisorImageLink
    };
  }

  factory ClubAdvisorsModel.fromMap(Map<String, dynamic> map) {
    return ClubAdvisorsModel(
      id: map['id'],
      createdAt: map['created_at'] ?? '',
      clubDetailsId: map['club_details_id'] ?? '',
      advisorName: map['advisor_name'] ?? '',
      advisorType: map['advisor_type'] ?? '',
      advisorEmail: map['advisor_email'] ?? '',
      advisorInfoLink: map['advisor_info_link'] ?? '',
      advisorImageLink: map['advisor_image_link'] ?? ' ',
    );
  }
}
