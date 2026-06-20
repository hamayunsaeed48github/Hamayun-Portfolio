import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'fade_in_widget.dart';

class AISection extends StatelessWidget {
  final bool isMobile;
  const AISection({super.key,required this.isMobile});

  @override
  Widget build(BuildContext ctx)=>Container(
    padding:EdgeInsets.symmetric(horizontal:isMobile?24:80,vertical:isMobile?60:100),
    decoration:BoxDecoration(
      gradient:LinearGradient(colors:[AppColors.ink,AppColors.tealDark.withOpacity(.08),AppColors.ink],
        begin:Alignment.topLeft,end:Alignment.bottomRight)),
    child:FadeInOnScroll(child:Container(
      padding:EdgeInsets.all(isMobile?28:48),
      decoration:BoxDecoration(
        color:AppColors.surfaceCard,
        borderRadius:BorderRadius.circular(24),
        border:Border.all(color:AppColors.teal.withOpacity(.3)),
        boxShadow:[BoxShadow(color:AppColors.teal.withOpacity(.06),blurRadius:60,offset:const Offset(0,20))]),
      child:isMobile ? _mobile() : _desktop())));

  Widget _badge()=>Container(
    padding:const EdgeInsets.symmetric(horizontal:14,vertical:6),
    decoration:BoxDecoration(
      gradient:const LinearGradient(colors:[AppColors.tealDark,AppColors.teal]),
      borderRadius:BorderRadius.circular(20)),
    child:Row(mainAxisSize:MainAxisSize.min,children:[
      const Icon(Icons.auto_awesome_rounded,color:Colors.white,size:14),
      const SizedBox(width:6),
      Text('AI-POWERED DEVELOPMENT',style:AppText.mono.copyWith(color:Colors.white,letterSpacing:2)),
    ]));

  Widget _title()=>Text('Building for the\nAI Era 🤖',
    style:AppText.h2.copyWith(fontSize:isMobile?26:36,height:1.1));

  Widget _desc()=>Text(
    'AI is no longer a feature — it\'s the foundation. I integrate OpenAI, '
    'Gemini, and on-device ML into mobile apps to create smarter, more '
    'personalised experiences that give products a real competitive edge.',
    style:AppText.body);

  Widget _cards()=>Wrap(spacing:14,runSpacing:14,children:[
    _AICard('🧠','LLM Integration','OpenAI & Gemini APIs in Flutter and Android apps'),
    _AICard('💬','AI Chatbots','Context-aware assistants built into your app UI'),
    _AICard('📸','Image Recognition','On-device ML Kit for real-time image classification'),
    _AICard('🔍','Smart Search','Natural language queries for app content'),
    _AICard('🎯','Recommendations','Personalised content and product suggestion engines'),
    _AICard('🗣️','NLP Features','Voice commands, text analysis and sentiment detection'),
  ]);

  Widget _desktop()=>Row(crossAxisAlignment:CrossAxisAlignment.center,children:[
    Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      _badge(),const SizedBox(height:20),_title(),const SizedBox(height:16),_desc()])),
    const SizedBox(width:56),
    Expanded(child:_cards()),
  ]);

  Widget _mobile()=>Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    _badge(),const SizedBox(height:20),_title(),const SizedBox(height:14),_desc(),const SizedBox(height:28),_cards()]);
}

class _AICard extends StatefulWidget {
  final String icon,title,desc;
  const _AICard(this.icon,this.title,this.desc);
  @override State<_AICard> createState()=>_AICState();
}
class _AICState extends State<_AICard>{
  bool _h=false;
  @override Widget build(BuildContext ctx)=>MouseRegion(
    onEnter:(_)=>setState(()=>_h=true),onExit:(_)=>setState(()=>_h=false),
    child:AnimatedContainer(duration:const Duration(milliseconds:180),
      width:200,padding:const EdgeInsets.all(16),
      decoration:BoxDecoration(
        color:_h?AppColors.surfaceLight:AppColors.surface,
        borderRadius:BorderRadius.circular(12),
        border:Border.all(color:_h?AppColors.teal.withOpacity(.5):AppColors.border)),
      child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text(widget.icon,style:const TextStyle(fontSize:22)),
        const SizedBox(height:8),
        Text(widget.title,style:AppText.bodyStrong.copyWith(fontSize:13)),
        const SizedBox(height:4),
        Text(widget.desc,style:AppText.small.copyWith(fontSize:12)),
      ])));
}
