import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          "faq".tr(),
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView(
          children: [
            FAQItem(question: "faq_q1".tr(), answer: "faq_a1".tr()),
            FAQItem(question: "faq_q2".tr(), answer: "faq_a2".tr()),
            FAQItem(question: "faq_q3".tr(), answer: "faq_a3".tr()),
            FAQItem(question: "faq_q4".tr(), answer: "faq_a4".tr()),
            FAQItem(question: "faq_q5".tr(), answer: "faq_a5".tr()),
            FAQItem(question: "faq_q6".tr(), answer: "faq_a6".tr()),
            FAQItem(question: "faq_q7".tr(), answer: "faq_a7".tr()),
            FAQItem(question: "faq_q8".tr(), answer: "faq_a8".tr()),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            question,
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            answer,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 20.sp),
          ),
        ],
      ),
    );
  }
}
