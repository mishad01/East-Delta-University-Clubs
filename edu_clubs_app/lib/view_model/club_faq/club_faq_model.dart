class ClubFAQModel {
  final String? id;
  final String clubDetailsId;
  final DateTime createdAt;
  final String question;
  final String answer;

  ClubFAQModel({
    this.id,
    required this.clubDetailsId,
    required this.createdAt,
    required this.question,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    return {
      'club_details_id': clubDetailsId,
      'created_at': createdAt.toIso8601String(),
      'question': question,
      'answer': answer,
    };
  }

  factory ClubFAQModel.fromMap(Map<String, dynamic> map) {
    return ClubFAQModel(
      id: map['id'] ?? '',
      clubDetailsId: map['club_details_id'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
    );
  }
}
