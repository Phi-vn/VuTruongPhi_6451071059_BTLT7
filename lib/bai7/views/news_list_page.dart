import 'package:flutter/material.dart';
import '../models/article.dart';
import '../utils/api_helper.dart';
import '../widgets/article_tile.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  List<Article> _articles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  Future<void> _handleRefresh() async {
    try {
      final articles = await ApiHelper.fetchArticles();
      setState(() {
        _articles = articles;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading news: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App (MSSV: 6451071059)'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _handleRefresh,
              child: ListView.builder(
                itemCount: _articles.length,
                itemBuilder: (context, index) {
                  return ArticleTile(article: _articles[index]);
                },
              ),
            ),
    );
  }
}
