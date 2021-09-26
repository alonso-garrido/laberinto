import 'package:flutter/material.dart';
import 'package:laberinto/widgets/maze/src/maze_painter.dart';
import './widgets/maze/maze.dart';

class MazePage extends StatefulWidget {
  MazePage({Key? key}) : super(key: key);

  @override
  _MazePageState createState() => _MazePageState();
}

class _MazePageState extends State<MazePage> {
  List<Widget> scoreKeeper = [];

  List col = [2, 2, 3, 2, 3, 3, 3, 3, 4, 3];
  List fil = [2, 2, 2, 3, 2, 3, 3, 3, 2, 4];
  int c = 0;
  int f = 0;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //TODO este container muestra el SUCCESS o FAIL de cada nivel
            Container(
              color: Colors.white,
              height: 80.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(children: scoreKeeper),
                  ],
                ),
              ),
            ),

            //TODO aqui se crea el laberinto, falta hacer rebuild al superarlo, esto en en onFinish()
            Maze(
              player: MazeItem(
                'https://cdn-icons-png.flaticon.com/512/5094/5094295.png',
                ImageType.network,
              ),
              columns: col[c],
              rows: fil[f],
              wallThickness: 4.0,
              wallColor: Theme.of(context).primaryColor,
              finish: MazeItem(
                  'https://cdn-icons-png.flaticon.com/512/760/760991.png',
                  ImageType.network),
              onFinish: () {
                print('BIEN');
                setState(() {
                  c++;
                  f++;
                  score++;
                  print('c: $c');
                  print('f: $f');
                });
              },
            ),
            ElevatedButton(
                onPressed: () {
                  c++;
                  f++;
                },
                child: null)
            /*    ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () {
                  setState(() {
                    c++;
                    f++;
                    scoreKeeper.add(Icon(
                      Icons.sentiment_satisfied_alt,
                      color: Colors.blueAccent,
                      size: 40,
                    ));
                    score++;
                  });
                },
                child: Text(
                  'Siguiente',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                )),*/
          ],
        ),
      ),
    );
  }
}
