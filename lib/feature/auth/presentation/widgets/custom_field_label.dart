import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class FieldLabel extends StatelessWidget {
  final String text;

  FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10.h, 33.w, 0),
      child: Align(
        alignment: Alignment.topRight,
        child: Text(
          text.tr(),
          style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}