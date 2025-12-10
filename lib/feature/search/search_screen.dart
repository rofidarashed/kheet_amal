import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/widgets/custom_app_bar.dart';
import 'package:kheet_amal/feature/add_report/data/backblaze_service.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/search/widgets/custom_search_row.dart';
import 'package:kheet_amal/feature/search/widgets/custom_search_failed.dart';
import 'package:kheet_amal/feature/search/widgets/custom_search_success.dart';
import 'package:kheet_amal/feature/filter/filter_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  List<ReportModel> searchResults = [];
  bool isSearching = false;
  bool hasSearched = false;
  final TextEditingController _searchController = TextEditingController();

  String? selectedStatus;
  String? selectedGovernorate;
  String? selectedEyeColor;
  String? selectedHairColor;
  String? selectedSpecialMark;
  String selectedGender = "";
  RangeValues? selectedAgeRange;
  String? selectedDate;

  Future<void> searchInFirestore(String query) async {
    setState(() {
      isSearching = true;
      hasSearched = true;
    });

    try {
      Query reportsRef = FirebaseFirestore.instance.collection('reports');

      if (query.isNotEmpty) {
        reportsRef = reportsRef
            .where('childName', isGreaterThanOrEqualTo: query)
            .where('childName', isLessThanOrEqualTo: '$query\uf8ff');
      }

      if (selectedStatus != null)
        reportsRef = reportsRef.where('status', isEqualTo: selectedStatus);
      if (selectedGovernorate != null)
        reportsRef = reportsRef.where(
          'governorate',
          isEqualTo: selectedGovernorate,
        );
      if (selectedGender.isNotEmpty)
        reportsRef = reportsRef.where('gender', isEqualTo: selectedGender);
      if (selectedEyeColor != null)
        reportsRef = reportsRef.where('eyeColor', isEqualTo: selectedEyeColor);
      if (selectedHairColor != null)
        reportsRef = reportsRef.where(
          'hairColor',
          isEqualTo: selectedHairColor,
        );
      if (selectedSpecialMark != null)
        reportsRef = reportsRef.where(
          'specialMark',
          isEqualTo: selectedSpecialMark,
        );

      if (selectedAgeRange != null) {
        reportsRef = reportsRef
            .where('endAge', isGreaterThanOrEqualTo: selectedAgeRange!.start)
            .where('endAge', isLessThanOrEqualTo: selectedAgeRange!.end);
      }

      if (selectedDate != null && selectedDate!.isNotEmpty) {
        reportsRef = reportsRef.where('lastSeenDate', isEqualTo: selectedDate);
      }

      QuerySnapshot querySnapshot = await reportsRef.get();

      List<ReportModel> results = [];

      for (final doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;

        String imageUrl = data['imageUrl'] ?? '';

        if (imageUrl.contains('reports/')) {
          final fileName = imageUrl.split('reports/').last;

          final secureUrl = await BackblazeService.getTemporaryImageUrl(
            'reports/$fileName',
          );

          if (secureUrl != null) {
            imageUrl = secureUrl;
          }
        }

        results.add(
          ReportModel.fromMap(doc.id, {...data, 'imageUrl': imageUrl}),
        );
      }

      setState(() {
        searchResults = results;
        isSearching = false;
      });
    } catch (e) {
      print('Error during search: $e');
      setState(() {
        isSearching = false;
      });
    }
  }

  Future<void> fetchLatestCases() async {
    setState(() {
      isSearching = true;
    });

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('reports')
          .orderBy('createdAt', descending: true)
          .limit(10)
          .get();

      List<ReportModel> reports = [];

      for (final doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;

        String imageUrl = data['imageUrl'] ?? '';

        if (imageUrl.contains('reports/')) {
          final fileName = imageUrl.split('reports/').last;

          final secureUrl = await BackblazeService.getTemporaryImageUrl(
            'reports/$fileName',
          );

          if (secureUrl != null) {
            imageUrl = secureUrl;
          }
        }

        reports.add(
          ReportModel.fromMap(doc.id, {...data, 'imageUrl': imageUrl}),
        );
      }

      setState(() {
        searchResults = reports;
        isSearching = false;
      });
    } catch (e) {
      print("Error loading cases: $e");
      setState(() => isSearching = false);
    }
  }

  void updateResults(List<ReportModel> newResults) {
    setState(() {
      searchResults = newResults;
      hasSearched = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchLatestCases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'search'.tr()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),

              customSearchRow(
                context: context,
                controller: _searchController,
                onSearch: searchInFirestore,
                onFilterTap: () async {
                  final filters = await PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: FilterScreen(),
                    withNavBar: false,
                  );
                  if (filters != null) {
                    setState(() {
                      selectedStatus = filters['status'];
                      selectedGovernorate = filters['governorate'];
                      selectedGender = filters['gender'];
                      selectedEyeColor = filters['eyeColor'];
                      selectedHairColor = filters['hairColor'];
                      selectedSpecialMark = filters['specialMark'];
                      selectedAgeRange = filters['ageRange'];
                      selectedDate = filters['date'];
                    });
                    searchInFirestore(_searchController.text);
                  }
                },
              ),

              SizedBox(height: 30.h),

              if (!hasSearched)
                Column(
                  children: [
                    SvgPicture.asset(
                      "assets/svgs/search_image.svg",
                      height: 200.h,
                      width: 200.w,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "search_message".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),

              if (isSearching)
                const Center(child: CircularProgressIndicator())
              else if (searchResults.isNotEmpty)
                customSearchSuccess(context: context, results: searchResults)
              else if (hasSearched && searchResults.isEmpty)
                customSearchFailed(
                  context: context,
                  updateResults: updateResults,
                  fetchLatestCases: fetchLatestCases,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
