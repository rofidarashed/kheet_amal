import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/ai_model/ai_model_screen.dart';
import 'package:kheet_amal/feature/comments/cubits/comments_cubit/comments_cubit.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_founder_info.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_icon_button.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_report_action_bar.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_report_details_cards.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/screenshot_contect.dart';
import 'package:kheet_amal/feature/saved/cubits/saved_reports_cubit/saved_reports_cubit.dart';
import 'package:kheet_amal/feature/saved/cubits/saved_reports_cubit/saved_reports_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportDetails extends StatelessWidget {
  final ScreenshotController _screenshotController = ScreenshotController();

  ReportDetails({super.key, required this.report});

  final ReportModel report;

  Future<void> _shareScreenshot(BuildContext context) async {
    try {
      final image = await _screenshotController.captureFromWidget(
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 32,
          ),
          child: buildScreenshotContent(report: report),
        ),
        context: context,
        pixelRatio: 2.0,
      );

      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/report_details.png';
      final file = File(path);
      await file.writeAsBytes(image);

      await Share.shareXFiles([XFile(path)], text: 'Check out this report!');
    } catch (e) {
      debugPrint('Error sharing screenshot: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sharing screenshot: $e'),
          backgroundColor: AppColors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SavedReportsCubit>().checkIfSaved(report.id);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('report_details').tr(),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 26.w),
            child: BlocBuilder<SavedReportsCubit, SavedReportsState>(
              builder: (context, state) {
                bool isSaved = false;

                if (state is SavedReportsToggled &&
                    state.reportId == report.id) {
                  isSaved = state.isSaved;
                }

                return GestureDetector(
                  onTap: () {
                    context.read<SavedReportsCubit>().toggleSaveReport(
                      report.id,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: SvgPicture.asset(
                      isSaved
                          ? 'assets/svgs/isSaved_svg.svg'
                          : 'assets/svgs/save_icon_svg.svg',
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 64.sp,
                width: double.infinity,
                color: AppColors.lightGreen,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          "ai_hint",
                          textAlign: TextAlign.right,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.5.h,
                          ),
                        ).tr(),
                      ),
                    ),
                    Image.asset(
                      "assets/images/report_details.png",
                      height: 25.sp,
                      width: 25.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              /// صورة البلاغ
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.sp),
                  child: report.imageUrl.isNotEmpty
                      ? Image.network(
                          report.imageUrl,
                          height: 187.h,
                          width: 158.w,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => SvgPicture.asset(
                            'assets/svgs/profile_icon.svg',
                            height: 187.h,
                            width: 158.w,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(),
                ),
              ),

              SizedBox(height: 20.h),

              FounderInfo(report: report),
              SizedBox(height: 16.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0.sp),
                child: Row(
                  children: [
                    CustomIconButton(
                      text: 'contact'.tr(),
                      backgroundColor: AppColors.secondaryColor,
                      onPressed: () {
                        showPhoneChooser(context, report);
                      },
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            AppColors.magentaviolet,
                            AppColors.royalblue,
                          ],
                        ),
                      ),
                      child: CustomIconButton(
                        text: 'Ai ✦',
                        backgroundColor: Colors.transparent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AiScreen(reportmodel: report),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              ReportDetailsCardsColumn(report: report),
              SizedBox(height: 16.h),

              /// زرار المشاركة
              BlocProvider(
                create: (context) =>
                    CommentsCubit()..commentCount(postId: report.id),

                child: ReportActionBar(
                  space: 16.w,
                  actionChild: CustomIconButton(
                    text: 'share'.tr(),
                    backgroundColor: AppColors.secondaryColor,
                    onPressed: () => _shareScreenshot(context),
                    icon: Icon(
                      Icons.share,
                      color: AppColors.white,
                      size: 20.sp,
                    ),
                  ),
                  report: report,
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}

void showPhoneChooser(BuildContext context, ReportModel report) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "choose_number".tr(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            if (report.phone1.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text(report.phone1),
                onTap: () {
                  Navigator.pop(context);
                  callUser(report.phone1);
                },
              ),

            if (report.phone2.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text(report.phone2),
                onTap: () {
                  Navigator.pop(context);
                  callUser(report.phone2);
                },
              ),

            if (report.phone1.isEmpty && report.phone2.isEmpty)
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "no_number_available".tr(),
                  style: TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      );
    },
  );
}

void callUser(String phone) async {
  final Uri url = Uri(scheme: 'tel', path: phone);

  if (!await launchUrl(url)) {
    throw Exception('Could not launch phone call');
  }
}
