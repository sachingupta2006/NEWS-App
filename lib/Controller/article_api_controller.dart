import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../Model/article_model.dart';

class ArticlesAPIController extends GetxController {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  ArticlesAPI? _articlesApi;
  // ArticlesAPI? get articlesApi => _articlesApi;

  List<Articles>? _articlesList;
  List<Articles>? get articlesList => _articlesList;

  final String _todaysDate = DateFormat('dd MMMM, yyyy').format(DateTime.now());
  String get todaysDate => _todaysDate;

  List<String> _publishedDates = [];
  List get publishedDates => _publishedDates;

  List<String> _suffixSubtitle = [];
  List get suffixSubtitle => _suffixSubtitle;

  final TextEditingController _tecController = TextEditingController();
  TextEditingController get tecController => _tecController;

  String forAPILink = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().subtract(const Duration(days: 31)));

  getApi() async {
    print(forAPILink);
    try {
      http.Response resp = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=tesla&from=$forAPILink&sortBy=publishedAt&apiKey=38203352c7d948f6b1b0e5277e1421e3'));
      var responseData = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        _articlesApi = ArticlesAPI.fromJson(responseData);

        if (_articlesApi?.articles != null) {
          _articlesList = _articlesApi!.articles;
          _articlesList!.removeWhere((article) => article.title == '[Removed]');

          _publishedDates = _articlesList!.map((e) {
            return formatDate(e.publishedAt ?? '');
          }).toList();

          _suffixSubtitle = _articlesList!.map((e) {
            return getSuffixSubtitle(e.publishedAt!);
          }).toList();
        }

        _isLoading = false;
        update();
      } else {
        Get.snackbar("Error", "${resp.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }
  }

  List<Articles> _searchResults = [];
  List<Articles> get searchResults => _searchResults;

  List<String> _publishedSearchDates = [];
  List get publishedSearchDates => _publishedSearchDates;

  List<String> _suffixSearchSubtitle = [];
  List get suffixSearchSubtitle => _suffixSearchSubtitle;

  searchMethod() {
    if (tecController.text.isNotEmpty) {
      String searchQuery = _tecController.text.toLowerCase();
      _searchResults = _articlesList!.where((e) {
        String title = e.title?.toLowerCase() ?? '';
        return title.contains(searchQuery);
      }).toList();
      _publishedSearchDates = _searchResults.map((e) {
        return formatDate(e.publishedAt ?? '');
      }).toList();

      _suffixSearchSubtitle = _searchResults.map((e) {
        return getSuffixSubtitle(e.publishedAt!);
      }).toList();
    } else {
      _searchResults = [];
      // Get.snackbar("Error", "Please type any key word");
    }
    update();
  }

  String getSuffixSubtitle(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(const Duration(days: 1));

    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return 'Today';
    } else if (date.year == today.year &&
        date.month == today.month &&
        date.day == yesterday.day) {
      return 'Yesterday';
    } else {
      return formatDate(dateStr);
    }
  }

  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat('dd MMMM yyyy').format(dateTime);
  }
}
