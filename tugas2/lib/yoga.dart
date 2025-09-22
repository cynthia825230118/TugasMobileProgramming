import 'package:flutter/material.dart';

class YogaPage extends StatelessWidget {
  const YogaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFDF89A6)),
          onPressed: () {
            Navigator.pop(context); //balik ke halaman sebelumnya (main.dart)
          },
        ),
        title: const Text(
          "Yoga",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const YogaHomeContent(),
    );
  }
}

class YogaHomeContent extends StatelessWidget {
  const YogaHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),

              const Text(
                "Keep Going",
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),

              const SizedBox(height: 20),

              // Search bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFFCE4EC)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: "Search for your mood",
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    Icon(Icons.tune, color: Colors.grey.shade600),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Categories
              const Text(
                "Categories for you",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildCategory("Bird", "image/yo1.png"),
                  _buildCategory("Downward", "image/yo2.png"),
                  _buildCategory("Childs", "image/yo3.png"),
                  _buildCategory("Warrior", "image/yo4.png"),
                ],
              ),

              const SizedBox(height: 25),

              // Featured for you
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Featured for you",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(color: Color(0xFFFCE4EC)),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Column(
                children: [
                  _buildYogaCard(
                    "Bikram yoga",
                    "12 Lessons | Beginner",
                    "image/yoga1.jpg",
                  ),
                  const SizedBox(height: 16),
                  _buildYogaCard(
                    "Hatha yoga",
                    "14 Lessons | Beginner",
                    "image/yoga2.jpg",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Category box
  static Widget _buildCategory(String title, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFCE4EC)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 40, height: 40, fit: BoxFit.contain),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  // Yoga Card vertical
  static Widget _buildYogaCard(String title, String subtitle, String imagePath) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(color: const Color(0xFFFCE4EC), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              imagePath,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                const SizedBox(height: 12),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFCE4EC),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Start training"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
