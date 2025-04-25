import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QAPage extends StatefulWidget {
  final String collegeId;
  final String collegeName;

  const QAPage({super.key, required this.collegeId, required this.collegeName});

  @override
  _QAPageState createState() => _QAPageState();
}

class _QAPageState extends State<QAPage> {
  final List<Question> _questions = [];
  final List<Question> _filteredQuestions = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchQuestions();
    _searchController.addListener(filterQuestions);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void filterQuestions() {
    final keyword = _searchController.text.toLowerCase();
    setState(() {
      _filteredQuestions.clear();
      _filteredQuestions.addAll(
        _questions.where(
          (q) =>
              q.question.toLowerCase().contains(keyword) ||
              q.answer.toLowerCase().contains(keyword) ||
              q.user.toLowerCase().contains(keyword),
        ),
      );
    });
  }

  Future<void> fetchQuestions() async {
    final url = Uri.parse(
      'http://localhost:8080/api/questions/${widget.collegeId}',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          _questions.clear();
          _questions.addAll(
            data.expand((doc) {
              return (doc['questions'] as List).map((qa) {
                return Question(
                  question: qa['question'] ?? '',
                  answer: qa['answer'] ?? '',
                  user: qa['user'] ?? 'Anonymous',
                  time: DateFormat(
                    'jm',
                  ).format(DateTime.parse(qa['createdAt'])),
                );
              });
            }),
          );
          _filteredQuestions.clear();
          _filteredQuestions.addAll(_questions); // initially show all
        });
      } else {
        print('Failed to load questions: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching questions: $e');
    }
  }

  Future<void> _addQuestion(
    String collegeId,
    String userName,
    String questionText,
  ) async {
    final url = Uri.parse('http://localhost:8080/api/add-question');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'collegeId': collegeId,
          'user': userName,
          'question': questionText,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final createdQuestion = responseData['data']['questions'].last;

        final newQuestion = Question(
          question: createdQuestion['question'],
          answer: createdQuestion['answer'] ?? '',
          user: createdQuestion['user'] ?? 'Anonymous',
          time: DateFormat(
            'jm',
          ).format(DateTime.parse(createdQuestion['createdAt'])),
        );

        setState(() {
          _questions.insert(0, newQuestion);
          filterQuestions(); // refresh filtered list after adding
        });
      } else {
        print('Failed to add question: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding question: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Text(
          'Q&A - ${widget.collegeName}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search questions',
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          Expanded(
            child:
                _filteredQuestions.isEmpty
                    ? const Center(child: Text('No questions found.'))
                    : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredQuestions.length,
                      separatorBuilder:
                          (context, index) =>
                              const Divider(height: 1, color: Colors.grey),
                      itemBuilder:
                          (context, index) => _QuestionItem(
                            question: _filteredQuestions[index],
                            onAnswerPressed: () {
                              setState(() {
                                _filteredQuestions[index].isAnswerVisible =
                                    !_filteredQuestions[index].isAnswerVisible;
                              });
                            },
                          ),
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddQuestionDialog,
        icon: const Icon(Icons.add, size: 20),
        label: const Text(
          'Ask a Question',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }

  void _showAddQuestionDialog() {
    final TextEditingController _questionController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text(
              'Ask a Question',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 100,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _questionController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your question',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    maxLines: 8,
                    style: const TextStyle(fontSize: 16),
                    keyboardType: TextInputType.multiline,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  if (_questionController.text.isNotEmpty &&
                      _nameController.text.isNotEmpty) {
                    _addQuestion(
                      widget.collegeId,
                      _nameController.text,
                      _questionController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Submit', style: TextStyle(fontSize: 16)),
              ),
            ],
            actionsPadding: const EdgeInsets.all(16),
          ),
    );
  }
}

class Question {
  String question;
  String user;
  String time;
  String answer;
  bool isAnswerVisible;

  Question({
    required this.question,
    required this.user,
    required this.time,
    required this.answer,
    this.isAnswerVisible = false,
  });
}

class _QuestionItem extends StatelessWidget {
  final Question question;
  final VoidCallback onAnswerPressed;

  const _QuestionItem({required this.question, required this.onAnswerPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
                child: Icon(Icons.person, size: 30),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.question,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${question.user} • ${question.time}',
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Colors.grey[600],
                          ),
                        ),
                        TextButton(
                          onPressed: onAnswerPressed,
                          child: const Text(
                            'Answer',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (question.isAnswerVisible)
            Padding(
              padding: const EdgeInsets.only(left: 32, top: 8),
              child: Text(
                question.answer,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
