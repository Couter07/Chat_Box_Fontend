class Message {
  String id;
  String content;

  Message({required this.id, required this.content});

  @override
  String toString() {
    return 'Message(id: $id, content: $content';
  }

  get getId => id;
  get getContent => content;
  set setContent(String content) {
    this.content = content;
  }

  set setId(String id) {
    this.id = id;
  }
}
