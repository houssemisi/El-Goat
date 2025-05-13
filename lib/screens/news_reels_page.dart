import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/navbar/bottom_navbar.dart';

class NewsReelsPage extends StatefulWidget {
  const NewsReelsPage({Key? key}) : super(key: key);

  @override
  State<NewsReelsPage> createState() => _NewsReelsPageState();
}

class _NewsReelsPageState extends State<NewsReelsPage> {
  final List<String> videoUrls = [
    'assets/videos/goal1.mp4',
    'assets/videos/goal2.mp4',
    'assets/videos/goal3.mp4',
    'assets/videos/football.mp4',
  ];

  final PageController _pageController = PageController();
  final List<VideoPlayerController> _controllers = [];

  int _currentIndex = 0;
  int _selectedIndex = 2;
  bool _isMuted = false;

  List<bool> isLiked = [];
  List<int> likeCounts = [];
  List<bool> showHeart = [];
  List<List<String>> comments = [];

  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    isLiked = List.filled(videoUrls.length, false);
    likeCounts = List.filled(videoUrls.length, 0);
    showHeart = List.filled(videoUrls.length, false);
    comments = List.generate(videoUrls.length, (_) => []);
    _loadLikes();
    _loadComments();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    _pageController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _initializeControllers() async {
    for (final url in videoUrls) {
      final controller = VideoPlayerController.asset(url);
      await controller.initialize();
      controller.setLooping(true);
      controller.setVolume(_isMuted ? 0.0 : 1.0);
      _controllers.add(controller);
    }

    _controllers[0].play();
    setState(() {});
  }

  Future<void> _loadLikes() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    for (int i = 0; i < videoUrls.length; i++) {
      final videoPath = videoUrls[i];

      final res =
          await supabase.from('likes').select().eq('video_path', videoPath);
      likeCounts[i] = res.length;

      if (user != null) {
        final userLike = await supabase
            .from('likes')
            .select()
            .eq('video_path', videoPath)
            .eq('user_id', user.id);
        isLiked[i] = userLike.isNotEmpty;
      }
    }

    setState(() {});
  }

  Future<void> _loadComments() async {
    final supabase = Supabase.instance.client;

    for (int i = 0; i < videoUrls.length; i++) {
      final video = videoUrls[i];

      final res = await supabase
          .from('comments')
          .select('content')
          .eq('video_path', video)
          .order('created_at', ascending: true);

      comments[i] = List<String>.from(res.map((e) => e['content']));
    }

    setState(() {});
  }

  Future<void> _handleLike(int index) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    final videoPath = videoUrls[index];

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to like')),
      );
      return;
    }

    setState(() {
      isLiked[index] = !isLiked[index];
      likeCounts[index] += isLiked[index] ? 1 : -1;
    });

    if (isLiked[index]) {
      await supabase.from('likes').insert({
        'user_id': user.id,
        'video_path': videoPath,
      });
    } else {
      await supabase
          .from('likes')
          .delete()
          .eq('user_id', user.id)
          .eq('video_path', videoPath);
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _controllers[_currentIndex].pause();
      _currentIndex = index;
      _controllers[_currentIndex].play();
    });
  }

  void _togglePlayPause() {
    final controller = _controllers[_currentIndex];
    setState(() {
      if (controller.value.isPlaying) {
        controller.pause();
      } else {
        controller.play();
      }
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      for (var controller in _controllers) {
        controller.setVolume(_isMuted ? 0.0 : 1.0);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/stories');
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  void _openCommentsSheet(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 10,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Comments',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: comments[index].length,
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      comments[index][i],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Add a comment...',
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () async {
                      final comment = _commentController.text.trim();
                      final supabase = Supabase.instance.client;
                      final user = supabase.auth.currentUser;

                      if (comment.isNotEmpty && user != null) {
                        await supabase.from('comments').insert({
                          'user_id': user.id,
                          'video_path': videoUrls[index],
                          'content': comment,
                        });

                        _commentController.clear();
                        Navigator.pop(context);
                        await _loadComments();
                        _openCommentsSheet(index);
                      } else if (user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please login to comment')),
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('El Goat'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: _controllers.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: _controllers.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                final controller = _controllers[index];

                return Stack(
                  children: [
                    GestureDetector(
                      onTap: _togglePlayPause,
                      onDoubleTap: () {
                        if (!isLiked[index]) {
                          _handleLike(index);
                          setState(() => showHeart[index] = true);
                          Future.delayed(const Duration(milliseconds: 800), () {
                            setState(() => showHeart[index] = false);
                          });
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox.expand(
                            child: controller.value.isInitialized
                                ? VideoPlayer(controller)
                                : const Center(
                                    child: CircularProgressIndicator()),
                          ),
                          if (showHeart[index])
                            const Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 100,
                            ),
                        ],
                      ),
                    ),

                    // Mute button
                    Positioned(
                      top: 20,
                      right: 20,
                      child: IconButton(
                        icon: Icon(
                          _isMuted ? Icons.volume_off : Icons.volume_up,
                          color: Colors.white,
                        ),
                        onPressed: _toggleMute,
                      ),
                    ),

                    // Buttons column
                    Positioned(
                      bottom: 60,
                      right: 15,
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              isLiked[index]
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isLiked[index] ? Colors.red : Colors.white,
                              size: 32,
                            ),
                            onPressed: () => _handleLike(index),
                          ),
                          Text(
                            '${likeCounts[index]}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          IconButton(
                            icon: const Icon(Icons.comment,
                                color: Colors.white, size: 30),
                            onPressed: () => _openCommentsSheet(index),
                          ),
                          Text(
                            '${comments[index].length}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

