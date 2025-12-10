import 'dart:io';
import 'dart:ui' as ui;

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';
import 'package:kheet_amal/core/utils/app_validators.dart';
import 'package:kheet_amal/core/widgets/custom_form_field.dart';
import 'package:kheet_amal/feature/add_report/cubit/add_report_cubit.dart';
import 'package:kheet_amal/feature/add_report/cubit/add_report_state.dart';
import 'package:kheet_amal/feature/add_report/enums/enums.dart';
import 'package:kheet_amal/feature/add_report/presentation/dropdown_helper.dart';
import 'package:kheet_amal/feature/add_report/presentation/widgets/custom_add_report_card.dart';
import 'package:kheet_amal/feature/add_report/presentation/widgets/custom_drop_down.dart';
import 'package:kheet_amal/feature/add_report/presentation/widgets/custom_radio.dart';

Container childFeatures(
  BuildContext context,
  AddReportState state,
  AddReportCubit cubit,
) {
  final nameController = cubit.nameController;
  final marksController = cubit.marksController;

  return customAddReportCard(
    context,
    children: [
      CustomFormField(
        hint: 'add_report.enter_child_name'.tr(),
        controller: nameController,
        title: 'add_report.child_name'.tr(),
        validator: (p0) =>
            AppValidators.displayNamevalidator(nameController.text),
      ),
      SizedBox(height: 12.h),
      Text('add_report.gender'.tr(), style: TextStyle(fontSize: 20.sp)),
      CustomRadio(
        selected: state.gender == GenderType.male,
        label: 'add_report.male'.tr(),
        onTap: () => cubit.selectGender(GenderType.male),
      ),
      CustomRadio(
        selected: state.gender == GenderType.female,
        label: 'add_report.female'.tr(),
        onTap: () => cubit.selectGender(GenderType.female),
      ),
      SizedBox(height: 12.h),
      Text('add_report.age'.tr(), style: TextStyle(fontSize: 20.sp)),
      CustomAgeSlider(cubit: cubit, state: state,),
      SizedBox(height: 8.h),
      CustomDropdown<SkinColor>(
        title: 'add_report.skin_color'.tr(),
        options: skinColors,
        onChanged: (selected) {
          if (selected != null) {
            cubit.selectSkinColor(selected);
          }
        },
        hint: "add_report.select_skin_color".tr(),
      ),
      CustomDropdown<EyeColor>(
        title: 'add_report.eye_color'.tr(),
        options: eyeColors,
        hint: 'add_report.select_eye_color'.tr(),
        onChanged: (selected) {
          if (selected != null) {
            cubit.selectEyeColor(selected);
          }
        },
      ),
      CustomDropdown<HairColor>(
        title: 'add_report.hair_color'.tr(),
        options: hairColor,
        hint: 'add_report.select_hair_color'.tr(),
        onChanged: (selected) {
          if (selected != null) {
            cubit.selectHairColor(selected);
          }
        },
      ),
      /////////////////////////////////////
      /*CustomDropdown(
        title: 'add_report.skin_color'.tr(),
        options: skinColors,
        onChanged: (selected) {
          if (selected != null) {
            SkinColor? skinColor = stringToSkinColor(selected);
            if (skinColor != null) {
             cubit.selectSkinColor(skinColor);
            }
          }
        },
        hint: "add_report.select_skin_color".tr(),
      ),
      CustomDropdown(
        title: 'add_report.eye_color'.tr(),
        options: eyeColors,
        hint: 'add_report.select_eye_color'.tr(),
        onChanged: (selected) {
          if (selected != null) {
            EyeColor? eyeColor = stringToEyeColor(selected);
            if (eyeColor != null) {
              cubit.selectEyeColor(eyeColor);
            }
          }
        },
      ),
      CustomDropdown(
        title: 'add_report.hair_color'.tr(),
        options: hairColor,
        hint: 'add_report.select_hair_color'.tr(),
        onChanged: (selected) {
          if (selected != null) {
            HairColor? hairColor = stringToHairColor(selected);
            if (hairColor != null) {
              cubit.selectHairColor(hairColor);
            }
          }
        },
      ),*/
      SizedBox(height: 12.h),
      CustomFormField(
        maxLines: 2,
        hint: 'add_report.example_mark'.tr(),
        controller: marksController,
        title: 'add_report.distinctive_marks'.tr(),
        subtitle: 'add_report.optional'.tr(),
      ),
      SizedBox(height: 12.h),
      Row(
        children: [
          Text(
            'add_report.attach_photo'.tr(),
            style: TextStyle(fontSize: 20.sp),
          ),
          SizedBox(width: 8.w),
          Text(
            'add_report.attach_recent_photo'.tr(),
            style: TextStyle(color: AppColors.black, fontSize: 13.sp),
          ),
        ],
      ),
      SizedBox(height: 8.h),
      FormField<File?>(
        validator: (value) {
          if (state.image == null) {
            return 'add_report.attach_recent_photo'.tr();
          }
          return null;
        },
        builder: (fieldState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => cubit.selectImage(),
                child: state.image == null
                    ? SizedBox(
                        width: double.infinity,
                        height: 140.h,
                        child: DottedBorder(
                          options: RectDottedBorderOptions(
                            dashPattern: [7, 10],
                            strokeWidth: 1,
                            color: AppColors.primaryColor,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppIcons.addImageIcon),
                                SizedBox(height: 8.h),
                                Text(
                                  'Add Photo',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: AppColors.hintTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 200.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            state.image!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
              ),
              if (fieldState.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    fieldState.errorText!,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          );
        },
      ),
    ],
  );
}

class CustomAgeSlider extends StatelessWidget {
  const CustomAgeSlider({super.key, required this.cubit, required this.state});
  final AddReportCubit cubit;
  final AddReportState state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          child: FlutterSlider(
            values: [state.startAge.toDouble(), state.endAge.toDouble()],
            min: 0,
            max: 17,
            rangeSlider: true,
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBar: BoxDecoration(
                color: AppColors.inactiveTrackbarColor,
              ),
              activeTrackBar: BoxDecoration(color: AppColors.primaryColor),
              activeTrackBarHeight: 5.h,
            ),
            tooltip: FlutterSliderTooltip(
              positionOffset: FlutterSliderTooltipPositionOffset(top: 55),

              alwaysShowTooltip: true,
              disabled: false,
              custom: (value) {
                return Text(
                  '${value.toInt()} ${'add_report.years'.tr()}',
                  style: TextStyle(fontSize: 14.sp),
                  textDirection: context.locale.languageCode == 'ar'
                      ? ui.TextDirection.rtl
                      : ui.TextDirection.ltr,
                );
              },
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) =>
                cubit.selectAge(lowerValue.toInt(), upperValue.toInt()),
            handler: FlutterSliderHandler(
              decoration: BoxDecoration(),
              child: Material(
                type: MaterialType.circle,
                color: AppColors.primaryColor,
                elevation: 0,
                child: Container(
                  width: 29.w,
                  height: 29.h,
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.circle, color: Colors.white, size: 11),
                ),
              ),
            ),
            rightHandler: FlutterSliderHandler(
              decoration: BoxDecoration(),
              child: Material(
                type: MaterialType.circle,
                color: AppColors.primaryColor,
                elevation: 0,
                child: Container(
                  width: 29,
                  height: 29,
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.circle, color: AppColors.white, size: 11),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
