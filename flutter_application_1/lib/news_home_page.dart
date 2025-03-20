import 'package:flutter/material.dart';

class NewsHomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  const NewsHomePage({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildTabBar(),
            _showSearch ? _buildSearchBar() : const SizedBox.shrink(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTabContent('For You'),
                  _buildTabContent('Sports'),
                  _buildTabContent('Business'),
                  _buildTabContent('Technology'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "News Hunt",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.brightness_6),
                onPressed: widget.toggleTheme,
              ),
              IconButton(
                icon: Icon(_showSearch ? Icons.close : Icons.search),
                onPressed: () {
                  setState(() {
                    _showSearch = !_showSearch;
                    if (!_showSearch) _searchController.clear();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: Colors.red,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.red,
      tabs: const [
        Tab(text: "For You"),
        Tab(text: "Sports"),
        Tab(text: "Business"),
        Tab(text: "Technology"),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search for news...",
          fillColor: Colors.grey[200],
          filled: true,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
