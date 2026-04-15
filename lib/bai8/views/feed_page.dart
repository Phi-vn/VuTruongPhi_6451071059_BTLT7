import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../utils/api_helper.dart';
import '../widgets/post_card.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final List<PostModel> _posts = [];
  final ScrollController _scrollController = ScrollController();
  
  int _page = 1;
  static const int _limit = 10;
  bool _isLoading = true;
  bool _isFetchingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchInitialPosts();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _fetchInitialPosts() async {
    try {
      final posts = await ApiHelper.fetchPosts(_page, _limit);
      setState(() {
        _posts.addAll(posts);
        _isLoading = false;
        if (posts.length < _limit) _hasMore = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        !_isFetchingMore &&
        _hasMore) {
      _loadMorePosts();
    }
  }

  Future<void> _loadMorePosts() async {
    setState(() => _isFetchingMore = true);
    _page++;

    try {
      final posts = await ApiHelper.fetchPosts(_page, _limit);
      
      if (mounted) {
        setState(() {
          _posts.addAll(posts);
          _isFetchingMore = false;
          if (posts.length < _limit) _hasMore = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isFetchingMore = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading more: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Feed (MSSV: 6451071059)'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: _posts.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < _posts.length) {
                  return PostCard(post: _posts[index]);
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
