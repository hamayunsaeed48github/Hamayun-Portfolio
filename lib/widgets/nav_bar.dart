import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PortfolioNavBar extends StatefulWidget implements PreferredSizeWidget {
  final List<String> sectionLabels;
  final void Function(int) onTapSection;
  final bool isMobile;
  final VoidCallback onMenuTap;
  const PortfolioNavBar({super.key,required this.sectionLabels,required this.onTapSection,required this.isMobile,required this.onMenuTap});
  @override Size get preferredSize => const Size.fromHeight(72);
  @override State<PortfolioNavBar> createState() => _State();
}

class _State extends State<PortfolioNavBar> {
  int? _hover;
  @override
  Widget build(BuildContext context) => Container(
    decoration:BoxDecoration(
      color:AppColors.ink.withOpacity(.93),
      border:const Border(bottom:BorderSide(color:AppColors.border,width:.8)),
    ),
    padding:const EdgeInsets.symmetric(horizontal:32),
    child:Row(children:[
      // Logo
      Container(width:40,height:40,
        decoration:BoxDecoration(
          gradient:const LinearGradient(colors:[AppColors.sand,AppColors.teal],begin:Alignment.topLeft,end:Alignment.bottomRight),
          borderRadius:BorderRadius.circular(10)),
        alignment:Alignment.center,
        child:Text('HS',style:AppText.h4.copyWith(color:AppColors.ink,fontSize:15,fontWeight:FontWeight.w800))),
      const SizedBox(width:14),
      Text('Hamayun Saeed',style:AppText.bodyStrong.copyWith(fontSize:14)),
      const Spacer(),
      if(!widget.isMobile)...[
        for(int i=0;i<widget.sectionLabels.length;i++)
          MouseRegion(
            onEnter:(_)=>setState(()=>_hover=i),
            onExit:(_)=>setState(()=>_hover=null),
            child:GestureDetector(
              onTap:()=>widget.onTapSection(i),
              child:AnimatedContainer(duration:const Duration(milliseconds:180),
                margin:const EdgeInsets.symmetric(horizontal:10),
                padding:const EdgeInsets.symmetric(horizontal:4,vertical:6),
                decoration:BoxDecoration(
                  border:Border(bottom:BorderSide(
                    color:_hover==i ? AppColors.sand : Colors.transparent, width:1.5))),
                child:Text(widget.sectionLabels[i],
                  style:AppText.bodyStrong.copyWith(fontSize:13.5,
                    color:_hover==i ? AppColors.sand : AppColors.mistLight))),
            ),
          ),
        const SizedBox(width:12),
        _GlowButton(label:"Hire Me",onTap:()=>widget.onTapSection(widget.sectionLabels.length-1)),
      ] else
        IconButton(onPressed:widget.onMenuTap, icon:const Icon(Icons.menu_rounded,color:AppColors.paper,size:22)),
    ]),
  );
}

class _GlowButton extends StatefulWidget {
  final String label; final VoidCallback onTap;
  const _GlowButton({required this.label,required this.onTap});
  @override State<_GlowButton> createState()=>_GBState();
}
class _GBState extends State<_GlowButton> {
  bool _h=false;
  @override Widget build(BuildContext ctx)=>MouseRegion(
    onEnter:(_)=>setState(()=>_h=true),
    onExit:(_)=>setState(()=>_h=false),
    child:GestureDetector(onTap:widget.onTap,
      child:AnimatedContainer(duration:const Duration(milliseconds:200),
        padding:const EdgeInsets.symmetric(horizontal:20,vertical:10),
        decoration:BoxDecoration(
          gradient:LinearGradient(colors:_h?[AppColors.sandLight,AppColors.sand]:[AppColors.sand,AppColors.tealDark]),
          borderRadius:BorderRadius.circular(8),
          boxShadow:_h?[BoxShadow(color:AppColors.sand.withOpacity(.35),blurRadius:18,spreadRadius:1)]:[]),
        child:Text(widget.label,style:AppText.button.copyWith(color:AppColors.ink)))),
  );
}
