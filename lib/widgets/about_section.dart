import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import 'section_header.dart';
import 'fade_in_widget.dart';

class AboutSection extends StatelessWidget {
  final bool isMobile;
  const AboutSection({super.key,required this.isMobile});

  @override
  Widget build(BuildContext ctx){
    final portrait=FadeInOnScroll(slideOffset:60,child:Container(
      decoration:BoxDecoration(borderRadius:BorderRadius.circular(20),
        gradient:const LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,
          colors:[AppColors.surfaceCard,AppColors.surface]),
        border:Border.all(color:AppColors.border)),
      child:ClipRRect(borderRadius:BorderRadius.circular(20),
        child:AspectRatio(aspectRatio:4/5,child:Stack(children:[
          Image.asset(PortfolioData.profileImage,fit:BoxFit.cover,width:double.infinity,height:double.infinity,
            errorBuilder:(_,__,___)=>Container(color:AppColors.surfaceLight,
              child:Icon(Icons.person_rounded,size:120,color:AppColors.sand.withOpacity(.4)))),
          Positioned(bottom:0,left:0,right:0,child:Container(
            padding:const EdgeInsets.all(20),
            decoration:BoxDecoration(gradient:LinearGradient(
              begin:Alignment.bottomCenter,end:Alignment.topCenter,
              colors:[AppColors.ink,Colors.transparent])),
            child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              Text(PortfolioData.name,style:AppText.h4),
              Text(PortfolioData.headline,style:AppText.mono.copyWith(fontSize:10)),
            ]))),
        ])))));

    final textBlock=Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      FadeInOnScroll(delay:const Duration(milliseconds:100),
        child:SectionHeader(eyebrow:'01 — ABOUT ME',title:'The developer behind the code',isMobile:isMobile)),
      const SizedBox(height:24),
      FadeInOnScroll(delay:const Duration(milliseconds:200),
        child:Text(PortfolioData.aboutText,style:AppText.body)),
      const SizedBox(height:28),
      FadeInOnScroll(delay:const Duration(milliseconds:300),child:_InfoChips()),
      const SizedBox(height:28),
      FadeInOnScroll(delay:const Duration(milliseconds:350),child:_StatRow()),
    ]);

    return Container(color:AppColors.surface,
      padding:EdgeInsets.symmetric(horizontal:isMobile?24:80,vertical:isMobile?60:120),
      child:isMobile
        ? Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            SizedBox(height:280,child:portrait),const SizedBox(height:36),textBlock])
        : Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
            SizedBox(width:340,child:portrait),const SizedBox(width:64),Expanded(child:textBlock)]));
  }
}

class _InfoChips extends StatelessWidget {
  static const _info=[('Fortabbas','Punjab, Pakistan'),('📧','hamayunsaeed48@gmail.com'),('📞','+92 308 4720312'),('🎓','BS Computer Science, 2025')];
  @override Widget build(BuildContext ctx)=>Wrap(spacing:10,runSpacing:10,
    children:_info.map((i)=>Container(
      padding:const EdgeInsets.symmetric(horizontal:14,vertical:8),
      decoration:BoxDecoration(color:AppColors.surfaceCard,borderRadius:BorderRadius.circular(20),border:Border.all(color:AppColors.border)),
      child:Row(mainAxisSize:MainAxisSize.min,children:[
        Text(i.$1,style:const TextStyle(fontSize:13)),const SizedBox(width:6),
        Text(i.$2,style:AppText.small),
      ]))).toList());
}

class _StatRow extends StatelessWidget {
  static const _s=[('2+','Years\nExperience'),('6+','Projects\nDelivered'),('5+','Technologies\nMastered')];
  @override Widget build(BuildContext ctx)=>Row(children:_s.map((s)=>Expanded(child:Container(
    margin:const EdgeInsets.only(right:12),
    padding:const EdgeInsets.symmetric(vertical:20,horizontal:16),
    decoration:BoxDecoration(color:AppColors.surfaceCard,borderRadius:BorderRadius.circular(12),border:Border.all(color:AppColors.border)),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Text(s.$1,style:AppText.h3.copyWith(color:AppColors.sand,fontSize:28)),
      const SizedBox(height:4),
      Text(s.$2,style:AppText.small),
    ])))).toList());
}
