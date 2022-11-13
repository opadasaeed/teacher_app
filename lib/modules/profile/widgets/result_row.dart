import 'package:flutter/material.dart';
import 'package:teacher_app/modules/profile/model/profile_model.dart';
import 'package:teacher_app/shared/config/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultsDataRow extends StatelessWidget {
  final Quizzes? quizze;
  final String? index;
  const ResultsDataRow({Key? key, this.quizze, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text('$index- ${quizze!.name}')),
        const Spacer(),
        CircularPercentIndicator(
          animation: true,
          radius: 30.0,
          lineWidth: 3.0,
          percent: double.parse(quizze!.percentage!) / 100,
          animationDuration: 800,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${double.parse(quizze!.percentage!).round()}%",
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                    ),
              ),
              Text(
                "${quizze!.total}/${quizze!.marks!}",
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                    ),
              ),
            ],
          ),
          progressColor: AppColors.primary1Color,
        )
      ],
    );
  }
}
