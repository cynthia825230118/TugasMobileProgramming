import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExerciseDetailsPage();
  }
}

class ExerciseDetailsPage extends StatelessWidget {
  const ExerciseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC), // background keseluruhan
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFFFCE4EC),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFDF89A6)),
          onPressed: () {
            Navigator.pop(context); //kembali ke halaman sebelumnya
          },
        ),
        title: const Text(
          "Exercise Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and counter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Exercise",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Wheel Facing Pose",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  "5/10",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Image pose utama + progress bar
            Container(
              height: 240,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        "image/pose1.jpg",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Progress bar (timebar)
                  Container(
                    height: 6,
                    margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: LinearProgressIndicator(
                        value: 0.5, // progress
                        backgroundColor: Colors.grey[300],
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // List exercise berikutnya
            Expanded(
              child: ListView(
                children: [
                  buildExerciseItem(
                      "image/pose2.jpg", "Warrior II Facing", "2min"),
                  const SizedBox(height: 12),
                  buildExerciseItem(
                      "image/pose3.jpg", "Reverse Warrior II", "4min"),
                ],
              ),
            ),
          ],
        ),
      ),

      // Tombol pause
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: const Icon(Icons.pause, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildExerciseItem(String img, String title, String duration) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white, // card putih
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(img, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(duration, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.play_circle_fill,
                color: Colors.grey, size: 32),
          )
        ],
      ),
    );
  }
}
