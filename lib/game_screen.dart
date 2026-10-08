import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/game_controller.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GameController gameController = Get.put(GameController());
    final List<String> alphabet = List.generate(
      26,
      (index) => String.fromCharCode(index + 65),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Word Guess Game')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(
                () => Text(
                  "Round ${gameController.currentRound.value + 1} / 3",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),

              const Text(
                "Question",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),

              Obx(
                () => Text(
                  gameController.question,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),

              Obx(() => _buildWord(gameController)),

              Spacer(),

              Obx(() => _buildKeyPad(gameController, alphabet)),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWord(GameController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(controller.answer.length, (index) {
        final ch = controller.answer[index];

        final reveal = controller.guessed.contains(ch);

        return Container(
          width: 45,
          height: 40,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              reveal ? ch : '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildKeyPad(GameController controller, List<String> alphabet) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: alphabet.map((ch) {
        final guessed = controller.guessed.contains(ch);
        return SizedBox(
          width: 44,
          height: 44,
          child: ElevatedButton(
            onPressed: () {
              guessed ? null : controller.onLettertap(ch);
            },
            child: Text(
              ch,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: guessed ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
