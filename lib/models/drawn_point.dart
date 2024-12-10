part of 'models.dart';

class DrawnPoint{
  final double x;
  final double y;
  final int t;
  const DrawnPoint(this.x, this.y, this.t);

  Offset toOffset(){
    return Offset(x, y);
  }
}