class PrizeGivingCeremonyModel {
  final String userId;
  final String prizeGivingImage;
  final String prizeGivingDate;

  PrizeGivingCeremonyModel({
    required this.userId,
    required this.prizeGivingImage,
    required this.prizeGivingDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'prize_giving_image': prizeGivingImage,
      'prize_giving_date': prizeGivingDate,
    };
  }

  factory PrizeGivingCeremonyModel.fromMap(Map<String, dynamic> map) {
    return PrizeGivingCeremonyModel(
      userId: map['user_id'] ?? '',
      prizeGivingImage: map['prize_giving_image'] ?? '',
      prizeGivingDate: map['prize_giving_date'] ?? '',
    );
  }
}
