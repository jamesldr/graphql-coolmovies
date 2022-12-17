import 'package:flutter/material.dart';

class ScoreStarSelector extends StatefulWidget {
  const ScoreStarSelector({
    super.key,
    required this.onTap,
    this.value = 1,
  });

  final int value;
  final Function(int) onTap;

  @override
  State<ScoreStarSelector> createState() => _ScoreStarSelectorState();
}

class _ScoreStarSelectorState extends State<ScoreStarSelector> {
  final selectedStar = const Icon(Icons.star, color: Colors.amber);
  final unselectedStar = const Icon(Icons.star_border, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          5,
          (index) => Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () => widget.onTap(index + 1),
              child:
                  index <= (widget.value - 1) ? selectedStar : unselectedStar,
            ),
          ),
        ),
      ),
    );
  }
}
