class UserModel {
  final String? id;

  final String fullName;
  final String emailAddress;
  final int mobile;
  final int studentId;
  final String password;
  final String memberType;

  UserModel({
    this.id,
    required this.fullName,
    required this.emailAddress,
    required this.mobile,
    required this.studentId,
    required this.password,
    required this.memberType,
  });

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'email_address': emailAddress,
      'mobile': mobile,
      'student_id': studentId,
      'password': password,
      'member_type': memberType,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['full_name'] ?? '',
      emailAddress: map['email_address'] ?? '',
      mobile: map['mobile'] ?? '',
      studentId: map['student_id'] ?? 0,
      password: map['password'] ?? '',
      memberType: map['member_type'] ?? '',
    );
  }
}
