import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class _Node { Offset position; Offset velocity; _Node(this.position,this.velocity); }

class ConstellationBackground extends StatefulWidget {
  final int nodeCount;
  const ConstellationBackground({super.key,this.nodeCount=40});
  @override State<ConstellationBackground> createState() => _State();
}
class _State extends State<ConstellationBackground> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  final List<_Node> _nodes = [];
  final Random _rand = Random(42);
  Size _last = Size.zero;

  @override void initState() {
    super.initState();
    _ctrl = AnimationController(vsync:this, duration:const Duration(days:1))
      ..addListener(_tick)..repeat();
  }
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  void _ensure(Size s) {
    if (_nodes.isNotEmpty && _last==s) return;
    _last=s; _nodes.clear();
    for(int i=0;i<widget.nodeCount;i++)
      _nodes.add(_Node(
        Offset(_rand.nextDouble()*s.width,_rand.nextDouble()*s.height),
        Offset((_rand.nextDouble()-.5)*.22,(_rand.nextDouble()-.5)*.22),
      ));
  }
  void _tick() {
    if(_last==Size.zero) return;
    for(final n in _nodes){
      var dx=n.velocity.dx, dy=n.velocity.dy;
      final nx=n.position+n.velocity;
      if(nx.dx<0||nx.dx>_last.width)  dx=-dx;
      if(nx.dy<0||nx.dy>_last.height) dy=-dy;
      n.velocity=Offset(dx,dy); n.position=n.position+n.velocity;
    }
    setState((){});
  }

  @override
  Widget build(BuildContext ctx) => LayoutBuilder(builder:(ctx,con){
    final s=Size(con.maxWidth,con.maxHeight); _ensure(s);
    return CustomPaint(size:s, painter:_Painter(_nodes));
  });
}

class _Painter extends CustomPainter {
  final List<_Node> nodes;
  _Painter(this.nodes);
  @override
  void paint(Canvas canvas, Size size) {
    final dot=Paint()..color=AppColors.sand.withOpacity(.5);
    final line=Paint()..strokeWidth=1;
    for(int i=0;i<nodes.length;i++)
      for(int j=i+1;j<nodes.length;j++){
        final d=(nodes[i].position-nodes[j].position).distance;
        if(d<150){ line.color=AppColors.teal.withOpacity((1-d/150)*.15); canvas.drawLine(nodes[i].position,nodes[j].position,line); }
      }
    for(final n in nodes) canvas.drawCircle(n.position,2.2,dot);
  }
  @override bool shouldRepaint(covariant _Painter o)=>true;
}
