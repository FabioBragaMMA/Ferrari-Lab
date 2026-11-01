import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;
  final String carModel;
  final String carVersion;

  const DetailScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.content,
    required this.carModel,
    required this.carVersion,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title - $carModel'),
        backgroundColor: const Color(0xFFB71C1C),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 80, color: const Color(0xFFB71C1C)),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Veículo Conetado: $carModel ($carVersion)',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                content,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
