import 'dart:convert';

class CacheManager {
  // Simple memory cache
  static final Map<String, String> _memoryCache = {};

  static void saveCache(String key, dynamic data) {
    _memoryCache[key] = json.encode(data);
  }

  static dynamic loadCache(String key) {
    if (_memoryCache.containsKey(key)) {
      return json.decode(_memoryCache[key]!);
    }
    return null;
  }

  static void clearCache() {
    _memoryCache.clear();
  }
}
