import 'package:flutter/material.dart';
import '../widgets/navbar/bottom_navbar.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({super.key});

  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {
  int _selectedIndex = 1;
  int _expandedIndex = -1;

  final List<Map<String, String>> storiesArr = [
    {
      "name": "Story 1",
      "image": "assets/images/1.jpg",
      "title": "Rising Star",
      "subtitle": "This is the first story",
      "fullTitle": "From the Streets to Stardom",
      "fullText":
          "This athlete began playing football barefoot in his neighborhood and went on to become a national sensation. Through dedication, hardship, and unbreakable spirit, he earned his place among the elite."
    },
    {
      "name": "Story 2",
      "image": "assets/images/2.jpg",
      "title": "Late Bloomer",
      "subtitle": "This is the second story",
      "fullTitle": "The Unexpected Journey",
      "fullText":
          "Rejected by academies in his youth, this player didn't give up. He trained alone, got picked up by a second-tier team, and now he's a starter in the premier league."
    },
    {
      "name": "Story 3",
      "image": "assets/images/5.jpeg",
      "title": "Hometown Hero",
      "subtitle": "This is the third story",
      "fullTitle": "Carrying the Hopes of His Village",
      "fullText":
          "Coming from a small town with no facilities, this young man became the first professional footballer from his region. His story inspires kids from underserved communities."
    },
    {
      "name": "Story 4",
      "image": "assets/images/3.jpg",
      "title": "Comeback King",
      "subtitle": "This is the fourth story",
      "fullTitle": "Back from the Brink",
      "fullText":
          "After a career-threatening injury, many thought his days were over. But with therapy and fierce mental strength, he returned stronger and more determined than ever."
    },
    {
      "name": "Story 5",
      "image": "assets/images/mb.jpeg",
      "title": "Young Prodigy",
      "subtitle": "This is the fifth story",
      "fullTitle": "Destined for Greatness",
      "fullText":
          "Debuting at just 16, this young phenom wowed fans with his talent. Mentored by legends, he’s now setting records and rewriting history books with every match."
    },
    {
      "name": "Story 6",
      "image": "assets/images/cr7.jpeg",
      "title": "Legend",
      "subtitle": "This is the sixth story",
      "fullTitle": "Legacy of a Champion",
      "fullText":
          "His work ethic, hunger, and ability to perform under pressure made him a global icon. His journey from poverty to greatness is a blueprint for aspiring players everywhere."
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        // Stay on StoriesPage
        break;
      case 2:
        Navigator.pushNamed(context, '/news');
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(220, 12, 9, 0),
              Color.fromARGB(255, 136, 98, 49)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          itemCount: storiesArr.length,
          itemBuilder: (context, index) {
            var sObj = storiesArr[index];
            bool isExpanded = _expandedIndex == index;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          sObj["image"]!,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width * 0.5,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: index % 2 == 0
                              ? Colors.black.withOpacity(0.6)
                              : Colors.black.withOpacity(0.4),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 16,
                        child: Text(
                          sObj["title"]!,
                          style: const TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    sObj["name"]!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sObj["subtitle"]!,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sObj["fullTitle"] ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            sObj["fullText"] ?? "",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    crossFadeState: isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _expandedIndex = isExpanded ? -1 : index;
                        });
                      },
                      child: Text(
                        isExpanded ? "See Less" : "See More",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
