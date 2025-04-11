import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TeachersPage extends StatelessWidget {
  final String subject;

  TeachersPage({required this.subject});

  final List<Map<String, String>> teachers = [
    {
      "name": "الأستاذ محمد أحمد",
      "phone": "22222222",
      "image": "assets/teacher1.png",
      "subject": "الرياضيات",
      "cv": "أستاذ رياضيات بخبرة 10 سنوات...",
    },
    {
      "name": "الأستاذة فاطمة بنت سيدي",
      "phone": "33333333",
      "image": "assets/teacher2.png",
      "subject": "الفرنسية",
      "cv": "أستاذة لغة فرنسية للمرحلة الثانوية...",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = teachers.where((t) => t['subject'] == subject).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("أساتذة $subject"),
          backgroundColor: const Color.fromARGB(255, 18, 88, 211),
        ),
        body: ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final teacher = filtered[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(teacher["image"]!),
                ),
                title: Text(teacher["name"]!),
                subtitle: Row(
                  children: [
                    Text(teacher["phone"]!),
                    IconButton(
                      icon: Icon(Icons.copy, size: 18),
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: teacher["phone"]!),
                        );
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("تم نسخ الرقم")));
                      },
                    ),
                  ],
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text("تفاصيل الأستاذ"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("الاسم: ${teacher["name"]}"),
                            Text("الهاتف: ${teacher["phone"]}"),
                            SizedBox(height: 8),
                            Text("السيرة الذاتية:${teacher["cv"]}"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("إغلاق"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
