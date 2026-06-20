import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import 'constellation_painter.dart';

class HeroSection extends StatefulWidget {
  final bool isMobile;
  final VoidCallback onViewWork, onContact;
  const HeroSection({super.key,required this.isMobile,required this.onViewWork,required this.onContact});
  @override State<HeroSection> createState()=>_State();
}

class _State extends State<HeroSection> with TickerProviderStateMixin {
  int _roleIndex=0;
  Timer? _timer;
  late final AnimationController _entryCtrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  bool _imgError=false;

  @override void initState(){
    super.initState();
    _entryCtrl=AnimationController(vsync:this,duration:const Duration(milliseconds:900));
    _fade =CurvedAnimation(parent:_entryCtrl,curve:Curves.easeOut);
    _slide=Tween(begin:const Offset(0,.06),end:Offset.zero)
        .animate(CurvedAnimation(parent:_entryCtrl,curve:Curves.easeOutCubic));
    _entryCtrl.forward();
    _timer=Timer.periodic(const Duration(seconds:2),(_)=>setState(()=>_roleIndex=(_roleIndex+1)%PortfolioData.roles.length));
  }
  @override void dispose(){ _timer?.cancel(); _entryCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext ctx){
    final h=MediaQuery.of(ctx).size.height;
    final w=MediaQuery.of(ctx).size.width;
    return SizedBox(height:h,child:Stack(children:[
      const Positioned.fill(child:ConstellationBackground()),
      Positioned.fill(child:Container(decoration:BoxDecoration(gradient:LinearGradient(
        begin:Alignment.topCenter,end:Alignment.bottomCenter,
        colors:[AppColors.ink.withOpacity(.1),AppColors.ink.withOpacity(.6),AppColors.ink])))),
      Center(child:FadeTransition(opacity:_fade,child:SlideTransition(position:_slide,
        child:Padding(padding:EdgeInsets.symmetric(horizontal:widget.isMobile?24:80),
          child:widget.isMobile ? _mobileLayout() : _desktopLayout(w))))),
      Positioned(bottom:24,left:0,right:0,child:Column(children:[
        Text('SCROLL',style:AppText.mono.copyWith(fontSize:10)),
        const SizedBox(height:4),
        const _BouncingArrow(),
      ])),
    ]));
  }

  Widget _avatar(double size)=>Container(width:size,height:size,
    decoration:BoxDecoration(shape:BoxShape.circle,
      gradient:const LinearGradient(colors:[AppColors.surfaceLight,AppColors.surface],
        begin:Alignment.topLeft,end:Alignment.bottomRight),
      border:Border.all(color:AppColors.sand.withOpacity(.5),width:2.5),
      boxShadow:[BoxShadow(color:AppColors.sand.withOpacity(.15),blurRadius:40,spreadRadius:4)]),
    child:ClipOval(child:_imgError
      ? Icon(Icons.person_rounded,size:size*.5,color:AppColors.sand.withOpacity(.6))
      : Image.asset(PortfolioData.profileImage,fit:BoxFit.cover,
          errorBuilder:(_,__,___)=>Icon(Icons.person_rounded,size:size*.5,color:AppColors.sand.withOpacity(.6)))));

