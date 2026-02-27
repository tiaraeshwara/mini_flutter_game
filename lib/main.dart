import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock Paper Scissors',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const RockPaperScissorsPage(),
    );
  }
}

class RockPaperScissorsPage extends StatefulWidget {
  const RockPaperScissorsPage({super.key});

  @override
  State<RockPaperScissorsPage> createState() => _RockPaperScissorsPageState();
}

class _RockPaperScissorsPageState extends State<RockPaperScissorsPage> {
  final List<String> _choices = ['Rock', 'Paper', 'Scissors'];
  final Random _random = Random();

  String _userChoice = '-';
  String _computerChoice = '-';
  String _resultMessage = 'Make your move!';

  int _playerScore = 0;
  int _computerScore = 0;

  void _playRound(String userChoice) {
    final String computerChoice = _choices[_random.nextInt(_choices.length)];
    String result;

    if (userChoice == computerChoice) {
      result = 'Draw';
    } else if ((userChoice == 'Rock' && computerChoice == 'Scissors') ||
        (userChoice == 'Paper' && computerChoice == 'Rock') ||
        (userChoice == 'Scissors' && computerChoice == 'Paper')) {
      result = 'User wins';
    } else {
      result = 'Computer wins';
    }

    setState(() {
      _userChoice = userChoice;
      _computerChoice = computerChoice;
      _resultMessage = result;

      if (result == 'User wins') {
        _playerScore++;
      } else if (result == 'Computer wins') {
        _computerScore++;
      }
    });
  }

  void _resetGame() {
    setState(() {
      _userChoice = '-';
      _computerChoice = '-';
      _resultMessage = 'Make your move!';
      _playerScore = 0;
      _computerScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Rock Paper Scissors'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'Your Choice:${_userChoice == '-' ? '' : ' $_userChoice'}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Computer Choice:${_computerChoice == '-' ? '' : ' $_computerChoice'}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 120),
                  Text(
                    _resultMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Player',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$_playerScore',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Computer',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$_computerScore',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _playRound('Rock'),
                    child: const Text('Rock'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _playRound('Paper'),
                    child: const Text('Paper'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _playRound('Scissors'),
                    child: const Text('Scissors'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextButton(onPressed: _resetGame, child: const Text('Reset Game')),
          ],
        ),
      ),
    );
  }
}
