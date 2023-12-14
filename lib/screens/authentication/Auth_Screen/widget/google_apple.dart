import 'package:flutter_svg/flutter_svg.dart';

import '../../../../const/consts.dart';

class GoogleApple extends StatelessWidget {
  final Function()? onPressGoogle;
  final Function()? onPressApple;
  const GoogleApple({super.key,  this.onPressGoogle, this.onPressApple});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPressGoogle,
          child: Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset(icGoogle),
              )
          ),
        ),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: onPressApple,
          child: Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade100,
            ),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: SvgPicture.asset(icApple),
            ),
          ),
        )
      ],
    );
  }
}
