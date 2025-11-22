import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/widgets/custom_app_bar.dart';
import 'package:kheet_amal/feature/search/widgets/custom_search_row.dart';
import 'package:kheet_amal/feature/search/widgets/custom_search_failed.dart';
import 'package:kheet_amal/feature/search/widgets/custom_search_success.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  List<DocumentSnapshot> searchResults = [];
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  Future<void> searchInFirestore(String query) async {
    print('Starting search with query: $query');
    if (query.isEmpty) {
      print('Query is empty, clearing results');
      setState(() {
        searchResults = [];
        isSearching = false;
      });
      return;
    }

    setState(() {
      isSearching = true;
    });

    try {
      print('Querying Firestore for: $query');
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('reports')
          .where('childName', isGreaterThanOrEqualTo: query)
          .where('childName', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      print('Firestore query returned ${querySnapshot.docs.length} results');
      setState(() {
        searchResults = querySnapshot.docs;
        isSearching = false;
      });
    } catch (e) {
      print('Error during search: $e');
      setState(() {
        isSearching = false;
      });
    }
  }

  void updateResults(List<DocumentSnapshot> newResults) {
    setState(() {
      searchResults = newResults;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'search'.tr(), notificationsCount: 3),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            customSearchRow(
              context: context,
              controller: _searchController,
              onSearch: searchInFirestore,
            ),
            SizedBox(height: 30.h),
            isSearching
                ? const Center(child: CircularProgressIndicator())
                : searchResults.isNotEmpty
                ? customSearchSuccess(context: context, results: searchResults)
                : customSearchFailed(
              context: context,
              updateResults: updateResults,
            ),
          ],
        ),
      ),
    );
  }
}