import 'package:flutter/material.dart';
import 'Homepage.dart';

void main() {
  runApp(MyApp());
}

// التطبيق الرئيسي
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

// الصفحة الرئيسية
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Map<String, dynamic>> levels = [
    {"label": "التعليم الأساسي (الابتدائي)"},
    {"label": "التعليم الإعدادي"},
    {"label": "التعليم الثانوي"},
    {"label": "التعليم المحظري"},
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("الرئيسية"),
          backgroundColor: const Color.fromARGB(255, 18, 88, 211),
          centerTitle: true,
        ),
        drawer: _buildDrawer(context),
        body: _buildBody(context),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: "المراكز"),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: "الكتب",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('زائر'),
            accountEmail: Text(''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.blue),
            ),
            decoration: BoxDecoration(color: Color.fromARGB(255, 18, 88, 211)),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('الرئيسية'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('الحساب'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('من نحن'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('تواصل معنا'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (currentIndex == 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Image.asset("images/m.png", width: 80, height: 80),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'رحلتك نحو التفوق تبدأ من هنا',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'اختر مستواك وابحث عن أستاذك الآن',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: levels.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.menu_book, color: Colors.blue),
                      title: Text(levels[index]["label"]),
                      onTap: () {
                        List<String> subjects = [];
                        final label = levels[index]["label"];

                        if (label.contains("المحظري")) {
                          subjects = ["القرآن الكريم"];
                        } else if (label.contains("الأساسي") ||
                            label.contains("الابتدائي")) {
                          subjects = ["العربية", "الفرنسية"];
                        } else {
                          subjects = [
                            "الرياضيات",
                            "الفيزياء والكيمياء",
                            "العلوم الطبيعية",
                            "العربية",
                            "الفرنسية",
                          ];
                        }

                        showDialog(
                          context: context,
                          builder: (_) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                constraints: BoxConstraints(maxHeight: 400),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "اختر المادة",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Divider(),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: subjects.length,
                                        itemBuilder: (context, i) {
                                          return ListTile(
                                            title: Center(
                                              child: Text(subjects[i]),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (_) => TeachersPage(
                                                        subject: subjects[i],
                                                      ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("إغلاق"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    } else if (currentIndex == 1) {
      return Center(child: Text("صفحة المراكز"));
    } else {
      return Center(child: Text("صفحة الكتب"));
    }
  }
}
