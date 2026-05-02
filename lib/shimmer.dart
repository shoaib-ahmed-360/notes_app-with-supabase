import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Shimmerscreen extends StatelessWidget {
  const Shimmerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100, // Changed from yellow to light grey
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true, // Helps if used inside another Column
        itemBuilder: (context, index) => const BoxEffect(),
      ),
    );
  }
}

class BoxEffect extends StatelessWidget {
  const BoxEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligns bars to the left
        children: [
          Container(
            height: 20,
            width: double.infinity, // Fills screen width properly
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 14,
            width: 150, // Shorter width for the "description" line
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
