import 'package:flutter/material.dart';

class HeaderCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height * 0.5)
      ..quadraticBezierTo(
        size.width * 0.55,
        size.height,
        size.width,
        size.height * 0.6,
      )
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class HeaderBackgroud extends StatelessWidget {
  final double height;
  const HeaderBackgroud({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HeaderCurveClipper(),
      child: Container(
        width: double.infinity,
        height: height,
        // Containerの枠線
        decoration: const BoxDecoration(
            // 色の変化(グラーデーションの設定)
            // 左上から右下まで、色を0xFFFD9766から0xFFFF7362に変化させていく
            // 範囲 : stops[0, 1]で最初から最後まで
            gradient: LinearGradient(
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
          colors: [
            Color(0xFFFD9766),
            Color(0xFFFF7362),
          ],
          stops: [0, 1],
        )),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double height = 320;
    return Container(
      height: height,
      // Stackで要素を重ねる
      child: Stack(children: const [
        Align(
          alignment: Alignment.topCenter,
          child: HeaderBackgroud(height: height),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: HeaderCircles(height: height),
        ),
      ]),
    );
  }
}

class HeaderCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawCircle(
      Offset(size.width * 0.25, size.height * 0.4),
      12,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.2),
      12,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // 一度描画したら状態が変わらないので、false
    return false;
  }
}

class HeaderCircles extends StatelessWidget {
  final double height;
  const HeaderCircles({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: HeaderCirclePainter(),
      // 円を描く範囲を前もって定義
      // このBoxの中にheaderCirclePainterの中身が描かれる
      child: SizedBox(
        width: double.infinity,
        height: height,
      ),
    );
  }
}
