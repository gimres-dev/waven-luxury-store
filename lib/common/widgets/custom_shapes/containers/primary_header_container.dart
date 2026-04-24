import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:t_store/common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import 'package:t_store/utils/constants/colors.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: ClipRect(
        child: Container(
          color: TColors.primary,
          child: SizedBox(
            height: 350,
            child: Stack(
              children: [
                Positioned(
                  top: -150,
                  right: -250,
                  child: TCircularContainer(
                    backgroundColor: TColors.secondary.withOpacity(0.1),
                  ),
                ),
                Positioned(
                  top: 100,
                  right: -300,
                  child: TCircularContainer(
                    backgroundColor: TColors.secondary.withOpacity(0.1),
                  ),
                ),
                Positioned(
                  top: 18,
                  right: 80,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: TColors.white.withOpacity(0.10),
                        width: 1.2,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 26,
                  right: 88,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: TColors.white.withOpacity(0.06),
                        width: 0.8,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 36,
                  right: 55,
                  child: Transform.rotate(
                    angle: 0.785,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: TColors.secondary.withOpacity(0.45),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 28,
                  right: 130,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _dot(4, 0.08),
                          const SizedBox(width: 6),
                          _dot(3, 0.06),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          _dot(3, 0.06),
                          const SizedBox(width: 6),
                          _dot(2.5, 0.05),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -45,
                  left: 10,
                  child: Text(
                    'WAVEN',
                    style: TextStyle(
                      fontSize: 90,
                      fontWeight: FontWeight.bold,
                      color: TColors.white.withOpacity(0.04),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dot(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: TColors.white.withOpacity(opacity),
      ),
    );
  }
}