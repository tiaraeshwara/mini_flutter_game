import 'package:flutter/material.dart';
import 'dart:ui';
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B5BFF),
          brightness: Brightness.dark,
        ),
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
  final Set<String> _hoveredMoves = <String>{};

  String _userChoice = '-';
  String _computerChoice = '-';
  String _resultMessage = 'Make your move!';
  bool _isResetHovered = false;

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

  Widget _glassCard({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
  }) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color(0xFF7EE7FF).withValues(alpha: 0.30),
              width: 1.2,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1E1C3A).withValues(alpha: 0.72),
                const Color(0xFF2A2250).withValues(alpha: 0.52),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF46DFFF).withValues(alpha: 0.18),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: const Color(0xFFB78BFF).withValues(alpha: 0.10),
                blurRadius: 32,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _moveButton(String label) {
    final bool isHovered = _hoveredMoves.contains(label);

    return Expanded(
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _hoveredMoves.add(label);
          });
        },
        onExit: (_) {
          setState(() {
            _hoveredMoves.remove(label);
          });
        },
        child: AnimatedScale(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          scale: isHovered ? 1.04 : 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(
                    0xFF63E8FF,
                  ).withValues(alpha: isHovered ? 0.28 : 0.10),
                  blurRadius: isHovered ? 22 : 10,
                  spreadRadius: isHovered ? 1.2 : 0,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () => _playRound(label),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: isHovered
                    ? const Color(0xFF35307A).withValues(alpha: 0.94)
                    : const Color(0xFF2C2960).withValues(alpha: 0.88),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(
                    color: const Color(
                      0xFF79E7FF,
                    ).withValues(alpha: isHovered ? 0.60 : 0.32),
                  ),
                ),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  shadows: isHovered
                      ? [
                          Shadow(
                            color: const Color(
                              0xFF77E9FF,
                            ).withValues(alpha: 0.55),
                            blurRadius: 14,
                          ),
                        ]
                      : null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Rock Paper Scissors'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0E1028),
              const Color(0xFF17183A),
              const Color(0xFF1E1A48),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _glassCard(
                  child: Column(
                    children: [
                      Text(
                        'Your Choice:${_userChoice == '-' ? '' : ' $_userChoice'}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Computer Choice:${_computerChoice == '-' ? '' : ' $_computerChoice'}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        _resultMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: const Color(
                                0xFF5DE4FF,
                              ).withValues(alpha: 0.35),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: _glassCard(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          children: [
                            const Text(
                              'Player',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$_playerScore',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _glassCard(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          children: [
                            const Text(
                              'Computer',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$_computerScore',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                _glassCard(
                  child: Row(
                    children: [
                      _moveButton('Rock'),
                      const SizedBox(width: 10),
                      _moveButton('Paper'),
                      const SizedBox(width: 10),
                      _moveButton('Scissors'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _isResetHovered = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _isResetHovered = false;
                    });
                  },
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    scale: _isResetHovered ? 1.05 : 1,
                    child: TextButton(
                      onPressed: _resetGame,
                      style: TextButton.styleFrom(
                        foregroundColor: _isResetHovered
                            ? const Color(0xFFC9F6FF)
                            : const Color(0xFF7FBBED),
                        textStyle: TextStyle(
                          fontSize: _isResetHovered ? 16 : 15,
                          fontWeight: FontWeight.w700,
                          shadows: _isResetHovered
                              ? [
                                  Shadow(
                                    color: const Color(
                                      0xFF5DE4FF,
                                    ).withValues(alpha: 0.40),
                                    blurRadius: 16,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                      child: const Text('Reset Game'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
