import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_item.dart';
import 'cache_manager.dart';

class ApiHelper {
  static const String url = 'https://jsonplaceholder.typicode.com/posts';
  static const String cacheKey = 'news_data';

  static Future<List<NewsItem>> getNews() async {
    // 1. Try to load from cache
    final cachedData = CacheManager.loadCache(cacheKey);
    if (cachedData != null) {
      print('DEBUG: Loading news from Cache');
      List<dynamic> list = cachedData;
      return list.map((json) => NewsItem.fromJson(json)).toList();
    }

    // 2. If no cache, call API
    print('DEBUG: Fetching news from API');
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // We take a subset for demo
      final results = data.take(15).toList();
      
      // 3. Save to cache
      CacheManager.saveCache(cacheKey, results);
      
      return results.map((json) => NewsItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
