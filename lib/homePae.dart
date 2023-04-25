import 'package:flutter/material.dart';

class QuizQuestion {
  String question;
  List<String> options;
  int answerIndex;

  QuizQuestion(
      {required this.question,
      required this.options,
      required this.answerIndex});
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int score = 0;
  int questionIndex = 0;
  List<QuizQuestion> quizQuestions = [
    QuizQuestion(
      question: 'What is the capital of Sri Lanka?',
      options: ['Colombo', 'Kandy', 'Galle', 'Jaffna'],
      answerIndex: 0,
    ),
    QuizQuestion(
      question: 'What is the national sport of Sri Lanka?',
      options: ['Cricket', 'Rugby', 'Soccer', 'Volleyball'],
      answerIndex: 0,
    ),
    // Add more questions here
  ];

  int? selectedOptionIndex;
  bool showCorrectAnswer = false;

  void checkAnswer(int userAnswerIndex) {
    if (userAnswerIndex == quizQuestions[questionIndex].answerIndex) {
      setState(() {
        score++;
      });
    }
    setState(() {
      selectedOptionIndex = userAnswerIndex;
      showCorrectAnswer = true;
    });
  }

  void nextQuestion() {
    setState(() {
      questionIndex++;
      selectedOptionIndex = null;
      showCorrectAnswer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sri Lanka Quiz'),
      ),
      body: questionIndex < quizQuestions.length
          ? Column(
              children: [
                Text(
                  quizQuestions[questionIndex].question,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                ...quizQuestions[questionIndex]
                    .options
                    .asMap()
                    .entries
                    .map(
                      (option) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ElevatedButton(
                          onPressed: selectedOptionIndex != null
                              ? null
                              : () => checkAnswer(option.key),
                          child: Text(option.value),
                          style: ElevatedButton.styleFrom(
                            primary: selectedOptionIndex == option.key
                                ? Colors.blue
                                : null,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                SizedBox(height: 20),
                showCorrectAnswer
                    ? Text(
                        quizQuestions[questionIndex]
                            .options[quizQuestions[questionIndex].answerIndex],
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      )
                    : SizedBox(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: selectedOptionIndex == null ? null : nextQuestion,
                  child: Text('Next'),
                ),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Quiz complete! You scored $score out of ${quizQuestions.length}.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Finish'),
                  ),
                ],
              ),
            ),
    );
  }
}
