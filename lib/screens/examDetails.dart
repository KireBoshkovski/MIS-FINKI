import 'package:flutter/material.dart';
import 'package:helloworld/models/exam.dart';
import 'package:intl/intl.dart';

class ExamDetailsPage extends StatelessWidget {
  final Exam exam;

  const ExamDetailsPage({super.key, required this.exam});

  String _timeRemaining() {
    final now = DateTime.now();
    final diff = exam.date.difference(now);

    if (diff.isNegative) {
      return "Испитот помина.";
    }

    final days = diff.inDays;
    final hours = diff.inHours - (days * 24);

    return "$days дена, $hours часа";
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat("dd.MM.yyyy HH:mm").format(exam.date);

    return Scaffold(
      appBar: AppBar(
        title: Text(exam.subjectName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.access_time, color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Преостанато време: ${_timeRemaining()}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  formattedDate,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, color: Colors.blue),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        exam.placeForExam.map((p) => Text("• $p")).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
