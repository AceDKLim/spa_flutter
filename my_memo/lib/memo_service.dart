import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';

// Memo 데이터의 형식을 정해줍니다. 추후 isPinned, updatedAt 등의 정보도 저장할 수 있습니다.
class Memo {
  Memo({
    required this.content,
    required this.pin,
    required this.time,
  });

  String content;
  bool pin;
  String time;

  Map toJson() {
    return {'content': content, 'pin': pin, 'time': time};
  }

  factory Memo.fromJson(json) {
    return Memo(content: json['content'], pin: json['pin'], time: json['time']);
  }
}

// Memo 데이터는 모두 여기서 관리
class MemoService extends ChangeNotifier {
  MemoService() {
    loadMemoList();
  }

  List<Memo> memoList = [];

  createMemo({required String content}) {
    Memo memo = Memo(
        content: content,
        pin: false,
        time: DateFormat('yyyy-MM-dd H:mm:ss').format(DateTime.now()));
    memoList.add(memo);
    notifyListeners();
    saveMemoList();
  }

  updateMemo({required int index, required String content}) {
    Memo memo = memoList[index];
    memo.content = content;
    memo.time = DateFormat('yyyy-MM-dd H:mm:ss').format(DateTime.now());
    notifyListeners();
    saveMemoList();
  }

  deleteMemo({required int index}) {
    memoList.removeAt(index);
    notifyListeners();
    saveMemoList();
  }

  clickPin({required int index}) {
    Memo memo = memoList[index];
    memo.pin = !memo.pin;
    memoList.removeAt(index);
    memo.pin == true
        ? memoList.insert(0, memo)
        : memoList.insert(memoList.length, memo);
    notifyListeners();
  }

  saveMemoList() {
    List memoJsonList = memoList.map((memo) => memo.toJson()).toList();
    // [{"content": "1"}, {"content": "2"}]

    String jsonString = jsonEncode(memoJsonList);
    // '[{"content": "1"}, {"content": "2"}]'

    prefs.setString('memoList', jsonString);
  }

  loadMemoList() {
    String? jsonString = prefs.getString('memoList');
    // '[{"content": "1"}, {"content": "2"}]'

    if (jsonString == null) return; // null 이면 로드하지 않음

    List memoJsonList = jsonDecode(jsonString);
    // [{"content": "1"}, {"content": "2"}]

    memoList = memoJsonList.map((json) => Memo.fromJson(json)).toList();
  }
}
