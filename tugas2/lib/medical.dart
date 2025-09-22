import 'package:flutter/material.dart';

class MedicalPage extends StatefulWidget {
  const MedicalPage({super.key});

  @override
  State<MedicalPage> createState() => _MedicalPageState();
}

class _MedicalPageState extends State<MedicalPage>
    with SingleTickerProviderStateMixin {
  final List<String> _healthTips = [
    "Minum air putih minimal 8 gelas sehari.",
    "Tidur cukup 7-8 jam per malam untuk memperbaiki sel tubuh.",
    "Olahraga ringan 30 menit setiap hari menjaga jantung sehat.",
    "Konsumsi buah dan sayur untuk vitamin dan serat alami.",
    "Kurangi konsumsi gula berlebih untuk mencegah diabetes.",
  ];

  final List<String> _tipImages = [
    "image/water.jpg",
    "image/sleep.jpg",
    "image/exercises.jpg",
    "image/fruit.jpg",
    "image/sugar.jpg",
  ];

  int _topIndex = 0;
  Offset _cardOffset = Offset.zero;
  double _cardRotation = 0.0;
  late AnimationController _animController;
  late Animation<Offset> _animOffset;
  late Animation<double> _animRotation;

  final List<String> _myHealthNotes = [];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animOffset =
        Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(_animController);
    _animRotation =
        Tween<double>(begin: 0, end: 0).animate(_animController);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _cardOffset += details.delta;
      _cardRotation = 0.002 * _cardOffset.dx;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    const threshold = 0.25;

    if (_cardOffset.dx > screenWidth * threshold) {
      _animateCardTo(Offset(screenWidth * 1.5, _cardOffset.dy), 0.8, wasRight: true);
    } else if (_cardOffset.dx < -screenWidth * threshold) {
      _animateCardTo(Offset(-screenWidth * 1.5, _cardOffset.dy), -0.8, wasRight: false);
    } else {
      _animateCardTo(Offset.zero, 0.0);
    }
  }

  void _animateCardTo(Offset targetOffset, double targetRotation, {bool? wasRight}) {
    _animOffset = Tween<Offset>(begin: _cardOffset, end: targetOffset).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _animRotation =
        Tween<double>(begin: _cardRotation, end: targetRotation).animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeOut),
        );

    _animController.reset();
    _animController.forward().whenComplete(() {
      final screenWidth = MediaQuery.of(context).size.width;
      if (targetOffset.dx.abs() > screenWidth * 0.6) {
        _finishSwipe(wasRight ?? false);
      } else {
        _resetCardToCenter();
      }
    });
  }

  void _resetCardToCenter() {
    setState(() {
      _cardOffset = Offset.zero;
      _cardRotation = 0.0;
    });
  }

  void _finishSwipe(bool wasRight) {
    final currentIndex = _topIndex;

    if (wasRight && currentIndex < _healthTips.length) {
      _myHealthNotes.add(_healthTips[currentIndex]);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Saved to My Health Notes ✅"),
          duration: Duration(milliseconds: 900),
        ),
      );
    }

    setState(() {
      _topIndex += 1;
      _cardOffset = Offset.zero;
      _cardRotation = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        title: const Text("Medical Tips"),
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
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade100, Colors.pink.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: LinearProgressIndicator(
                  value: (_topIndex + 1) / _healthTips.length,
                  backgroundColor: Colors.white70,
                  color: Colors.pink.shade200,
                  minHeight: 8,
                ),
              ),
            ),

            const SizedBox(height: 40),

            _topIndex < _healthTips.length
                ? GestureDetector(
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  final offset = _animController.isAnimating
                      ? _animOffset.value
                      : _cardOffset;
                  final rotation = _animController.isAnimating
                      ? _animRotation.value
                      : _cardRotation;

                  return Transform.translate(
                    offset: offset,
                    child: Transform.rotate(
                      angle: rotation,
                      child: child,
                    ),
                  );
                },
                child: Card(
                  elevation: 12,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    width: size.width * 0.85,
                    height: size.height * 0.55,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "💡 Tips Kesehatan",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                          const SizedBox(height: 15),

                          Image.asset(
                            _tipImages[_topIndex],
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 25),

                          Text(
                            _healthTips[_topIndex],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),

                          IconButton(
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.redAccent,
                              size: 28,
                            ),
                            onPressed: () {
                              _myHealthNotes.add(_healthTips[_topIndex]);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Saved to My Health Notes ❤️"),
                                  duration: Duration(milliseconds: 900),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
                : const Text(
              "🎉 Semua tips sudah ditampilkan!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade200,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => ListView(
              padding: const EdgeInsets.all(16),
              children: _myHealthNotes
                  .map((tip) => ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: Text(tip),
              ))
                  .toList(),
            ),
          );
        },
        child: const Icon(Icons.note),
      ),
    );
  }
}
