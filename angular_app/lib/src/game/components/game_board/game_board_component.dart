import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_bloc/angular_bloc.dart';
import 'package:common/common.dart';

@Component(
  selector: 'tictac-game-board',
  styleUrls: [
    'game_board_component.css',
    'material_custom.css'
  ],
  templateUrl: 'game_board_component.html',
  exports: [Player],
  directives: [
    MaterialCheckboxComponent,
    MaterialFabComponent,
    MaterialButtonComponent,
    MaterialIconComponent,
    materialInputDirectives,
    NgFor,
    NgIf,
    NgClass,
  ],
  pipes: [BlocPipe]
)
class GameBoardComponent {
  @Input() DataState gameState;
  final _chooseCell = new StreamController<CellPosition>();
  @Output() 
  get chooseCell => _chooseCell.stream;

  void onChooseHuman(int row, int column) {
    if (gameState.cells[row][column].value == null) {
      _chooseCell.add(CellPosition(row, column));
    }
  }

  String getClassForWinningCell(Cell cell) {
    if (cell.belongsToWinningCombination) {
      return (gameState.turn == Player.computer ? 'computer--winner' : 'human--winner');
    }
    return '';
  }
}
