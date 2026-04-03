import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(NumberQuizApp());
}

class NumberQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Number Quiz",
      theme: ThemeData(
        fontFamily: "Arial",
      ),
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff6a11cb), Color(0xff2575fc)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(Icons.quiz, size: 120, color: Colors.white),

              SizedBox(height: 20),

              Text(
                "Number Quiz",
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),

              SizedBox(height: 10),

              Text(
                "Test your math skills!",
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),

              SizedBox(height: 40),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding:
                    EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
                child: Text(
                  "Start Quiz",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizPage()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  int questionIndex = 0;
  int score = 0;

  int timeLeft = 10;
  Timer? timer;

  bool showFeedback = false;
  bool correctAnswer = false;

  List<Map<String, Object>> questions = [
    {
      "question": "What is 3 + 5?",
      "answers": [
        {"text": "8", "score": 1},
        {"text": "7", "score": 0},
        {"text": "6", "score": 0},
        {"text": "10", "score": 0},
      ]
    },
    {
      "question": "What is 6 × 2?",
      "answers": [
        {"text": "12", "score": 1},
        {"text": "10", "score": 0},
        {"text": "14", "score": 0},
        {"text": "8", "score": 0},
      ]
    },
    {
      "question": "What is 10 ÷ 2?",
      "answers": [
        {"text": "5", "score": 1},
        {"text": "3", "score": 0},
        {"text": "8", "score": 0},
        {"text": "6", "score": 0},
      ]
    },
    {
      "question": "What is 7 + 6?",
      "answers": [
        {"text": "13", "score": 1},
        {"text": "11", "score": 0},
        {"text": "14", "score": 0},
        {"text": "10", "score": 0},
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    questions.shuffle(Random());
    startTimer();
  }

  void startTimer() {
    timeLeft = 10;

    timer?.cancel();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft--;

        if (timeLeft == 0) {
          nextQuestion();
        }
      });
    });
  }

  void answerQuestion(int scoreValue) {

    timer?.cancel();

    setState(() {
      showFeedback = true;
      correctAnswer = scoreValue == 1;
    });

    if (scoreValue == 1) {
      score++;
    }

    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void nextQuestion() {

    setState(() {
      showFeedback = false;
      questionIndex++;
    });

    if (questionIndex < questions.length) {
      startTimer();
    }
  }

  void restartQuiz() {
    setState(() {
      questionIndex = 0;
      score = 0;
      questions.shuffle();
    });

    startTimer();
  }

  @override
  Widget build(BuildContext context) {

    bool finished = questionIndex >= questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Number Quiz"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffffecd2), Color(0xfffcb69f)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: finished
            ? ResultScreen(score, questions.length, restartQuiz)
            : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Text(
              "Question ${questionIndex + 1} / ${questions.length}",
              style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            LinearProgressIndicator(
              value: timeLeft / 10,
              minHeight: 10,
            ),

            SizedBox(height: 30),

            Text(
              questions[questionIndex]["question"] as String,
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 30),

            ...(questions[questionIndex]["answers"]
            as List<Map<String, Object>>)
                .map((answer) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                  ),
                  onPressed: () =>
                      answerQuestion(answer["score"] as int),
                  child: Text(
                    answer["text"] as String,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            }).toList(),

            SizedBox(height: 20),

            if (showFeedback)
              Center(
                child: Text(
                  correctAnswer ? "✅ Correct!" : "❌ Wrong!",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: correctAnswer
                          ? Colors.green
                          : Colors.red),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {

  final int score;
  final int total;
  final Function restartQuiz;

  ResultScreen(this.score, this.total, this.restartQuiz);

  String getResultText() {
    double percentage = score / total;

    if (percentage == 1) return "🏆 Perfect Score!";
    if (percentage > 0.7) return "🎉 Great Job!";
    if (percentage > 0.4) return "👍 Good Try!";
    return "📚 Keep Practicing!";
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
            "Quiz Completed",
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 20),

          Text(
            "Score: $score / $total",
            style: TextStyle(fontSize: 26),
          ),

          SizedBox(height: 20),

          Text(
            getResultText(),
            style: TextStyle(fontSize: 24),
          ),

          SizedBox(height: 30),

          ElevatedButton(
            onPressed: () => restartQuiz(),
            child: Text("Restart Quiz"),
          )
        ],
      ),
    );
  }
}
