import 'package:flutter/cupertino.dart';

import '../models/message.dart';

class ChatProvider extends ChangeNotifier {
  final List<Message> _messages = [Message(path: "https://dl.musichi.ir/1401/06/21/Ghors%202.mp3", role: "user")];

  List<Message> get messages => _messages;

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }
}