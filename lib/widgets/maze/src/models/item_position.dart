import 'package:equatable/equatable.dart';

class ItemPosition extends Equatable {

  ItemPosition({required this.col, required this.row});

  final int col;
  final int row;

  @override
  List<Object> get props => [col, row];
}