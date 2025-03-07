import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/football.mp4')
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true)
      ..play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    // Video Player
                    SizedBox(
                      height: 400,
                      width: double.infinity,
                      child: _controller.value.isInitialized
                          ? VideoPlayer(_controller)
                          : const Center(child: CircularProgressIndicator()),
                    ),
                    const Positioned(
                      left: 10,
                      top: 10,
                      child: Text("LEBRON JAMES",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: IconButton(
                        icon: const Icon(Icons.volume_up, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _controller.value.volume == 0
                                ? _controller.setVolume(1.0)
                                : _controller.setVolume(0.0);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                // Voting Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ReactionButton(Icons.thumb_up, "222", Colors.green),
                      const SizedBox(width: 16),
                      ReactionButton(Icons.thumb_down, "222", Colors.red),
                    ],
                  ),
                ),
              ],
            ),
            // Floating bottom navigation bar
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home, color: Colors.redAccent),
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(context, '/stories');
                      },
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.card_giftcard, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.person, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Widget for Reaction Buttons
class ReactionButton extends StatelessWidget {
  final IconData icon;
  final String count;
  final Color color;

  const ReactionButton(this.icon, this.count, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 4),
          Text(count, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
