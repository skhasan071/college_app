import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QAPage extends StatefulWidget {
  const QAPage({super.key});

  @override
  _QAPageState createState() => _QAPageState();
}

class _QAPageState extends State<QAPage> {
  final List<Question> _questions = [
    Question(
      question: 'What are the admission requirements for CS major?',
      user: 'Sarah M.',
      time: '2h ago',
      upvotes: '24',
      downvotes: '12',
      answer:
          'The CS program requires strong math background and programming experience...',
    ),
    Question(
      question: 'How\'s the campus life during weekends?',
      user: 'Mike R.',
      time: '5h ago',
      upvotes: '18',
      downvotes: '8',
      answer: 'Weekend campus life offers various activities including...',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text(
          'Q&A - Harvard University',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search questions',
                prefixIcon: const Icon(
                  Icons.search,
                  size: 24,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _questions.length,
              separatorBuilder:
                  (context, index) => Divider(height: 1, color: Colors.grey),
              itemBuilder:
                  (context, index) => _QuestionItem(
                    question: _questions[index],
                    onAnswerPressed: () {
                      setState(() {
                        _questions[index].isAnswerVisible =
                            !_questions[index].isAnswerVisible;
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

  void _addQuestion(String questionText) {
    setState(() {
      _questions.insert(
        0,
        Question(
          question: questionText,
          user: 'New User',
          time: DateFormat('jm').format(DateTime.now()),
          upvotes: '0',
          downvotes: '0',
          answer: 'Sample answer for new question...',
        ),
      );
    });
  }

  void _showAddQuestionDialog() {
    final TextEditingController _controller = TextEditingController();

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
              height: MediaQuery.of(context).size.height * 0.3,
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter your question',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(16.0),
                ),
                maxLines: 8,
                style: TextStyle(fontSize: 16),
                keyboardType: TextInputType.multiline,
              ),
            ),

            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Black text for cancel
                  ),
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
                  if (_controller.text.isNotEmpty) {
                    _addQuestion(_controller.text);
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
  String upvotes;
  String downvotes;
  String answer;
  bool isAnswerVisible;

  Question({
    required this.question,
    required this.user,
    required this.time,
    required this.upvotes,
    required this.downvotes,
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
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    question.upvotes,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    question.downvotes,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (question.isAnswerVisible)
            Padding(
              padding: const EdgeInsets.only(left: 32, top: 8),
              child: Text(
                question.answer,
                style: TextStyle(
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
