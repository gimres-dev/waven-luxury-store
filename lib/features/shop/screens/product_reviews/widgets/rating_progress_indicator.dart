import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/device/device_utility.dart';

class TOverallProductRating extends StatelessWidget {
  const TOverallProductRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
        Expanded(
          flex: 3, 
          child: Text(
            '4.8', 
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: TColors.primary, 
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              TRatingProgressIndicator(text: '5', value: 1.0),
              TRatingProgressIndicator(text: '4', value: 0.8),
              TRatingProgressIndicator(text: '3', value: 0.6),
              TRatingProgressIndicator(text: '2', value: 0.4),
              TRatingProgressIndicator(text: '1', value: 0.1),
            ],
          ),
        )
      ],
    );
  }
}

class TRatingProgressIndicator extends StatelessWidget {
  const TRatingProgressIndicator({super.key, required this.text, required this.value});

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [     
        Expanded(
          flex: 1, 
          child: Text(
            text, 
            style: Theme.of(context).textTheme.bodyMedium?.apply(color: TColors.darkGrey),
          ),
        ),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: TDeviceUtils.getScreenWidth(context) * 0.8,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              backgroundColor: TColors.grey.withOpacity(0.2), 
              borderRadius: BorderRadius.circular(10),     
              valueColor: const AlwaysStoppedAnimation(TColors.secondary), 
            ),
          ),
        ),
      ],
    );
  }
}