import 'package:flutter/material.dart';
import '../utils/api_helper.dart';
import '../widgets/dashboard_sections.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Map<String, dynamic>> _dashboardData;

  @override
  void initState() {
    super.initState();
    _dashboardData = ApiHelper.getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard (MSSV: 6451071059)'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dashboardData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          } else {
            final data = snapshot.data!;
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _dashboardData = ApiHelper.getDashboardData();
                });
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserSection(user: data['user']),
                    const SizedBox(height: 24),
                    PostSection(posts: data['posts']),
                    const SizedBox(height: 24),
                    ProductSection(products: data['products']),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
