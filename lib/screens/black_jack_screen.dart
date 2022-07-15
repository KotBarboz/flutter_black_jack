import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart ';

class BlackJackScreen extends StatefulWidget {
  const BlackJackScreen({Key? key}) : super(key: key);

  @override
  State<BlackJackScreen> createState() => _BlackJackScreenState();
}

class _BlackJackScreenState extends State<BlackJackScreen> {
  bool isGameStarted = false;
  List<Image> myCards = [];
  List<Image> dealerCards = [];

  String? dealersFirstCard;
  String? dealersSecondCard;

  String? playersFirstCard;
  String? playersSecondCard;

  int playerScore = 0;
  int dealerScore = 0;

  final Map<String, int> deckOfCards = {
    "cards/2.1.png": 2,
    "cards/2.2.png": 2,
    "cards/2.3.png": 2,
    "cards/2.4.png": 2,
    "cards/3.1.png": 3,
    "cards/3.2.png": 3,
    "cards/3.3.png": 3,
    "cards/3.4.png": 3,
    "cards/4.1.png": 4,
    "cards/4.2.png": 4,
    "cards/4.3.png": 4,
    "cards/4.4.png": 4,
    "cards/5.1.png": 5,
    "cards/5.2.png": 5,
    "cards/5.3.png": 5,
    "cards/5.4.png": 5,
    "cards/6.1.png": 6,
    "cards/6.2.png": 6,
    "cards/6.3.png": 6,
    "cards/6.4.png": 6,
    "cards/7.1.png": 7,
    "cards/7.2.png": 7,
    "cards/7.3.png": 7,
    "cards/7.4.png": 7,
    "cards/8.1.png": 8,
    "cards/8.2.png": 8,
    "cards/8.3.png": 8,
    "cards/8.4.png": 8,
    "cards/9.1.png": 9,
    "cards/9.2.png": 9,
    "cards/9.3.png": 9,
    "cards/9.4.png": 9,
    "cards/10.1.png": 10,
    "cards/10.2.png": 10,
    "cards/10.3.png": 10,
    "cards/10.4.png": 10,
    "cards/J1.png": 10,
    "cards/J2.png": 10,
    "cards/J3.png": 10,
    "cards/J4.png": 10,
    "cards/Q1.png": 10,
    "cards/Q2.png": 10,
    "cards/Q3.png": 10,
    "cards/Q4.png": 10,
    "cards/K1.png": 10,
    "cards/K2.png": 10,
    "cards/K3.png": 10,
    "cards/K4.png": 10,
    "cards/A1.png": 11,
    "cards/A2.png": 11,
    "cards/A3.png": 11,
    "cards/A4.png": 11,
  };

  Map<String, int> playingCards = {};

  @override
  void initState() {
    super.initState();

    playingCards.addAll(deckOfCards);
  }

  void changeCards() {
    setState(() => isGameStarted = true);

    myCards = [];
    dealerCards = [];

    Random random = Random();

    String cardOneKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardOneKey);

    String cardTwoKey = playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardTwoKey);

    String cardThreeKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardThreeKey);

    String cardFourKey = playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardFourKey);

    dealersFirstCard = cardOneKey;
    dealersSecondCard = cardTwoKey;

    playersFirstCard = cardThreeKey;
    playersSecondCard = cardFourKey;

    dealerCards.add(Image.asset(dealersFirstCard!));
    dealerCards.add(Image.asset(dealersSecondCard!));

    dealerScore =
        deckOfCards[dealersSecondCard]! + deckOfCards[dealersFirstCard]!;

    myCards.add(Image.asset(playersFirstCard!));
    myCards.add(Image.asset(playersSecondCard!));

    playerScore =
        deckOfCards[playersFirstCard]! + deckOfCards[playersSecondCard]!;
  }

  void addCard() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isGameStarted == true
          ? SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("Dealer score $dealerScore"),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 200.0,
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemCount: dealerCards.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  dealerCards[index]),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Player  score $playerScore"),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 200.0,
                          child: GridView.builder(
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                              itemCount: myCards.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                              myCards[index]),
                        ),
                      ],
                    ),
                    IntrinsicWidth(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MaterialButton(
                            onPressed: addCard,
                            color: Colors.brown[200],
                            child: const Text("Another Card"),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          MaterialButton(
                            onPressed: () {},
                            color: Colors.brown[200],
                            child: const Text("Next Round"),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: MaterialButton(
                onPressed: () {
                  changeCards();
                },
                color: Colors.brown[200],
                child: const Text("Start Game"),
              ),
            ),
    );
  }
}
