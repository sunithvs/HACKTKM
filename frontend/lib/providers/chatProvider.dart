import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../models/message.dart';
import 'package:http/http.dart' as http;

class ChatProvider extends ChangeNotifier {
   List<Message> _messages = [];

  List<Message> get messages => _messages;

  Future<void> sendMessage(File audio) async{
    final url = Uri.parse("http://farmer.radr.in/voice/chat/");
    final request = http.MultipartRequest('POST', url);
    final bytes = await audio.readAsBytes();
    print(bytes);
    try{
    request.files.add(http.MultipartFile.fromBytes("audio_file", bytes,
        filename: audio.path.split("/").last));
    var response = await request.send();

    final value = await response.stream.bytesToString();

    final responseData = jsonDecode(value);
    print(responseData);
    final List<Message> loadedMessages =[];
    loadedMessages.add(Message(path: responseData["audio_file"], role: "user"));
    loadedMessages.add(Message(path: responseData["response_audio_file"], role: "assistant"));
    _messages.addAll(loadedMessages);
    notifyListeners();
    }
        catch(e){
          print(e);
        }

  }
}