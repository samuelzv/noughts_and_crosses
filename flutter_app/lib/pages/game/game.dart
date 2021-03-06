import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:common/common.dart';

import './widgets/board.dart';
import './widgets/play_controls.dart';
import './widgets/score.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Widget _getGame(BuildContext context, DataState state) {
    TextTheme theme = Theme.of(context).textTheme;
    GameBloc _gameBloc = BlocProvider.of<GameBloc>(context);
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ 
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  state.statusMessage,
                  style: theme.title 
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .7 ,
                    child: GameBoard(),
                  )
                )
              ),  
              PlayControls(
                onNewGame: () => _gameBloc.dispatch(NewGameBlocEvent()),
                onLogout: () => _gameBloc.dispatch(LogoutBlocEvent()) 
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Score(),
              ),
            ]
          )
        );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic-Tac-Toe'),
      ),
      body: BlocBuilder(
        bloc: BlocProvider.of<GameBloc>(context),
        builder: (BuildContext context, DataState state) {
          return _getGame(context, state);
        },
      ) 
    );
  }
}