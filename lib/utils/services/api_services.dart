import 'dart:convert';

import 'package:news_app/utils/constants/api_constants.dart';
import 'package:news_app/utils/models/articles_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<Articles>> getNews() async {
    final response = await http.get(Uri.parse(url));

    List<Articles> news = [];
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    List<dynamic> responseList = responseMap['articles'];

    for (int i = 0; i < responseList.length; i++) {
      news.add(Articles.fromJson(responseList[i]));
    }

    return news;
  }
}
