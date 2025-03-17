import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.tittle,
    required this.count,
  });

  final String tittle;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Text(
              '$count',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text(tittle),
          ],
        ),
      ),
    );
  }
}
