import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import 'section_header.dart';
import 'fade_in_widget.dart';

class SkillsSection extends StatelessWidget {
  final bool isMobile;
  const SkillsSection({super.key,required this.isMobile});

  @override
  Widget build(BuildContext ctx)=>Container(color:AppColors.surface,
    padding:EdgeInsets.symmetric(horizontal:isMobile?24:80,vertical:isMobile?60:120),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      FadeInOnScroll(child:SectionHeader(eyebrow:'03 — SKILLS',title:'My Technical Toolkit',
        subtitle:'Everything I use to build complete, production-ready mobile products.',isMobile:isMobile)),
      const SizedBox(height:52),
      LayoutBuilder(builder:(ctx,con){
        final cols=isMobile?1:3;
        final w=(con.maxWidth-(cols-1)*20)/cols;
        return Wrap(spacing:20,runSpacing:20,
          children:List.generate(PortfolioData.skillGroups.length,(i)=>FadeInOnScroll(
            delay:Duration(milliseconds:70*i),
            child:SizedBox(width:w,child:_SkillCard(group:PortfolioData.skillGroups[i])))));
      }),
      const SizedBox(height:60),
      FadeInOnScroll(delay:const Duration(milliseconds:300),child:_SoftSkillsBlock(isMobile:isMobile)),
    ]));
}

class _SkillCard extends StatelessWidget {
  final SkillGroup group;
  const _SkillCard({required this.group});
  @override Widget build(BuildContext ctx)=>Container(
    padding:const EdgeInsets.all(24),
    decoration:BoxDecoration(color:AppColors.surfaceCard,borderRadius:BorderRadius.circular(14),border:Border.all(color:AppColors.border)),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Row(children:[Text(group.emoji,style:const TextStyle(fontSize:22)),const SizedBox(width:10),
        Expanded(child:Text(group.title,style:AppText.h4))]),
      const SizedBox(height:16),
      Wrap(spacing:8,runSpacing:8,children:group.items.map((item)=>Container(
        padding:const EdgeInsets.symmetric(horizontal:12,vertical:6),
        decoration:BoxDecoration(color:AppColors.surfaceLight,borderRadius:BorderRadius.circular(20)),
        child:Text(item,style:AppText.small.copyWith(color:AppColors.paper)))).toList()),
    ]));
}

class _SoftSkillsBlock extends StatelessWidget {
  final bool isMobile;
  const _SoftSkillsBlock({required this.isMobile});
  @override Widget build(BuildContext ctx)=>Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Row(children:[
      Container(width:28,height:2,decoration:BoxDecoration(borderRadius:BorderRadius.circular(1),
        gradient:const LinearGradient(colors:[AppColors.sand,AppColors.teal]))),
      const SizedBox(width:12),
      Text('SOFT SKILLS',style:AppText.mono),
    ]),
    const SizedBox(height:20),
    LayoutBuilder(builder:(ctx,con){
      final cols=isMobile?1:3;
      final w=(con.maxWidth-(cols-1)*16)/cols;
      return Wrap(spacing:16,runSpacing:16,
        children:PortfolioData.softSkills.map((s)=>SizedBox(width:w,child:_SoftSkillCard(skill:s))).toList());
    }),
  ]);
}

class _SoftSkillCard extends StatelessWidget {
  final SoftSkill skill;
  const _SoftSkillCard({required this.skill});
  @override Widget build(BuildContext ctx)=>Container(
    padding:const EdgeInsets.all(20),
    decoration:BoxDecoration(
      borderRadius:BorderRadius.circular(12),border:Border.all(color:AppColors.border),
      gradient:const LinearGradient(colors:[AppColors.surfaceCard,AppColors.surface],begin:Alignment.topLeft,end:Alignment.bottomRight)),
    child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Text(skill.icon,style:const TextStyle(fontSize:26)),
      const SizedBox(width:12),
      Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text(skill.title,style:AppText.bodyStrong.copyWith(fontSize:14)),
        const SizedBox(height:4),
        Text(skill.description,style:AppText.small),
      ])),
    ]));
}
