import 'package:flutter/material.dart';

void main() {
  runApp(const CVApp());
}

class CVApp extends StatelessWidget {
  const CVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EDEB),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// DRAWN LOGO
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFDDBEA9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.person_outline,
                size: 60,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Hiba CV Application",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Professional & Hobby Profile",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton.icon(
              icon: const Icon(Icons.description),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDDBEA9),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              label: const Text(
                "View My CV",
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CVPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class CVPage extends StatefulWidget {
  const CVPage({super.key});

  @override
  State<CVPage> createState() => _CVPageState();
}

class _CVPageState extends State<CVPage> {

  bool professional = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            /// HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 40, bottom: 25),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFCD5CE),
                    Color(0xFFE8E8E4),
                  ],
                ),
              ),
              child: Column(
                children: [

                  /// DRAWN HEADER LOGO
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDDBEA9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.badge,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Medium profile picture with shadow
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 55, // medium size
                      backgroundImage: AssetImage("assets/images/profile.png"),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Hiba",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Text(
                    "Computer Science Student",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [

                  sectionCard(
                    icon: Icons.person,
                    title: "Professional Summary",
                    text: professional
                        ? "A dedicated Computer Science student currently pursuing a Bachelor's degree from COMSATS University Islamabad, Vehari Campus. Passionate about mobile application development and software engineering. Enthusiastic about learning modern technologies and building innovative software solutions."
                        : "I enjoy spending my time exploring creative activities and developing new skills. My hobbies help me stay motivated and continuously learn new things outside my academic studies.",
                  ),

                  sectionCard(
                    icon: Icons.school,
                    title: professional ? "Education" : "Hobbies",
                    text: professional
                        ? "BS Computer Science\nCOMSATS University Islamabad, Vehari Campus\n\nIntermediate (FSc Pre-Engineering)\nPunjab College\n\nMatriculation\nDPS School"
                        : "• Reading books\n• Listening to music\n• Traveling\n• Watching technology related content",
                  ),

                  sectionCard(
                    icon: Icons.lightbulb,
                    title: professional ? "Skills" : "Interests",
                    text: professional
                        ? "• Programming Languages: C++, Java, Dart\n• Flutter Mobile Application Development\n• Problem Solving\n• UI Design Fundamentals"
                        : "• Artificial Intelligence\n• Mobile App Development\n• Learning modern technologies\n• Exploring innovative ideas",
                  ),

                  sectionCard(
                    icon: Icons.work,
                    title: professional ? "Academic Experience" : "Personal Skills",
                    text: professional
                        ? "Completed multiple academic projects focusing on mobile application development using Flutter. These projects enhanced my programming logic, user interface design understanding, and problem-solving abilities."
                        : "• Communication Skills\n• Creativity\n• Teamwork\n• Adaptability",
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton.icon(
                    icon: const Icon(Icons.swap_horiz),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDDBEA9),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        professional = !professional;
                      });
                    },
                    label: Text(
                      professional
                          ? "Switch to Hobby CV"
                          : "Switch to Professional CV",
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget sectionCard({
    required IconData icon,
    required String title,
    required String text,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.brown),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(height: 1.6),
            )
          ],
        ),
      ),
    );
  }
}