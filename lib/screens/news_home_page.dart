import 'dart:convert'; // Pour le décodage JSON
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart'; // Pour ouvrir les URLs des articles
import 'package:http/http.dart' as http;
import '../widgets/navbar/bottom_navbar.dart';

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
  int _selectedIndex = 2;

  // Liste d'articles et gestion d'état
  List<dynamic> _newsArticles = [];
  List<dynamic> _sportsArticles = [];
  bool _isLoading = true;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchNews(); // Récupération des nouvelles générales
    _fetchSportsNews(); // Récupération des nouvelles sportives
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Récupération des nouvelles générales
  Future<void> _fetchNews() async {
    const String apiKey =
        'e8b26cfcce004d3594ddf19d95f1eebc'; // Remplacez par votre clé NewsAPI.org
    final String url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        setState(() {
          _newsArticles = body['articles'] as List<dynamic>;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMsg = 'Erreur serveur : ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMsg = 'Une erreur est survenue : $e';
        _isLoading = false;
      });
    }
  }

  // Récupération des nouvelles sportives
  Future<void> _fetchSportsNews() async {
    const String apiKey =
        'e8b26cfcce004d3594ddf19d95f1eebc'; // Remplacez par votre clé NewsAPI.org
    final String url =
        'https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        setState(() {
          _sportsArticles = body['articles'] as List<dynamic>;
        });
      } else {
        print(
            'Erreur lors de la récupération des nouvelles sportives: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception lors de la récupération des nouvelles sportives: $e');
    }
  }

  // Recherche d'articles
  void _searchArticles(String query) {
    if (query.isEmpty) {
      _fetchNews(); // Réinitialiser les résultats si la recherche est vide
      return;
    }

    const String apiKey = 'e8b26cfcce004d3594ddf19d95f1eebc';
    final String url =
        'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';

    setState(() {
      _isLoading = true;
    });

    http.get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        setState(() {
          _newsArticles = body['articles'] as List<dynamic>;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMsg = 'Erreur de recherche : ${response.statusCode}';
          _isLoading = false;
        });
      }
    }).catchError((e) {
      setState(() {
        _errorMsg = 'Erreur lors de la recherche : $e';
        _isLoading = false;
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/stories');
        break;
      case 2:
        // Reste sur NewsHomePage
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }
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
                  _buildSportsTab(), // Onglet Sports avec les articles sportifs
                  _buildNewsTab(), // Onglet News avec les articles généraux
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
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
            'El Goat News',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 197, 194, 194)),
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
                    if (!_showSearch) {
                      _searchController.clear();
                      _fetchNews(); // Réinitialiser les résultats quand on ferme la recherche
                    }
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
        Tab(text: 'Sports'),
        Tab(text: 'News'),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search for news...',
          fillColor: Colors.grey[200],
          filled: true,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: _searchArticles,
      ),
    );
  }

  // Affichage des articles sportifs
  Widget _buildSportsTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_sportsArticles.isEmpty) {
      return const Center(child: Text('Aucun article sportif trouvé'));
    }
    return _buildArticlesList(_sportsArticles);
  }

  // Affichage des articles généraux
  Widget _buildNewsTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMsg != null) {
      return Center(child: Text(_errorMsg!));
    }
    if (_newsArticles.isEmpty) {
      return const Center(child: Text('Aucun article trouvé'));
    }
    return _buildArticlesList(_newsArticles);
  }

  // Méthode commune pour afficher une liste d'articles
  Widget _buildArticlesList(List<dynamic> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index] as Map<String, dynamic>;
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          child: InkWell(
            onTap: () {
              if (article['url'] != null) {
                launchUrlString(article['url']);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (article['urlToImage'] != null)
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(4)),
                    child: Image.network(
                      article['urlToImage'],
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 180,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.image_not_supported, size: 50),
                          ),
                        );
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article['title'] ?? 'Sans titre',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        article['description'] ??
                            'Aucune description disponible',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            article['source']?['name'] ?? 'Source inconnue',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (article['publishedAt'] != null)
                            Text(
                              _formatDate(article['publishedAt']),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Formater la date pour l'affichage
  String _formatDate(String dateString) {
    try {
      final DateTime date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
