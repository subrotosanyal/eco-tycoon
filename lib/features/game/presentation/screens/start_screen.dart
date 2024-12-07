import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../game/domain/providers/game_provider.dart';
import 'game_screen.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade100,
              Colors.green.shade50,
            ],
          ),
        ),
        child: Center(
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.all(16),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              padding: const EdgeInsets.all(32),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Eco Tycoon',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Save the Planet!',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const _GameRules(),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 16,
                        ),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        ref.read(gameNotifierProvider.notifier).startGame();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const GameScreen(),
                          ),
                        );
                      },
                      child: const Text('Start Game'),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GameRules extends StatelessWidget {
  const _GameRules();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How to Play:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildRuleItem(
          icon: const Icon(Icons.park, color: Colors.green),
          text: 'Plant trees to generate resources',
        ),
        _buildRuleItem(
          icon: const Icon(Icons.cleaning_services, color: Colors.blue),
          text: 'Clean pollution to save the planet',
        ),
        _buildRuleItem(
          icon: const Icon(Icons.trending_up, color: Colors.orange),
          text: 'Manage your resources wisely',
        ),
        _buildRuleItem(
          icon: const Icon(Icons.timer, color: Colors.red),
          text: 'Act quickly - faster completion means higher scores!',
        ),
        const SizedBox(height: 16),
        const Text(
          'Victory Conditions:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildRuleItem(
          icon: const Icon(Icons.forest, color: Colors.green),
          text: 'Plant at least 20 trees',
        ),
        _buildRuleItem(
          icon: const Icon(Icons.eco, color: Colors.teal),
          text: 'Keep pollution below 30%',
        ),
        _buildRuleItem(
          icon: const Icon(Icons.stars, color: Colors.amber),
          text: 'Bonus points for faster completion',
        ),
        const SizedBox(height: 16),
        const Text(
          'Resources:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildRuleItem(
          icon: const Icon(Icons.water_drop, color: Colors.blue),
          text: 'Water: Used for planting trees',
        ),
        _buildRuleItem(
          icon: const Icon(Icons.bolt, color: Colors.yellow),
          text: 'Energy: Powers pollution cleanup',
        ),
        _buildRuleItem(
          icon: const Icon(Icons.landscape, color: Colors.brown),
          text: 'Soil: Required for tree growth',
        ),
      ],
    );
  }

  Widget _buildRuleItem({required Widget icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: icon,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
