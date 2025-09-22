import 'package:flutter/material.dart';
import 'dart:async';

class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  // Timer untuk puasa
  final int totalSeconds = 16 * 60 * 60;
  int remainingSeconds = 16 * 60 * 60;
  Timer? timer;

  // Data user
  int steps = 2500;
  int stepTarget = 6000;

  int water = 800;
  int waterTarget = 2400;

  int weight = 60; // kg
  int weightTarget = 65; // target

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        t.cancel();
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
    setState(() {});
  }

  String formatDuration(int seconds) {
    int h = seconds ~/ 3600;
    int m = (seconds % 3600) ~/ 60;
    int s = seconds % 60;
    return "${h.toString().padLeft(2, '0')}:"
        "${m.toString().padLeft(2, '0')}:"
        "${s.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 2 - 22;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFCE4EC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFDF89A6)),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, '/');
            }
          },
        ),
        title: const Text("Diet Plan"),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFFCE4EC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "16:8",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Waktu yang tersisa",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Text(
                formatDuration(remainingSeconds),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: stopTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  foregroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    "BERHENTI PUASA",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Row waktu mulai & berakhir
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Waktu mulai",
                          style: TextStyle(color: Colors.black54)),
                      SizedBox(height: 5),
                      Text("Hari ini, 08:00 PM",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Waktu berakhir",
                          style: TextStyle(color: Colors.black54)),
                      SizedBox(height: 5),
                      Text("Besok, 12:00 PM",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Wrap card biar tidak overflow
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(width: cardWidth, child: _buildWeightCard()),
                  SizedBox(width: cardWidth, child: _buildWaterCard()),
                  SizedBox(width: cardWidth, child: _buildStepsCard()),
                  SizedBox(
                    width: cardWidth,
                    child: _buildStaticCard(
                      icon: Icons.access_time,
                      color: Colors.purple,
                      title: "Waktu tersisa",
                      value: formatDuration(remainingSeconds),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Card statis
  Widget _buildStaticCard({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 180),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 20),
            Text(title,
                style: const TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 6),
            Text(value,
                textAlign: TextAlign.center,
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  // Card berat tubuh
  Widget _buildWeightCard() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 180),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.monitor_weight, size: 40, color: Colors.green),
            const SizedBox(height: 6),
            const Text("Berat tubuh",
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 4),
            Text("$weight kg / $weightTarget kg",
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (weight > 0) weight -= 1;
                    });
                  },
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (weight < 200) weight += 1;
                    });
                  },
                  icon: const Icon(Icons.add_circle, color: Colors.green),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Card langkah
  Widget _buildStepsCard() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 180),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.directions_walk, size: 40, color: Colors.orange),
            const SizedBox(height: 6),
            const Text("Langkah",
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 4),
            Text("$steps / $stepTarget",
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (steps > 0) steps -= 100;
                    });
                  },
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (steps < stepTarget) steps += 100;
                    });
                  },
                  icon: const Icon(Icons.add_circle, color: Colors.green),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Card air
  Widget _buildWaterCard() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 180),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_drink, size: 40, color: Colors.blue),
            const SizedBox(height: 6),
            const Text("Air",
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 4),
            Text("$water ml / $waterTarget ml",
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (water > 0) water -= 200;
                    });
                  },
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (water < waterTarget) water += 200;
                    });
                  },
                  icon: const Icon(Icons.add_circle, color: Colors.green),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
