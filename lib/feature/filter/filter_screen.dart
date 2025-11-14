import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/core/utils/app_images.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({super.key});
  static const String routeName = "filter";


  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? selectedItem;
  final RangeValues _currentRangeValues = const RangeValues(0, 18);
  List<String> egyptGovernorates = [
    "Cairo",
    "Giza",
    "Alexandria",
    "Qalyubia",
    "Port Said",
    "Suez",
    "Dakahlia",
    "Sharqia",
    "Gharbia",
    "Menoufia",
    "Beheira",
    "Kafr El Sheikh",
    "Fayoum",
    "Beni Suef",
    "Minya",
    "Assiut",
    "Sohag",
    "Qena",
    "Luxor",
    "Aswan",
    "Red Sea",
    "New Valley",
    "Matrouh",
    "North Sinai",
    "South Sinai",
    "Ismailia",
  ];

  List<String> eyeColors = [
    "Brown",
    "Dark Brown",
    "Light Brown",
    "Hazel",
    "Amber",
    "Green",
    "Blue",
    "Gray",
    "Black",
    "Honey",
    "Violet",
  ];

  List<String> hairColors = [
    "Black Hair",
    "Dark Brown Hair",
    "Light Brown Hair",
    "Blonde",
    "Platinum Blonde",
    "Golden Blonde",
    "Red Hair",
    "Auburn",
    "Chestnut",
    "Gray Hair",
    "Silver Hair",
    "White Hair",
    "Blue Hair",
    "Pink Hair",
    "Purple Hair",
    "Green Hair",
  ];

  List<String> specialMarks = [
    "Scar",
    "Birthmark",
    "Mole",
    "Freckles",
    "Tattoo",
    "Piercing",
    "Burn mark",
    "Surgery scar",
    "Missing finger",
    "Missing tooth",
    "Discolored skin patch",
    "Dimple",
    "Eyebrow cut",
    "Broken nose",
    "Limp",
    "Tattooed eyebrow",
    "Braces",
    "None",
  ];



  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(fontWeight: FontWeight.w400);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text("Filter".tr()),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Container(
                decoration: buildBoxDecoration(),
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        "Status".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 26.sp),
                      ),
                      buildRadioListTile("Missing".tr()),
                      buildRadioListTile("Needs Verification".tr()),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.h, right: 16.w, left: 16.w),
              child: Container(
                decoration: buildBoxDecoration(),
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Age".tr(), style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 26.sp)),
                      RangeSlider(
                        values: const RangeValues(0, 18),
                        min: 0,
                        max: 18,
                        divisions: 18,
                        activeColor: AppColors.primaryColor,
                        inactiveColor: AppColors.inactiveTrackbarColor,
                        labels: RangeLabels("${_currentRangeValues.start
                            .round()
                            .toString()} years".tr(), "${_currentRangeValues.end
                            .round().toString()} years".tr()),
                        onChanged: (_) {},
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 7.h),
                        child: Text("Gender", style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.w400),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _GenderButton(color: AppColors.girlIcon,
                            imagePath: AppImages.girl,),
                          SizedBox(width: 20.w),
                          _GenderButton(color: AppColors.boyIcon,
                            imagePath: AppImages.boy,),
                        ],
                      ),
                      SizedBox(height: 5.h,),
                      buildTextField("Skin tone".tr(), "Select Skin tone".tr()),
                      SizedBox(height: 5.h,),
                      buildDropdown("Eye Color".tr(), "Select Eye Color".tr(), eyeColors),
                      SizedBox(height: 5.h,),
                      buildDropdown("Hair Color".tr(), "Select Hair Color".tr(), hairColors),
                      SizedBox(height: 5.h,),
                      buildDropdown("Special Marks (Optional)".tr(), "e.g. a small scar above the eyebrow".tr(), specialMarks),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(right: 16.w, left: 16.w, bottom: 16.h),
              child: Container(
                decoration: buildBoxDecoration(),
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDropdown( "Governorate".tr(), "example: Cairo, Giza, Alexandria".tr(),egyptGovernorates ),
                      SizedBox(height:5.h ,),
                      buildTextField("Area".tr(), "example: Nasr city, Maadi, Shopra".tr()),
                    ],
              ),
                  ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 16.h),
              child: Container(
                decoration: buildBoxDecoration(),
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextField("Date (Select the date of last viewing)".tr(),"Day/Month/Year".tr())
           ],
        ),
      ),
              ),
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.only(right: 50.w,left: 50.w,bottom: 35.h),
              child: SizedBox(
                width: double.infinity.w,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                  ),
                  child: Text(
                    "Add".tr(),
                    style: TextStyle(fontSize: 24.sp, color: AppColors.white),
                  ),
                ),
              ),
            )

          ]
    ),
    ),
    );
  }

  RadioListTile<String?> buildRadioListTile(String text) {
    return RadioListTile(
                        title: Text( text , style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w400),),
                        value: "",
                        shape: StadiumBorder(
                          side: BorderSide(color: AppColors.primaryColor),
                        ),
                        fillColor:  MaterialStateProperty.all(AppColors.primaryColor),
                        activeColor: AppColors.primaryColor,
                        tileColor: AppColors.primaryColor,
                        selectedTileColor: AppColors.primaryColor,
                        groupValue: null,
                        onChanged: (_) {},
                      );
  }

  Column buildTextField(String text, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24.sp),),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.inactiveTrackbarColor),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(color: AppColors.primaryColor)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(color: AppColors.primaryColor)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(color: AppColors.primaryColor)
            ),
          ),
        ),
      ],
    );
  }

  Column buildDropdown(String text, String hint, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 4.h),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.hintTextColor, fontSize: 16.sp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          ),
          value: selectedItem,
          hint: Text(hint, style: TextStyle(fontSize: 16.sp)),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item.tr(), style: TextStyle(fontSize: 16.sp)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedItem = newValue;
            });
          },
          validator: (value) {
            if (value == null) {
              return 'هذا الحقل مطلوب';
            }
            return null;
          },
        ),
      ],
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                color: AppColors.white,
              );
  }
}

class _GenderButton extends StatefulWidget {
  final Color color;
  final String imagePath;

  const _GenderButton({
    required this.color,
    required this.imagePath,
  });

  @override
  State<_GenderButton> createState() => _GenderButtonState();
}

class _GenderButtonState extends State<_GenderButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 90.w,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: widget.color),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Image.asset(
              widget.imagePath,
              width: 60.w,
              height: 60.h,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}