  Widget _textBlock()=>Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisSize:MainAxisSize.min,children:[
    Text('FULL STACK MOBILE DEVELOPER',style:AppText.mono),
    const SizedBox(height:16),
    Text(PortfolioData.name,
      style:AppText.display.copyWith(fontSize:widget.isMobile?42:68),maxLines:2,overflow:TextOverflow.ellipsis),
    const SizedBox(height:16),
    AnimatedSwitcher(duration:const Duration(milliseconds:400),
      transitionBuilder:(c,a)=>FadeTransition(opacity:a,
        child:SlideTransition(position:Tween(begin:const Offset(0,.3),end:Offset.zero).animate(a),child:c)),
      child:Row(key:ValueKey(_roleIndex),mainAxisSize:MainAxisSize.min,children:[
        Container(width:3,height:24,decoration:BoxDecoration(color:AppColors.sand,borderRadius:BorderRadius.circular(2))),
        const SizedBox(width:10),
        Text(PortfolioData.roles[_roleIndex],style:AppText.h3.copyWith(color:AppColors.teal,fontSize:widget.isMobile?16:20)),
      ])),
    const SizedBox(height:18),
    ConstrainedBox(constraints:const BoxConstraints(maxWidth:520),
      child:Text(PortfolioData.tagline,style:AppText.body)),
    const SizedBox(height:32),
    Wrap(spacing:14,runSpacing:12,children:[
      _HeroBtn(label:'View My Work',filled:true,onTap:widget.onViewWork),
      _HeroBtn(label:'Get In Touch',filled:false,onTap:widget.onContact),
    ]),
    const SizedBox(height:28),
    _StatRow(),
  ]);

  Widget _desktopLayout(double w)=>Row(
    crossAxisAlignment:CrossAxisAlignment.center,
    children:[Expanded(flex:6,child:_textBlock()),const SizedBox(width:60),Expanded(flex:4,child:Center(child:_avatar(320)))]);

  Widget _mobileLayout()=>Column(mainAxisSize:MainAxisSize.min,children:[
    _avatar(140),const SizedBox(height:28),_textBlock()]);
}

class _StatRow extends StatelessWidget {
  static const _stats=[('2+','Years Exp'),('10+','Projects Built'),('1','Upwork Client') ,('1','Fiver Client'),('50k+','App Downloads')];
  @override Widget build(BuildContext ctx)=>Wrap(spacing:28,runSpacing:16,
    children:_stats.map((s)=>Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisSize:MainAxisSize.min,children:[
      Text(s.$1,style:AppText.h3.copyWith(color:AppColors.sand,fontSize:26,fontWeight:FontWeight.w800)),
      Text(s.$2,style:AppText.small),
    ])).toList());
}

class _HeroBtn extends StatefulWidget {
  final String label; final bool filled; final VoidCallback onTap;
  const _HeroBtn({required this.label,required this.filled,required this.onTap});
  @override State<_HeroBtn> createState()=>_HBState();
}
class _HBState extends State<_HeroBtn>{
  bool _h=false;
  @override Widget build(BuildContext ctx)=>MouseRegion(
    onEnter:(_)=>setState(()=>_h=true),onExit:(_)=>setState(()=>_h=false),
    child:GestureDetector(onTap:widget.onTap,child:AnimatedContainer(
      duration:const Duration(milliseconds:180),
      padding:const EdgeInsets.symmetric(horizontal:26,vertical:14),
      decoration:BoxDecoration(
        color:widget.filled?(AppColors.sand):(_h?AppColors.surfaceLight:Colors.transparent),
        border:Border.all(color:widget.filled?Colors.transparent:AppColors.border),
        borderRadius:BorderRadius.circular(8),
        boxShadow:widget.filled&&_h?[BoxShadow(color:AppColors.sand.withOpacity(.3),blurRadius:20)]:null),
      child:Text(widget.label,style:AppText.button.copyWith(
        color:widget.filled?AppColors.ink:AppColors.paper)))));
}

class _BouncingArrow extends StatefulWidget {
  const _BouncingArrow();
  @override State<_BouncingArrow> createState()=>_BAState();
}
class _BAState extends State<_BouncingArrow> with SingleTickerProviderStateMixin{
  late final AnimationController _c;
  late final Animation<Offset> _a;
  @override void initState(){super.initState();
    _c=AnimationController(vsync:this,duration:const Duration(milliseconds:800))..repeat(reverse:true);
    _a=Tween(begin:Offset.zero,end:const Offset(0,.3)).animate(CurvedAnimation(parent:_c,curve:Curves.easeInOut));
  }
  @override void dispose(){_c.dispose();super.dispose();}
  @override Widget build(BuildContext ctx)=>SlideTransition(position:_a,
    child:const Icon(Icons.keyboard_arrow_down_rounded,color:AppColors.mist,size:20));
}
