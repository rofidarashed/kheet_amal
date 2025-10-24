import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

class SummaryScreen1 extends StatefulWidget {
  const SummaryScreen1({super.key});

  @override
  State<SummaryScreen1> createState() => _SummaryScreen1State();
}

class _SummaryScreen1State extends State<SummaryScreen1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 10.h),
        child: Column(
          children: [
            Container(
              decoration: buildBoxDecoration(),
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Number of reported and recovered cases per monthً".tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 8.w,
                        left: 8.w,
                        bottom: 10.h,
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 6.r,
                                    backgroundColor: AppColors.circleAvatar,
                                  ),
                                  Text(
                                    " 80 ".tr(),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  Text(
                                    " Missing".tr(),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 6.r,
                                    backgroundColor: AppColors.secondaryColor,
                                  ),
                                  Text(
                                    " 70 ".tr(),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  Text(
                                    " Suspected".tr(),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 6.r,
                                    backgroundColor: AppColors.pgreeen,
                                  ),
                                  Text(
                                    " 50 ".tr(),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  Text(
                                    "Found".tr(),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Stack(
                            children: [
                              SizedBox(
                                height: 190.h,
                                width: 190.w,
                                child: PieChart(
                                  PieChartData(
                                    sections: [
                                      PieChartSectionData(
                                        value: 70,
                                        color: AppColors.secondaryColor,
                                        showTitle: false,
                                      ),
                                      PieChartSectionData(
                                        value: 80,
                                        color: AppColors.circleAvatar,
                                        showTitle: false,
                                      ),
                                      PieChartSectionData(
                                        value: 50,
                                        color: AppColors.pgreeen,
                                        showTitle: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 60.h,
                                  right: 60.w,
                                  left: 54.w,
                                  bottom: 50.h,
                                ),
                                child: Text(
                                  "200+ ".tr(),
                                  style: TextStyle(fontSize: 30.sp),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 79.w,
                                  top: 95.h,
                                  bottom: 50.h,
                                  right: 75.w,
                                ),
                                child: Text(
                                  "Status".tr(),
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: AppColors.hintTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Container(
              decoration: buildBoxDecoration(),
              child: Padding(
                padding: EdgeInsets.only(right: 10.w, left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Age distribution".tr(), style: TextStyle(fontSize: 20.sp)),
                    SizedBox(height: 15.h),
                    SizedBox(
                      height: 270.h,
                      width: 375.w,
                      child: AspectRatio(
                        aspectRatio: 1.7,
                        child: BarChart(
                          BarChartData(
                            gridData: FlGridData(show: false),
                            borderData: FlBorderData(
                              show: true,
                              border: Border(
                                left: BorderSide(
                                  color: AppColors.black54,
                                  width: 2.w,
                                ),
                                bottom: BorderSide(
                                  color: AppColors.black54,
                                  width: 2.w,
                                ),
                              ),
                            ),
                            titlesData: FlTitlesData(
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 28,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),
                                      style: TextStyle(fontSize: 10.sp),
                                    );
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    switch (value.toInt()) {
                                      case 0:
                                        return Text("0-3".tr());
                                      case 1:
                                        return Text("4-7".tr());
                                      case 2:
                                        return Text("8-12".tr());
                                      case 3:
                                        return Text("13-17".tr());
                                    }
                                    return Text("".tr());
                                  },
                                ),
                              ),
                            ),
                            barGroups: [
                              makeGroupData(0, 15, 8, 5),
                              makeGroupData(1, 55, 15, 20),
                              makeGroupData(2, 45, 20, 25),
                              makeGroupData(3, 35, 12, 18),
                            ],
                            groupsSpace: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LegendItem(
                          color: AppColors.secondaryColor,
                          text: 'Suspected'.tr(),
                        ),
                        SizedBox(width: 12.w),
                        LegendItem(
                          color: AppColors.pgreeen,
                          text: 'Found',
                        ),
                        SizedBox(width: 12.w),
                        LegendItem(color: AppColors.circleAvatar, text: 'Missing'.tr()),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Conclusion".tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 13.sp, color: AppColors.black),
                        children: [
                          TextSpan(
                            text: "-Most exposed groups: ",
                            style: TextStyle(
                              color: AppColors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "8-12 year".tr(),
                            style: TextStyle(
                              color: AppColors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "\n- Decrease in cases among ages 0–3 years".tr(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

BoxDecoration buildBoxDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(15.r),
    color: AppColors.white,
  );
}

BarChartGroupData makeGroupData(
  int x,
  double found,
  double missing,
  double suspected,
 )
{
  return BarChartGroupData(
    x: x,
    barsSpace: 4.w,
    barRods: [
      BarChartRodData(
        toY: found,
        color: AppColors.circleAvatar,
        width: 16.w,
        borderRadius: BorderRadius.circular(0.r),
      ),
      BarChartRodData(
        toY: suspected,
        color: AppColors.secondaryColor,
        width: 16.w,
        borderRadius: BorderRadius.circular(0.r),
      ),
      BarChartRodData(
        toY: missing,
        color: AppColors.pgreeen,
        width: 16.w,
        borderRadius: BorderRadius.circular(0.r),
      ),
    ],
  );
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: TextStyle(fontSize: 14.sp, color: color)),
        SizedBox(width: 4.w),
        Container(
          width: 20.w,
          height: 15.h,
          decoration: BoxDecoration(color: color, shape: BoxShape.rectangle),
        ),
      ],
    );
  }
}
