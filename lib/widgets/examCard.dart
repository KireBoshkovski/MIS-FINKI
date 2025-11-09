import 'package:flutter/material.dart';
import 'package:helloworld/models/exam.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          exam.date.isBefore(DateTime.now()) ? Colors.grey[400] : Colors.white,
      margin: const EdgeInsets.all(10.0),
      elevation: 5.0,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.book_outlined,
                    size: 14,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    exam.subjectName,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 12.0),
                  const SizedBox(width: 4.0),
                  Text(
                    '${exam.date.hour.toString().padLeft(2, '0')}:${exam.date.minute.toString().padLeft(2, '0')} - ${exam.date.day.toString().padLeft(2, '0')}.${exam.date.month.toString().padLeft(2, '0')}.${exam.date.year}',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 12.0),
                  const SizedBox(width: 4.0),
                  Text(
                    exam.placeForExam.join(", "),
                    style: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
