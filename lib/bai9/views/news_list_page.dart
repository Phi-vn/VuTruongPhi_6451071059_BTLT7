import 'package:flutter/material.dart';
import '../models/news_item.dart';
import '../utils/api_helper.dart';
import '../utils/cache_manager.dart';
import '../widgets/news_card.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late Future<List<NewsItem>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = ApiHelper.getNews();
  }

  void _onRefresh() {
    setState(() {
      _newsFuture = ApiHelper.getNews();
    });
  }

  void _clearCacheAndRefresh() {
    CacheManager.clearCache();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cache Cleared!')),
    );
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cached News (MSSV: 6451071059)'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _clearCacheAndRefresh,
            tooltip: 'Clear Cache & Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _onRefresh,
            tooltip: 'Refresh (uses cache if available)',
          ),
        ],
      ),
      body: FutureBuilder<List<NewsItem>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available.'));
          } else {
            final newsList = snapshot.data!;
            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                return NewsCard(news: newsList[index]);
              },
            );
          }
        },
      ),
    );
  }
}
