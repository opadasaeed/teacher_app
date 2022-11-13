import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PageViewerImage extends StatelessWidget {
  final String? title;
  final String? textContent;
  final String? image;
  final int flex;

  const PageViewerImage({
    Key? key,
    this.textContent,
    this.image,
    this.flex = 2,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            child: SvgPicture.asset(
              image!,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title!,
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                textContent!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: const Color(
                        0xFF828282,
                      ),
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
