import 'package:flutter/material.dart';
import 'register_page.dart';
import 'diet.dart';
import 'exercise.dart';
import 'medical.dart';
import 'yoga.dart';

void main() {
  runApp(const MyHealthApp());
}

class MyHealthApp extends StatelessWidget {
  const MyHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // mulai dari halaman register
      routes: {
        '/': (context) => const RegisterPage(),
        '/home': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as RegistrationData;
          return HomePage(data: args);
        },
        '/diet': (context) => const DietPage(),
        '/exercise': (context) => const ExercisePage(),
        '/medical': (context) => const MedicalPage(),
        '/yoga': (context) => const YogaPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final RegistrationData data;

  const HomePage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // background setengah coral & setengah putih
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFCE4EC),
              Colors.white,
            ],
            stops: [0.4, 0.4],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Good Morning",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),

                // Search bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      border: InputBorder.none,
                      hintText: "Search",
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Grid Menu
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    padding: const EdgeInsets.only(bottom: 40, top: 20),
                    childAspectRatio: 0.7,
                    children: const [
                      MenuCard(
                        imagePath: "image/diet.jpg",
                        title: "Diet Plan",
                        route: "/diet",
                      ),
                      MenuCard(
                        imagePath: "image/exercise.jpg",
                        title: "Exercises",
                        route: "/exercise",
                      ),
                      MenuCard(
                        imagePath: "image/medical.jpg",
                        title: "Medical Tips",
                        route: "/medical",
                      ),
                      MenuCard(
                        imagePath: "image/yoga.jpg",
                        title: "Yoga",
                        route: "/yoga",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: "Today",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Tomorrow",
          ),
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String route;

  const MenuCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 70,
              height: 70,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
