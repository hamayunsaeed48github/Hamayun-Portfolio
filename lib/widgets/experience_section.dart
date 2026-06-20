import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import 'section_header.dart';
import 'fade_in_widget.dart';

class ExperienceSection extends StatelessWidget {
  final bool isMobile;
  const ExperienceSection({super.key,required this.isMobile});

  @override
  Widget build(BuildContext ctx)=>Container(color:AppColors.surface,
    padding:EdgeInsets.symmetric(horizontal:isMobile?24:80,vertical:isMobile?60:120),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      FadeInOnScroll(child:SectionHeader(eyebrow:'05 — EXPERIENCE & EDUCATION',
        title:'My Journey',subtitle:'From classroom to production code.',isMobile:isMobile)),
      const SizedBox(height:52),
      isMobile
        ? Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            _buildExp(isMobile),const SizedBox(height:48),_buildEdu(isMobile)])
        : Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Expanded(child:_buildExp(isMobile)),const SizedBox(width:48),
            SizedBox(width:320,child:_buildEdu(isMobile))]),
    ]));

  Widget _buildExp(bool m)=>Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Text('Experience',style:AppText.h4.copyWith(color:AppColors.sand)),
    const SizedBox(height:24),
    ...List.generate(PortfolioData.experiences.length,(i)=>FadeInOnScroll(
      delay:Duration(milliseconds:80*i),
      child:_ExpItem(exp:PortfolioData.experiences[i],isLast:i==PortfolioData.experiences.length-1))),
  ]);

  Widget _buildEdu(bool m)=>Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Text('Education',style:AppText.h4.copyWith(color:AppColors.teal)),
    const SizedBox(height:24),
    ...List.generate(PortfolioData.education.length,(i)=>FadeInOnScroll(
      delay:Duration(milliseconds:100+80*i),
      child:Container(margin:const EdgeInsets.only(bottom:14),padding:const EdgeInsets.all(18),
        decoration:BoxDecoration(color:AppColors.surfaceCard,borderRadius:BorderRadius.circular(12),border:Border.all(color:AppColors.border)),
        child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text(PortfolioData.education[i].$1,style:AppText.bodyStrong.copyWith(fontSize:14)),
          const SizedBox(height:4),
          Text(PortfolioData.education[i].$2,style:AppText.small.copyWith(color:AppColors.teal)),
          const SizedBox(height:2),
          Text(PortfolioData.education[i].$3,style:AppText.mono.copyWith(fontSize:10)),
        ])))),
    const SizedBox(height:24),
    Text('Certifications',style:AppText.h4.copyWith(color:AppColors.sand)),
    const SizedBox(height:14),
    FadeInOnScroll(child:Container(padding:const EdgeInsets.all(18),
      decoration:BoxDecoration(color:AppColors.surfaceCard,borderRadius:BorderRadius.circular(12),
        border:Border.all(color:AppColors.border),
        gradient:LinearGradient(colors:[AppColors.sand.withOpacity(.08),Colors.transparent],begin:Alignment.topLeft,end:Alignment.bottomRight)),
      child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Container(padding:const EdgeInsets.all(8),decoration:BoxDecoration(color:AppColors.sand.withOpacity(.15),borderRadius:BorderRadius.circular(8)),
          child:const Icon(Icons.verified_rounded,color:AppColors.sand,size:22)),
        const SizedBox(width:12),
        Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text('Android Development',style:AppText.bodyStrong.copyWith(fontSize:14)),
          Text('Coursera · 2023',style:AppText.small.copyWith(color:AppColors.teal)),
          const SizedBox(height:4),
          Text('Kotlin, Jetpack Compose, Firebase, SQLite, UI/UX Design',style:AppText.small),
        ])),
      ]))),
  ]);
}

class _ExpItem extends StatelessWidget {
  final Experience exp; final bool isLast;
  const _ExpItem({required this.exp,required this.isLast});
  @override Widget build(BuildContext ctx)=>IntrinsicHeight(child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Column(children:[
      Container(width:14,height:14,decoration:BoxDecoration(shape:BoxShape.circle,
        color:AppColors.ink,border:Border.all(color:AppColors.sand,width:2))),
      if(!isLast) Expanded(child:Container(width:1.5,
        decoration:BoxDecoration(gradient:LinearGradient(colors:[AppColors.sand.withOpacity(.4),Colors.transparent],
          begin:Alignment.topCenter,end:Alignment.bottomCenter)))),
    ]),
    const SizedBox(width:22),
    Expanded(child:Padding(padding:const EdgeInsets.only(bottom:36),
      child:Container(padding:const EdgeInsets.all(20),
        decoration:BoxDecoration(color:AppColors.surfaceCard,borderRadius:BorderRadius.circular(14),border:Border.all(color:AppColors.border)),
        child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              Text(exp.role,style:AppText.h4),
              const SizedBox(height:3),
              Text(exp.org,style:AppText.bodyStrong.copyWith(color:AppColors.teal,fontSize:13)),
            ])),
            Column(crossAxisAlignment:CrossAxisAlignment.end,children:[
              Container(padding:const EdgeInsets.symmetric(horizontal:9,vertical:4),
                decoration:BoxDecoration(color:AppColors.surfaceLight,borderRadius:BorderRadius.circular(12)),
                child:Text(exp.duration,style:AppText.mono.copyWith(fontSize:9))),
              const SizedBox(height:4),
              Text(exp.location,style:AppText.small.copyWith(fontSize:11)),
            ]),
          ]),
          const SizedBox(height:14),
          ...exp.points.map((p)=>Padding(padding:const EdgeInsets.only(bottom:7),
            child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
              Padding(padding:const EdgeInsets.only(top:7,right:9),
                child:Container(width:5,height:5,decoration:const BoxDecoration(color:AppColors.sand,shape:BoxShape.circle))),
              Expanded(child:Text(p,style:AppText.body.copyWith(fontSize:13.5))),
            ]))),
        ])))),
  ]));
}
