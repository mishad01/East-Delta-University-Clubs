class ActivitiesModel {
  final String? id;
  final String clubDetailsId;
  final String recentOpeningDetails;
  final String recentOpeningLink;
  final String upcomingActivitiesDetails;
  final String upcomingActivitiesLink;
  final String? createdAt;

  ActivitiesModel({
    this.id,
    required this.clubDetailsId,
    required this.recentOpeningDetails,
    required this.recentOpeningLink,
    required this.upcomingActivitiesDetails,
    required this.upcomingActivitiesLink,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'club_details_id': clubDetailsId,
      'recent_opining_details': recentOpeningDetails,
      'recent_opining_link': recentOpeningLink,
      'upcoming_activities_details': upcomingActivitiesDetails,
      'upcoming_activities_link': upcomingActivitiesLink,
    };
  }

  factory ActivitiesModel.fromMap(Map<String, dynamic> map) {
    return ActivitiesModel(
      id: map['id'],
      clubDetailsId: map['club_details_id'] ?? '',
      recentOpeningDetails: map['recent_opining_details'] ?? '',
      recentOpeningLink: map['recent_opining_link'] ?? '',
      upcomingActivitiesDetails: map['upcoming_activities_details'] ?? '',
      upcomingActivitiesLink: map['upcoming_activities_link'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }
}
