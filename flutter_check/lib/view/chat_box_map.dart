import 'package:flutter_check/model/message.dart';
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
  final List<Message> messages = [];
  Color colors = Color.fromARGB(255, 255, 255, 255);
  Color colorsText = Color.fromARGB(255, 0, 0, 0);
  Color colorsLevel1 = Color.fromARGB(255, 78, 166, 224);
  Color colorsLevel2 = Colors.blueGrey;
  Color colorsLevel3 = Color.fromARGB(255, 78, 166, 224);
  bool check = false;
  bool showOptions = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        messages.insert(
          0,
          Message(
            id: 'bot',
            content: '👋 Xin chào! Bạn muốn tìm kiếm thông tin ở đâu?',
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          color: colorsLevel1,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Avatar bên trái
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/images/Robot_icon.jpeg',
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                // Tiêu đề ở giữa (dùng Expanded để canh giữa)
                Expanded(
                  child: Center(
                    child: Text(
                      'EmoChat',
                      style: TextStyle(
                        color: colorsText,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoMono',
                      ),
                    ),
                  ),
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
            color: colorsLevel2,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (_, index) => _buildMessageTile(colors, index),
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ⬇ Nút chọn TikTok, Google, YouTube
                  if (showOptions)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 4.0,
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        children: [
                          _buildOptionButton('TikTok'),
                          _buildOptionButton('Google'),
                          _buildOptionButton('YouTube'),
                        ],
                      ),
                    ),

                  // ⬇ TextField + nút gửi
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            showOptions = !showOptions;
                          });
                        },
                        icon: const Icon(
                          Icons.more_vert,
                          color: Color.fromARGB(255, 78, 166, 224),
                          size: 26,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Nhập tin nhắn...',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF0F2F5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(fontSize: 16),
                          onSubmitted: (text) {
                            _sendMessage(text.trim(), 'user');
                          },
                        ),
                      ),
                      const SizedBox(width: 6),
                      CircleAvatar(
                        backgroundColor: const Color.fromARGB(
                          255,
                          78,
                          166,
                          224,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: () {
                            _sendMessage(_controller.text.trim(), 'user');
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageTile(Color colors, int index) {
    final isUser = messages[index].getId == 'user';
    final messageText = messages[index].getContent;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[400] : const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              messageText,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black87,
                fontSize: 16.0,
              ),
            ),
            if (!isUser &&
                messageText.toLowerCase().contains(
                  "bản đồ",
                )) // hoặc tùy điều kiện
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapPage()),
                    );
                  },
                  icon: const Icon(
                    Icons.map_outlined,
                    color: Colors.red,
                    size: 26,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // chatbot chat lai
  void _sendMessage(String text, String role) async {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add(Message(id: role, content: text));
        _controller.clear();
      });
      await Future.delayed(const Duration(milliseconds: 1500));
      setState(() {
        messages.add(Message(id: 'robot', content: 'Go to Map'));
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  Widget _buildOptionButton(String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade100,
        foregroundColor: Colors.blue.shade800,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () {
        _sendMessage("Tìm kiếm $label", 'user');
        setState(() {
          showOptions = false; // Ẩn nút sau khi chọn
        });
      },
      child: Text(label),
    );
  }
}
