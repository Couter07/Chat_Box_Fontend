import 'package:flutter/material.dart';
import 'package:flutter_check/view/map.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({super.key});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<String> messages = [];
  Color colors = Color.fromARGB(255, 255, 255, 255);
  Color colorsText = Color.fromARGB(255, 0, 0, 0);
  Color colorsLevel1 = Color.fromARGB(255, 78, 166, 224);
  Color colorsLevel2 = Color.fromARGB(255, 78, 166, 224);
  Color colorsLevel3 = Color.fromARGB(255, 78, 166, 224);
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          color: colors,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Avatar bên trái
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/images/Robot_Icon.jpeg',
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ),

                // Tiêu đề ở giữa (dùng Expanded để canh giữa)
                Expanded(
                  child: Center(
                    child: Text(
                      'Chat Box Map',
                      style: TextStyle(
                        color: colorsText,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoMono',
                      ),
                    ),
                  ),
                ),

                // Icon bên phải
                IconButton(
                  onPressed: () {
                    _changeTheme();
                  },
                  icon: Icon(Icons.brightness_6, color: colorsText),
                ),




                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapPage()),
                    );
                  },
                  icon: Icon(Icons.map, color: colorsText),
                ),

                


                
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: colors,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (_, index) =>
                        _buildMessageTile(messages[index], colors),
                    reverse: false,
                    controller: _scrollController,
                  ),
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: colors,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Color.fromARGB(255, 78, 166, 224),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 211, 219, 225),
                        ),
                        fillColor: colors,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      style: TextStyle(color: colorsText, fontSize: 16.0),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Color.fromARGB(255, 78, 166, 224),
                    ),
                    onPressed: () {
                      _sendMessage();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageTile(String message, Color colors) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message,
          style: TextStyle(color: colorsText, fontSize: 16.0),
        ),
      ),
    );
  }

  void _sendMessage() {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        messages.add(message);
        _controller.clear();
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _changeTheme() {
    setState(() {
      if (check) {
        check = false;
        colors = Color.fromARGB(255, 255, 255, 255);
        colorsText = Color.fromARGB(255, 50, 49, 49);
      } else {
        check = true;
        colors = Color.fromARGB(255, 50, 49, 49);
        colorsText = Color.fromARGB(255, 255, 255, 255);
      }
    });
  }
}
