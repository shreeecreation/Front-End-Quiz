import 'package:flutter/material.dart';
import 'package:quiz/src/core/themes/appcolors.dart';

class HeartbeatButton extends StatefulWidget {
  const HeartbeatButton({super.key});

  @override
  HeartbeatButtonState createState() => HeartbeatButtonState();
}

class HeartbeatButtonState extends State<HeartbeatButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceIn,
      ),
    );

    // Repeat the animation forever
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.cardColor,
            ),
            child: Center(
              child: Tooltip(
                message: 'Shreee Krishna Shrestha is my Name',
                child: IconButton(
                  icon: const Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Handle button press
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
