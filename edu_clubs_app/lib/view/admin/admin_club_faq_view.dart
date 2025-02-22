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
    setState(() {
      _isLoading = true;
    });

    final newClubFAQ = ClubFAQModel(
      clubDetailsId: '656c5b7f-fbd1-4807-a620-b878c3c1c583', // Replace with actual ID
      createdAt: DateTime.now(),
      question: _questionController.text,
      answer: _answerController.text,
    );

    await _supabase.from('club_faq').insert(newClubFAQ.toMap());
    _clearFields();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('FAQ added successfully!')),
    );

    setState(() {
      _isLoading = false;
    });
  }

  void _clearFields() {
    _questionController.clear();
    _answerController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club FAQs')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _questionController,
                decoration: const InputDecoration(labelText: 'Question')),
            TextField(
                controller: _answerController,
                decoration: const InputDecoration(labelText: 'Answer')),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _addClubFAQ,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
