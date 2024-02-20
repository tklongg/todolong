import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SearchPreferences {
  final String _key = "search_pref";
  Future<List<String>> getSearchPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(_key) ?? [];
  }

  Future<void> addSearchPref(String searchStr) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> searchPref = prefs.getStringList(_key) ?? [];
    if (searchPref.length >= 5) {
      searchPref.removeAt(0);
      searchPref.add(searchStr);
      log("searchPref: $searchPref");
    } else {
      log("searchPref: $searchPref");
      searchPref.add(searchStr);
    }
    // searchPref.add("test");
    prefs.setStringList(_key, searchPref);
  }
}
