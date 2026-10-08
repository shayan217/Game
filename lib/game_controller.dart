import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  final List<Map<String, String>> rounds = [
    {
      "question": "Which is fruit is commonly red and green?",
      "answer": "APPLE",
    },
    {"question": "Which long yellow fruit monkeys love?", "answer": "BANANA"},
    {
      "question": "Which fruits is known as the king of fruits?",
      "answer": "MANGO",
    },
  ];

  var currentRound = 0.obs;
  var guessed = <String>{}.obs;

  String get question => rounds[currentRound.value]["question"]!;
  String get answer => rounds[currentRound.value]["answer"]!;

  void onLettertap(String letter) {
    if (guessed.contains(letter)) return;

    guessed.add(letter);
    _checkWinCondition();
  }

  void _checkWinCondition() {
    bool hasWon = true;
    for (int i = 0; i < answer.length; i++) {
      if (!guessed.contains(answer[i])) {
        hasWon = false;
        break;
      }
    }
    if (hasWon) {
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.defaultDialog(
          title: "You Won!",
          middleText: "Congratulations! You guessed the word correctly.",
          barrierDismissible: false,
          confirm: ElevatedButton(
            onPressed: () {
              Get.back();
              _nextRound();
            },
            child: Text("OK"),
          ),
        );
      });
    }
  }

  void _nextRound() {
    if (currentRound.value < rounds.length - 1) {
      currentRound.value++;
    } else {
      currentRound.value = 0;
      Get.snackbar(
        "Game Over",
        "Game Over! You've completed all rounds.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
    guessed.clear();
  }

  Color keyColor(String letter) {
    if (!guessed.contains(letter)) return Colors.grey;
    return answer.contains(letter) ? Colors.green : Colors.red;
  }
}
