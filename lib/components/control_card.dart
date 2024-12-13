import 'package:flutter/material.dart';

class ControlCard extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  const ControlCard({
    super.key,
    required this.title,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: onDecrement,
                  icon: Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: onIncrement,
                  icon: Icon(Icons.add, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
