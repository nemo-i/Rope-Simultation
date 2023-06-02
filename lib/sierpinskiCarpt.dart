import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SierpinskiCarpet extends CustomPainter {
  Size dimens;

  int RECURSIONS = 5;

  SierpinskiCarpet(this.dimens);

  double shortestSide() {
    return dimens.width < dimens.height ? dimens.width : dimens.height;
  }

  @override
  void paint(Canvas c, Size size) {
    double square = shortestSide();
    Rect bounds = Rect.fromLTWH(0, 0, square, square);

    // Draw a white square matching the bounds
    c.drawRect(bounds, Paint()..color = Colors.white);
    punchCantorGasket(c, bounds.left, bounds.top, bounds.width, RECURSIONS);
  }

  void punchCantorGasket(
      Canvas c, double x, double y, double size, int recursions) {
    // Base case, if recursions = 0, return
    if (recursions == 0) {
      return;
    }

    double newSize = size / 3.0;
    double newSize2 = newSize * 2;
    c.drawRect(Rect.fromLTWH(x + newSize, y + newSize, newSize, newSize),
        Paint()..color = Colors.black);

    recursions--;

    /* Call punchCantorGasket on all 8 other squares */
    punchCantorGasket(c, x, y, newSize, recursions); /* 0,0 */
    punchCantorGasket(c, x, y + newSize, newSize, recursions); /* 0,1 */
    punchCantorGasket(c, x, y + newSize2, newSize, recursions); /* 0,2 */

    punchCantorGasket(c, x + newSize, y, newSize, recursions); /* 1,0 */
    punchCantorGasket(
        c, x + newSize, y + newSize2, newSize, recursions); /* 1, 2 */

    punchCantorGasket(c, x + newSize2, y, newSize, recursions); /* 2,0 */
    punchCantorGasket(
        c, x + newSize2, y + newSize, newSize, recursions); /* 2,1 */
    punchCantorGasket(
        c, x + newSize2, y + newSize2, newSize, recursions); /* 2,2 */
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
