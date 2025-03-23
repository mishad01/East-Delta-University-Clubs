class ClubDetailsModel {
  final String? id;
  final String categoryId;
  final String clubName;
  final String whatWeDo;
  final String whyJoinUsReason1;
  final String whyJoinUsReason2;

  ClubDetailsModel({
    this.id,
    required this.categoryId,
    required this.clubName,
    required this.whatWeDo,
    required this.whyJoinUsReason1,
    required this.whyJoinUsReason2,
  });

  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'club_name': clubName,
      'what_we_do': whatWeDo,
      'why_join_us_reason1': whyJoinUsReason1,
      'why_join_us_reason2': whyJoinUsReason2,
    };
  }

  factory ClubDetailsModel.fromMap(Map<String, dynamic> map) {
    return ClubDetailsModel(
      id: map['id'],
      categoryId: map['category_id'] ?? '',
      clubName: map['club_name'] ?? '',
      whatWeDo: map['what_we_do'] ?? '',
      whyJoinUsReason1: map['why_join_us_reason1'] ?? '',
      whyJoinUsReason2: map['why_join_us_reason2'] ?? '',
    );
  }
}
