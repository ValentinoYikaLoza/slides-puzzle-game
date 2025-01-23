import 'package:flutter/material.dart';
import 'package:gambling_game/app/features/shared/widgets/custom_appbar.dart';

class ChallengeScreen extends StatelessWidget {
  // Example list of challenges
  final List<ChallengeItem> challenges = [
    ChallengeItem(
      title: 'Complete 5 Puzzles',
      description: 'Solve 5 puzzles of any type.',
      reward: '100 Coins',
      progress: 0,
      total: 5,
    ),
    ChallengeItem(
      title: 'Solve an Image Puzzle',
      description: 'Complete one image puzzle.',
      reward: '50 Coins',
      progress: 0,
      total: 1,
    ),
    ChallengeItem(
      title: 'Finish in Under 5 Minutes',
      description: 'Complete a puzzle in less than 5 minutes.',
      reward: '200 Coins',
      progress: 0,
      total: 1,
    ),
    ChallengeItem(
      title: 'Win 3 Games',
      description: 'Win any 3 games.',
      reward: '150 Coins',
      progress: 0,
      total: 3,
    ),
    ChallengeItem(
      title: 'Play for 30 Minutes',
      description: 'Spend a total of 30 minutes playing.',
      reward: '75 Coins',
      progress: 0,
      total: 30,
    ),
    ChallengeItem(
      title: 'Invite a Friend',
      description: 'Invite a friend to join the game.',
      reward: '100 Coins',
      progress: 0,
      total: 1,
    ),
    ChallengeItem(
      title: 'Reach Level 5',
      description: 'Reach level 5 in the game.',
      reward: '200 Coins',
      progress: 0,
      total: 5,
    ),
    ChallengeItem(
      title: 'Collect 500 Coins',
      description: 'Collect a total of 500 coins.',
      reward: '50 Coins',
      progress: 0,
      total: 500,
    ),
    ChallengeItem(
      title: 'Complete 10 Challenges',
      description: 'Complete any 10 challenges.',
      reward: '300 Coins',
      progress: 0,
      total: 10,
    ),
    ChallengeItem(
      title: 'Log in for 7 Days',
      description: 'Log in to the game for 7 consecutive days.',
      reward: '350 Coins',
      progress: 0,
      total: 7,
    ),
    ChallengeItem(
      title: 'Score 1000 Points',
      description: 'Score a total of 1000 points.',
      reward: '400 Coins',
      progress: 0,
      total: 1000,
    ),
    ChallengeItem(
      title: 'Share on Social Media',
      description: 'Share your game progress on social media.',
      reward: '50 Coins',
      progress: 0,
      total: 1,
    ),
    ChallengeItem(
      title: 'Watch 5 Ads',
      description: 'Watch 5 ads to earn rewards.',
      reward: '100 Coins',
      progress: 0,
      total: 5,
    ),
    ChallengeItem(
      title: 'Complete a Daily Challenge',
      description: 'Complete any daily challenge.',
      reward: '75 Coins',
      progress: 0,
      total: 1,
    ),
    ChallengeItem(
      title: 'Earn 1000 XP',
      description: 'Earn a total of 1000 experience points.',
      reward: '200 Coins',
      progress: 0,
      total: 1000,
    ),
    ChallengeItem(
      title: 'Join a Guild',
      description: 'Join a guild in the game.',
      reward: '150 Coins',
      progress: 0,
      total: 1,
    ),
    ChallengeItem(
      title: 'Send 10 Gifts',
      description: 'Send 10 gifts to friends.',
      reward: '100 Coins',
      progress: 0,
      total: 10,
    ),
    ChallengeItem(
      title: 'Complete a Hard Puzzle',
      description: 'Complete a puzzle on hard difficulty.',
      reward: '250 Coins',
      progress: 0,
      total: 1,
    ),
    ChallengeItem(
      title: 'Reach Top 10 in Leaderboard',
      description: 'Reach the top 10 in the leaderboard.',
      reward: '500 Coins',
      progress: 0,
      total: 1,
    ),
    ChallengeItem(
      title: 'Play 50 Games',
      description: 'Play a total of 50 games.',
      reward: '300 Coins',
      progress: 0,
      total: 50,
    ),
  ];

  ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade50,
              Colors.green.shade50
            ], // Light pastel gradient
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: challenges.length,
          itemBuilder: (context, index) {
            final challenge = challenges[index];
            return ChallengeItemCard(
              challenge: challenge,
              onPressed: () {
                // Handle challenge start or view details
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Starting challenge: ${challenge.title}'),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ChallengeItem {
  final String title;
  final String description;
  final String reward;
  final int progress;
  final int total;

  ChallengeItem({
    required this.title,
    required this.description,
    required this.reward,
    required this.progress,
    required this.total,
  });
}

class ChallengeItemCard extends StatelessWidget {
  final ChallengeItem challenge;
  final VoidCallback onPressed;

  const ChallengeItemCard({
    super.key,
    required this.challenge,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              challenge.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              challenge.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade800,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: challenge.progress / challenge.total,
              backgroundColor: Colors.blue.shade100,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade800),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${challenge.progress}/${challenge.total}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue.shade800,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  'Reward: ${challenge.reward}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green.shade800,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Start Challenge',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
