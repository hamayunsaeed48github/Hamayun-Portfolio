import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import 'section_header.dart';
import 'fade_in_widget.dart';

class ServicesSection extends StatelessWidget {
  final bool isMobile;
  const ServicesSection({super.key,required this.isMobile});

  @override
  Widget build(BuildContext ctx)=>Padding(
    padding:EdgeInsets.symmetric(horizontal:isMobile?24:80,vertical:isMobile?60:120),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      FadeInOnScroll(child:SectionHeader(eyebrow:'02 — SERVICES',title:'What I can build for you',
        subtitle:'From a single-screen app to a full production system — I handle the complete journey.',
        isMobile:isMobile)),
      const SizedBox(height:52),
      LayoutBuilder(builder:(ctx,con){
        final cols=isMobile?1:3;
        final w=(con.maxWidth-(cols-1)*24)/cols;
        return Wrap(spacing:24,runSpacing:24,
          children:List.generate(PortfolioData.services.length,(i)=>FadeInOnScroll(
            delay:Duration(milliseconds:80*i),
            child:SizedBox(width:w,child:_ServiceCard(service:PortfolioData.services[i])))));
      }),
    ]));
}

class _ServiceCard extends StatefulWidget {
  final ServiceItem service;
  const _ServiceCard({required this.service});
  @override State<_ServiceCard> createState()=>_SCState();
}
class _SCState extends State<_ServiceCard>{
  bool _h=false;
  @override Widget build(BuildContext ctx)=>MouseRegion(
    onEnter:(_)=>setState(()=>_h=true),onExit:(_)=>setState(()=>_h=false),
    child:AnimatedContainer(duration:const Duration(milliseconds:220),
      transform:Matrix4.translationValues(0,_h?-6:0,0),
      padding:const EdgeInsets.all(26),
      decoration:BoxDecoration(
        color:AppColors.surfaceCard,
        borderRadius:BorderRadius.circular(16),
        border:Border.all(color:_h?AppColors.sand.withOpacity(.5):AppColors.border,width:_h?1.2:.8),
        boxShadow:_h?[BoxShadow(color:AppColors.sand.withOpacity(.08),blurRadius:30,offset:const Offset(0,8))]:null),
      child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Row(children:[
          Text(widget.service.icon,style:const TextStyle(fontSize:28)),
          const SizedBox(width:12),
          Expanded(child:Text(widget.service.title,style:AppText.h4)),
        ]),
        const SizedBox(height:12),
        Text(widget.service.description,style:AppText.body.copyWith(fontSize:14)),
        const SizedBox(height:16),
        ...widget.service.features.map((f)=>Padding(
          padding:const EdgeInsets.only(bottom:6),
          child:Row(children:[
            Container(width:4,height:4,margin:const EdgeInsets.only(right:10,top:2),
              decoration:const BoxDecoration(color:AppColors.teal,shape:BoxShape.circle)),
            Expanded(child:Text(f,style:AppText.small)),
          ]))),
      ])));
}
