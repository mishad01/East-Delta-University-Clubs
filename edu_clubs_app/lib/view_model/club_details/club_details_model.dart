class ClubDetailsModel {
  final String? id;
  final String categoryId;
  final String clubName;
  final String whatWeDo;
  final String whyJoinUs;
  final String recentOpenings;
  final String upcomingActivities;

  ClubDetailsModel({
    this.id,
    required this.categoryId,
    required this.clubName,
    required this.whatWeDo,
    required this.whyJoinUs,
    required this.recentOpenings,
    required this.upcomingActivities,
  });

  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'club_name': clubName,
      'what_we_do': whatWeDo,
      'why_join_us': whyJoinUs,
      'recent_openings': recentOpenings,
      'upcoming_activities': upcomingActivities,
    };
  }

  factory ClubDetailsModel.fromMap(Map<String, dynamic> map) {
    return ClubDetailsModel(
      id: map['id'],
      categoryId: map['category_id'] ?? '',
      clubName: map['club_name'] ?? '',
      whatWeDo: map['what_we_do'] ?? '',
      whyJoinUs: map['why_join_us'] ?? '',
      recentOpenings: map['recent_openings'] ?? '',
      upcomingActivities: map['upcoming_activities'] ?? '',
    );
  }
}
