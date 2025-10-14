import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';
import 'package:kheet_amal/core/utils/app_validators.dart';
import 'package:kheet_amal/core/widgets/custom_button.dart';
import 'package:kheet_amal/core/widgets/custom_form_field.dart';
import 'package:kheet_amal/feature/add_report/cubit/add_report_cubit.dart';
import 'package:kheet_amal/feature/add_report/cubit/add_report_state.dart';
import 'package:kheet_amal/feature/add_report/enums/enums.dart';
import 'package:kheet_amal/feature/add_report/presentation/widgets/child_features.dart';
import 'package:kheet_amal/feature/add_report/presentation/widgets/contact_field.dart';
import 'package:kheet_amal/feature/add_report/presentation/widgets/custom_add_report_card.dart';
import 'package:kheet_amal/feature/add_report/presentation/widgets/custom_radio.dart';

class AddReportScreen extends StatelessWidget {
  AddReportScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _clothesController = TextEditingController();
  final TextEditingController _phoneController1 = TextEditingController();
  final TextEditingController _phoneController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddReportCubit(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<AddReportCubit, AddReportState>(
            builder: (context, state) {
              final cubit = context.read<AddReportCubit>();
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white12,
                  elevation: 0,
                  surfaceTintColor: Colors.transparent,
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(AppIcons.bellNotification),
                  ),
                  title: Text('add_report.add_report'.tr()),
                ),
                body: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        customAddReportCard(
                          children: [
                            Text(
                              'add_report.report_type'.tr(),
                              style: TextStyle(fontSize: 20.sp),
                            ),
                            CustomRadio(
                              selected:
                                  state.reportType == ReportType.lostChild,
                              label: 'add_report.missing_child'.tr(),
                              onTap: () =>
                                  cubit.selectReportType(ReportType.lostChild),
                            ),
                            CustomRadio(
                              selected:
                                  state.reportType == ReportType.verifyChild,
                              label: 'add_report.child_verification'.tr(),
                              onTap: () => cubit.selectReportType(
                                ReportType.verifyChild,
                              ),
                            ),
                          ],
                          context,
                        ),
                        childFeatures(context, state, cubit),
                        customAddReportCard(
                          context,
                          children: [
                            CustomFormField(
                              hint: 'add_report.enter_last_seen_place'.tr(),
                              controller: _placeController,
                              title: 'add_report.place'.tr(),
                              validator: (p0) => AppValidators.fieldValidator(
                                _placeController.text,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            CustomFormField(
                              validator: (p0) => AppValidators.fieldValidator(
                                _clothesController.text,
                              ),
                              maxLines: 2,
                              hint: 'add_report.example_clothes'.tr(),
                              controller: _clothesController,
                              title: 'add_report.clothes_at_disappearance'.tr(),
                            ),
                            GestureDetector(
                              onTap: () => cubit.pickDate(
                                context: context,
                                dateController: _dateController,
                              ),
                              child: AbsorbPointer(
                                child: CustomFormField(
                                  validator: (p0) =>
                                      AppValidators.dateValidator(
                                        _dateController.text,
                                      ),
                                  hint: 'add_report.day_month_year'.tr(),
                                  controller: _dateController,
                                  title: 'add_report.date'.tr(),
                                  subtitle: 'add_report.last_seen_date'.tr(),
                                ),
                              ),
                            ),
                            CustomFormField(
                              maxLines: 3,
                              hint: 'add_report.enter_additional_details'.tr(),
                              controller: cubit.descriptionController,
                              title: 'add_report.description'.tr(),
                              subtitle: 'add_report.optional'.tr(),
                            ),
                          ],
                        ),
                        customAddReportCard(
                          context,
                          children: [
                            ContactField(
                              onCahnged: (CountryCode value) {
                                cubit.selectContactCode(value.dialCode!);
                              },
                              subtitle: 'add_report.first'.tr(),
                              phoneController: _phoneController1,
                            ),
                            SizedBox(height: 12.h),
                            ContactField(
                              onCahnged: (CountryCode value) {
                                cubit.selectContactCode(value.dialCode!);
                              },
                              subtitle: 'add_report.second'.tr(),
                              phoneController: _phoneController2,
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        CustomButton(
                          width: 260.w,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.submitReport(
                                place: _placeController.text,
                                clothes: _clothesController.text,
                                phone1: _phoneController1.text,
                                phone2: _phoneController2.text,
                              );

                              AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                dialogType: DialogType.success,
                                headerAnimationLoop: true,
                                title: 'Success',
                                desc: 'Your report created successfully!',
                                btnOkOnPress: () {
                                  _dateController.clear();
                                  _placeController.clear();
                                  _clothesController.clear();
                                  _phoneController1.clear();
                                  _phoneController2.clear();

                                },
                                btnOkColor: Colors.orange,
                                btnOkText: 'OK',
                                dismissOnTouchOutside: false,
                              ).show();
                            }
                          },
                          text: 'add_report.send_report'.tr(),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
