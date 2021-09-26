enum ImageType {
  asset,
  file,
  network
}

class MazeItem {
  MazeItem(this.path, this.type);
  ImageType type;
  String path;
}