import 'package:flutter/material.dart';

void main() {
  runApp(CGPAApp());
}

// ================== MAIN APP ==================
class CGPAApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CGPA Calculator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFD7CCC8),
        scaffoldBackgroundColor: Color(0xFFF5F5DC),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFD7CCC8),
          foregroundColor: Colors.brown[900],
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFBCAAA4),
          foregroundColor: Colors.brown[900],
        ),
      ),
      home: SplashPage(),
    );
  }
}

// ================== SPLASH / START PAGE ==================
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 120, color: Colors.brown[400]),
            SizedBox(height: 30),
            Text(
              "University CGPA Calculator",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[700]),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomePage()));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Text("Start", style: TextStyle(fontSize: 18)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFBCAAA4),
                foregroundColor: Colors.brown[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================== MODELS ==================
class Subject {
  final String name;
  final int credit;
  final double gpa;
  final String grade;
  final double sessional;
  final double mid;
  final double finalExam;

  Subject({
    required this.name,
    required this.credit,
    required this.gpa,
    required this.grade,
    required this.sessional,
    required this.mid,
    required this.finalExam,
  });
}

class Semester {
  final List<Subject> subjects;

  Semester({required this.subjects});

  double get semesterGPA {
    double totalPoints = 0;
    int totalCredits = 0;
    for (var s in subjects) {
      totalPoints += s.gpa * s.credit;
      totalCredits += s.credit;
    }
    return totalCredits == 0 ? 0 : totalPoints / totalCredits;
  }
}

// ================== HOME PAGE ==================
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Semester> semesters = [];

  double get overallCGPA {
    if (semesters.isEmpty) return 0;
    double totalPoints = 0;
    int totalCredits = 0;
    for (var sem in semesters) {
      for (var sub in sem.subjects) {
        totalPoints += sub.gpa * sub.credit;
        totalCredits += sub.credit;
      }
    }
    return totalCredits == 0 ? 0 : totalPoints / totalCredits;
  }

  void navigateToAddSemester() async {
    final newSemester = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddSemesterPage()),
    );
    if (newSemester != null) {
      setState(() {
        semesters.add(newSemester);
      });
    }
  }

  void showGradingScale() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Grading Scale"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text("A  → 4.0 (85–100%)"),
            Text("A- → 3.7 (80–84.99%)"),
            Text("B+ → 3.3 (75–79.99%)"),
            Text("B  → 3.0 (70–74.99%)"),
            Text("B- → 2.7 (65–69.99%)"),
            Text("C+ → 2.3 (60–64.99%)"),
            Text("C  → 2.0 (55–59.99%)"),
            Text("D  → 1.0 (50–54.99%)"),
            Text("F  → 0.0 (<50%)"),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Close"))
        ],
      ),
    );
  }

  void showTips() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Tips for Better CGPA"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("- Attend all lectures"),
            Text("- Submit assignments on time"),
            Text("- Revise quizzes and mid-term papers"),
            Text("- Solve past papers"),
            Text("- Focus on understanding concepts"),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Close"))
        ],
      ),
    );
  }

  Widget optionCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      color: Color(0xFFF3E0DC),
      child: ListTile(
        leading: Icon(icon, color: Colors.brown[400]),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CGPA Calculator"),
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => SplashPage()));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddSemester,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Overall CGPA card
            Card(
              color: Color(0xFFF5F5DC),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text("Overall CGPA",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: CircularProgressIndicator(
                            value: overallCGPA / 4.0,
                            strokeWidth: 12,
                            color: Colors.brown[700],
                            backgroundColor: Colors.brown[200],
                          ),
                        ),
                        Text(overallCGPA.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[700])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Semester cards
            Expanded(
              child: ListView.builder(
                itemCount: semesters.length,
                itemBuilder: (context, index) {
                  final sem = semesters[index];
                  return Card(
                    color: Color(0xFFF3E0DC),
                    child: ExpansionTile(
                      leading: Icon(Icons.school, color: Colors.brown[400]),
                      title: Text(
                          "Semester ${index + 1} GPA: ${sem.semesterGPA.toStringAsFixed(2)}"),
                      children: sem.subjects
                          .map((sub) => ListTile(
                        title: Text(sub.name),
                        subtitle: Text(
                            "Credit: ${sub.credit} | Grade: ${sub.grade} | GPA: ${sub.gpa.toStringAsFixed(2)}"),
                      ))
                          .toList(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            const Text("Options",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            optionCard("Tips for Better CGPA", Icons.lightbulb_outline, showTips),
            optionCard("Grading Scale", Icons.grade_outlined, showGradingScale),
          ],
        ),
      ),
    );
  }
}

// ================== ADD SEMESTER PAGE ==================
class AddSemesterPage extends StatefulWidget {
  @override
  _AddSemesterPageState createState() => _AddSemesterPageState();
}

class _AddSemesterPageState extends State<AddSemesterPage> {
  final subjectController = TextEditingController();
  final creditController = TextEditingController();
  final quizControllers = List.generate(4, (_) => TextEditingController());
  final assignmentControllers = List.generate(4, (_) => TextEditingController());
  final midController = TextEditingController();
  final finalController = TextEditingController();

  List<Subject> subjects = [];

  String getGrade(double weighted) {
    if (weighted >= 85) return "A";
    if (weighted >= 80) return "A-";
    if (weighted >= 75) return "B+";
    if (weighted >= 70) return "B";
    if (weighted >= 65) return "B-";
    if (weighted >= 60) return "C+";
    if (weighted >= 55) return "C";
    if (weighted >= 50) return "D";
    return "F";
  }

  double getGPA(double weighted) {
    if (weighted >= 85) return 4.0;
    if (weighted >= 80) return 3.7;
    if (weighted >= 75) return 3.3;
    if (weighted >= 70) return 3.0;
    if (weighted >= 65) return 2.7;
    if (weighted >= 60) return 2.3;
    if (weighted >= 55) return 2.0;
    if (weighted >= 50) return 1.0;
    return 0.0;
  }

  void addSubject() {
    if (subjectController.text.isEmpty || creditController.text.isEmpty) return;

    int credit = int.parse(creditController.text);
    double quizTotal = quizControllers.map((c) => double.tryParse(c.text) ?? 0).reduce((a,b)=>a+b);
    double assignmentTotal = assignmentControllers.map((c) => double.tryParse(c.text) ?? 0).reduce((a,b)=>a+b);
    double mid = double.tryParse(midController.text) ?? 0;
    double finalExam = double.tryParse(finalController.text) ?? 0;

    double weighted = ((quizTotal + assignmentTotal)/80)*25 + (mid/25)*25 + (finalExam/50)*50;

    subjects.add(Subject(
      name: subjectController.text,
      credit: credit,
      gpa: getGPA(weighted),
      grade: getGrade(weighted),
      sessional: quizTotal + assignmentTotal,
      mid: mid,
      finalExam: finalExam,
    ));

    subjectController.clear();
    creditController.clear();
    for (var c in quizControllers) c.clear();
    for (var c in assignmentControllers) c.clear();
    midController.clear();
    finalController.clear();

    setState(() {});
  }

  Widget pastelTextField(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Color(0xFFF3E0DC),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Semester")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sessional Marks (Quizzes & Assignments)", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: subjectController, decoration: InputDecoration(labelText: "Subject Name", filled:true, fillColor: Color(0xFFF3E0DC), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
            SizedBox(height: 10),
            TextField(controller: creditController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "Credit Hours", filled:true, fillColor: Color(0xFFF3E0DC), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
            SizedBox(height: 10),
            Text("Quizzes (out of 10)"),
            Row(children: List.generate(4, (i) => Expanded(child: pastelTextField(quizControllers[i], "Q${i+1}")))),
            SizedBox(height: 10),
            Text("Assignments (out of 10)"),
            Row(children: List.generate(4, (i) => Expanded(child: pastelTextField(assignmentControllers[i], "A${i+1}")))),
            SizedBox(height: 10),
            Text("Exams", style: TextStyle(fontWeight: FontWeight.bold)),
            pastelTextField(midController, "Mid-term (25)"),
            pastelTextField(finalController, "Final (50)"),
            SizedBox(height: 10),
            ElevatedButton(onPressed: addSubject, child: Text("Add Subject")),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final sub = subjects[index];
                return Card(
                  color: Color(0xFFF3E0DC),
                  child: ListTile(
                    title: Text(sub.name),
                    subtitle: Text("Credit: ${sub.credit} | Grade: ${sub.grade} | GPA: ${sub.gpa.toStringAsFixed(2)}"),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            if (subjects.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, Semester(subjects: subjects));
                },
                child: Text("Save Semester"),
              ),
          ],
        ),
      ),
    );
  }
}