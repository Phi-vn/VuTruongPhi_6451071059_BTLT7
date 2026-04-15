import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../utils/api_helper.dart';
import '../widgets/product_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> _products = [];
  bool _isLoading = false;
  String _message = 'Enter keyword to search products';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleSearch() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      setState(() {
        _products = [];
        _message = 'Please enter a keyword';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      final results = await ApiHelper.searchProducts(query);
      setState(() {
        _products = results;
        _isLoading = false;
        if (results.isEmpty) {
          _message = 'No products found for "$query"';
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _message = 'Error searching products: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Search (MSSV: 6451071059)'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Products',
                hintText: 'e.g. phone, apple, laptop...',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _handleSearch,
                ),
              ),
              onSubmitted: (_) => _handleSearch(),
            ),
          ),
          if (_isLoading)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_message.isNotEmpty)
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  return ProductItem(product: _products[index]);
                },
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
