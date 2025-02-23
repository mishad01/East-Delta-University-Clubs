import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:edu_clubs_app/view_model/club_faq/club_faq_model.dart';

class AdminClubFAQView extends StatefulWidget {
  const AdminClubFAQView({super.key});

  @override
  _AdminClubFAQViewState createState() => _AdminClubFAQViewState();
}

class _AdminClubFAQViewState extends State<AdminClubFAQView> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;

  bool _isLoading = false;

  Future<void> _addClubFAQ() async {
    if (_questionController.text.isEmpty || _answerController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final newClubFAQ = ClubFAQModel(
      clubDetailsId:
          '656c5b7f-fbd1-4807-a620-b878c3c1c583', // Replace with actual ID
      createdAt: DateTime.now(),
      question: _questionController.text,
      answer: _answerController.text,
    );

    await _supabase.from('club_faq').insert(newClubFAQ.toMap());
    _clearFields();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('FAQ added successfully!')),
    );

    setState(() => _isLoading = false);
  }

  void _clearFields() {
    _questionController.clear();
    _answerController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club FAQs')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _questionController,
                      decoration: InputDecoration(
                        labelText: 'Question',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.question_answer),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _answerController,
                      decoration: InputDecoration(
                        labelText: 'Answer',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.edit),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _addClubFAQ,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
