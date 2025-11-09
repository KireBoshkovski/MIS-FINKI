import 'package:flutter/material.dart';
import 'package:helloworld/models/exam.dart';
import 'package:helloworld/widgets/examCard.dart';
import 'package:helloworld/screens/examDetails.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _myHomePageState();
}

class _myHomePageState extends State<MyHomePage> {
  List<Exam> exams = [
    Exam(
      subjectName: "Математика 1",
      date: DateTime(2025, 1, 1, 6, 30),
      placeForExam: List<String>.from(["Лаб 200в"]),
    ),
    Exam(
      subjectName: "Процесирање на сигналите",
      date: DateTime(2026, 7, 11, 12, 0),
      placeForExam: List<String>.from(["Лаб 200в"]),
    ),
    Exam(
      subjectName: "Интегрирани Системи",
      date: DateTime(2025, 12, 12, 9, 0),
      placeForExam: List<String>.from(["Лаб 3"]),
    ),
    Exam(
      subjectName: "Структурно програмирање",
      date: DateTime(2025, 12, 13, 10, 0),
      placeForExam: List<String>.from(["Амфитеатар 2"]),
    ),
    Exam(
      subjectName: "Дистрибуирани системи",
      date: DateTime(2024, 3, 14, 11, 0),
      placeForExam: List<String>.from(["Лаб 2"]),
    ),
    Exam(
      subjectName: "Бази на податоци",
      date: DateTime(2005, 12, 15, 11, 0),
      placeForExam: List<String>.from(["Амфитеатар МФС"]),
    ),
    Exam(
      subjectName: "Веројатност и статистика",
      date: DateTime(2004, 7, 16, 10, 0),
      placeForExam: List<String>.from(["Амфитеатар МФС", "Лаб 138"]),
    ),
    Exam(
      subjectName: "Дискретна Математика",
      date: DateTime(2025, 9, 17, 12, 0),
      placeForExam: List<String>.from(["Амфитеатар А1"]),
    ),
    Exam(
      subjectName: "Географија",
      date: DateTime(2025, 9, 13, 8, 0),
      placeForExam: List<String>.from(["Амфитеатар МФС"]),
    ),
    Exam(
      subjectName: "Дизајн на алгоритми",
      date: DateTime(2025, 7, 19, 11, 0),
      placeForExam: List<String>.from(["Лаб 138"]),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    exams.sort((a, b) => a.date.compareTo(b.date));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: exams.map((exam) {
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExamDetailsPage(exam: exam),
                  ),
                ),
                child: ExamCard(exam: exam),
              );
            }).toList()),
      ),
      bottomNavigationBar: Container(
        color: Colors.blue.shade50,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.list_alt, color: Colors.blue),
            const SizedBox(width: 8),
            Text(
              "Вкупно испити: ${exams.length}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
