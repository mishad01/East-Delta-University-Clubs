class ClubFAQModel {
  final String? id;
  final String clubDetailsId;
  final String question;
  final String answer;

  ClubFAQModel({
    this.id,
    required this.clubDetailsId,
    required this.question,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    return {
      'club_details_id': clubDetailsId,
      'question': question,
      'answer': answer,
    };
  }

  factory ClubFAQModel.fromMap(Map<String, dynamic> map) {
    return ClubFAQModel(
      id: map['id'] ?? '',
      clubDetailsId: map['club_details_id'] ?? '',
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
    );
  }
}
