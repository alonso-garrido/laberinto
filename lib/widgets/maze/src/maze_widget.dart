import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:universal_io/io.dart';
import 'maze_painter.dart';
import './models/item.dart';

class Maze extends StatefulWidget {
  Maze({
    required this.player,
    this.checkpoints = const [],
    this.columns = 10,
    this.finish,
    this.height,
    this.loadingWidget,
    this.onCheckpoint,
    this.onFinish,
    this.rows = 7,
    this.wallColor = Colors.black,
    this.wallThickness = 3.0,
    this.width,
  });

  final List<MazeItem> checkpoints;
  final int columns;
  final MazeItem? finish;
  final double? height;
  final Widget? loadingWidget;
  final Function(int)? onCheckpoint;
  final Function()? onFinish;
  final MazeItem player;
  final int rows;
  final Color? wallColor;
  final double? wallThickness;
  final double? width;

  @override
  _MazeState createState() => _MazeState();
}

class _MazeState extends State<Maze> {
  bool _loaded = false;
  late MazePainter _mazePainter;

  @override
  void initState() {
    super.initState();
    setUp();
  }

  void setUp() async {
    final playerImage = await _itemToImage(widget.player);
    final checkpoints = await Future.wait(
        widget.checkpoints.map((c) async => await _itemToImage(c)));
    final finishImage =
        widget.finish != null ? await _itemToImage(widget.finish!) : null;

    _mazePainter = MazePainter(
      checkpointsImages: checkpoints,
      columns: widget.columns,
      finishImage: finishImage,
      onCheckpoint: widget.onCheckpoint,
      onFinish: widget.onFinish,
      playerImage: playerImage,
      rows: widget.rows,
      wallColor: widget.wallColor ?? Colors.black,
      wallThickness: widget.wallThickness ?? 4.0,
    );
    setState(() => _loaded = true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Builder(builder: (context) {
      if (_loaded) {
        return GestureDetector(
            onVerticalDragUpdate: (info) =>
                _mazePainter.updatePosition(info.localPosition),
            child: CustomPaint(
                painter: _mazePainter,
                size: Size(widget.width ?? context.width,
                    widget.height ?? context.height)));
      } else {
        if (widget.loadingWidget != null) {
          return widget.loadingWidget!;
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    }));
  }

  Future<ui.Image> _itemToImage(MazeItem item) {
    switch (item.type) {
      case ImageType.file:
        return _fileToByte(item.path);
      case ImageType.network:
        return _networkToByte(item.path);
      default:
        return _assetToByte(item.path);
    }
  }

  ///Creates a Image from file
  Future<ui.Image> _fileToByte(String path) async {
    final completer = Completer<ui.Image>();
    final bytes = await File(path).readAsBytes();
    ui.decodeImageFromList(bytes, completer.complete);
    return completer.future;
  }

  ///Creates a Image from asset
  Future<ui.Image> _assetToByte(String asset) async {
    final completer = Completer<ui.Image>();
    final bytes = await rootBundle.load(asset);
    ui.decodeImageFromList(bytes.buffer.asUint8List(), completer.complete);
    return completer.future;
  }

  ///Creates a Image from network
  Future<ui.Image> _networkToByte(String url) async {
    final completer = Completer<ui.Image>();
    final response = await http.get(Uri.parse(url));
    ui.decodeImageFromList(
        response.bodyBytes.buffer.asUint8List(), completer.complete);
    return completer.future;
  }
}

extension ScreenSizeExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height - 200;
  double get width => MediaQuery.of(this).size.width;
}
