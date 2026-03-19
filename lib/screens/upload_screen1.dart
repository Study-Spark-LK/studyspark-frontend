import 'package:flutter/material.dart';
import 'visual_screen.dart';
import 'audio_screen.dart';
import 'analytical_screen.dart';
import 'story_screen.dart';

class UploadScreen1 extends StatefulWidget {
  const UploadScreen1({super.key});

  @override
  State<UploadScreen1> createState() => _UploadScreen1State();
}

class _UploadScreen1State extends State<UploadScreen1> {

  final PageController _controller = PageController();
  int index = 0;

  final List<String> tabs = [
    "Visual",
    "Audio",
    "Analytical",
    "Story"
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),

      appBar: AppBar(
        title: const Text("Upload Learning Material"),
        backgroundColor: const Color(0xFF1A2332),
      ),

      body: Column(
        children: [

          /// TAB BAR
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              itemBuilder: (context,i){

                bool selected = index==i;

                return GestureDetector(
                  onTap: (){
                    _controller.animateToPage(i,
                        duration: const Duration(milliseconds:300),
                        curve: Curves.ease);
                  },

                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal:20),
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.cyan
                          : const Color(0xFF1A2332),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      tabs[i],
                      style: TextStyle(
                        color: selected
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// PAGES
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (i){
                setState(()=> index=i);
              },
              children: const [

                VisualScreen(),
                AudioScreen(),
                AnalyticalScreen(),
                StoryScreen(),

              ],
            ),
          )
        ],
      ),
    );
  }
}