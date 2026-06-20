import 'dart:ui';

import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/nav_bar.dart';
import 'widgets/hero_section.dart';
import 'widgets/about_section.dart';
import 'widgets/services_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/ai_section.dart';
import 'widgets/publishing_section.dart';
import 'widgets/projects_section.dart';
import 'widgets/experience_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/footer_section.dart';
import 'data/portfolio_data.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});
  @override
  Widget build(BuildContext ctx)=>MaterialApp(
    title:'${PortfolioData.name} — Portfolio',
    debugShowCheckedModeBanner:false,
    scrollBehavior:_WebScrollBehavior(),
    theme:ThemeData.dark().copyWith(
      scaffoldBackgroundColor:AppColors.ink,
      primaryColor:AppColors.sand,
      textSelectionTheme:const TextSelectionThemeData(cursorColor:AppColors.sand)),
    home:const PortfolioHome());
}

// Enable mouse-drag scrolling on web
class _WebScrollBehavior extends MaterialScrollBehavior {
  @override Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch, PointerDeviceKind.mouse, PointerDeviceKind.trackpad};
}

// ── Home shell ────────────────────────────────────────────────────────────────
class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});
  @override State<PortfolioHome> createState()=>_HomeState();
}

class _HomeState extends State<PortfolioHome>{
  static const _labels=['About','Services','Skills','Projects','Experience','Publishing','Contact'];
  final List<GlobalKey> _keys=List.generate(7,(_)=>GlobalKey());
  final _scroll=ScrollController();

  void _scrollTo(int i){
    final ctx=_keys[i].currentContext;
    if(ctx!=null) Scrollable.ensureVisible(ctx,duration:const Duration(milliseconds:650),curve:Curves.easeInOutCubic);
  }

  void _mobileMenu(BuildContext ctx)=>showModalBottomSheet(
    context:ctx, backgroundColor:AppColors.surfaceCard, shape:const RoundedRectangleBorder(borderRadius:BorderRadius.vertical(top:Radius.circular(20))),
    builder:(_)=>Column(mainAxisSize:MainAxisSize.min,children:[
      Container(width:36,height:4,margin:const EdgeInsets.only(top:12),decoration:BoxDecoration(color:AppColors.border,borderRadius:BorderRadius.circular(2))),
      const SizedBox(height:8),
      ...List.generate(_labels.length,(i)=>ListTile(
        leading:const Icon(Icons.arrow_forward_ios_rounded,size:12,color:AppColors.teal),
        title:Text(_labels[i],style:AppText.bodyStrong),
        onTap:(){Navigator.pop(_);Future.delayed(const Duration(milliseconds:200),()=>_scrollTo(i));}))]));

  @override Widget build(BuildContext ctx){
    final m=MediaQuery.of(ctx).size.width<kBreakpoint;
    return Scaffold(
      backgroundColor:AppColors.ink,
      appBar:PortfolioNavBar(sectionLabels:_labels,onTapSection:_scrollTo,isMobile:m,onMenuTap:()=>_mobileMenu(ctx)),
      body:SingleChildScrollView(controller:_scroll,child:Column(children:[
        HeroSection(isMobile:m,onViewWork:()=>_scrollTo(3),onContact:()=>_scrollTo(6)),
        KeyedSubtree(key:_keys[0],child:AboutSection(isMobile:m)),
        KeyedSubtree(key:_keys[1],child:ServicesSection(isMobile:m)),
        KeyedSubtree(key:_keys[2],child:SkillsSection(isMobile:m)),
        AISection(isMobile:m),
        KeyedSubtree(key:_keys[3],child:ProjectsSection(isMobile:m)),
        KeyedSubtree(key:_keys[4],child:ExperienceSection(isMobile:m)),
        KeyedSubtree(key:_keys[5],child:PublishingSection(isMobile:m)),
        KeyedSubtree(key:_keys[6],child:ContactSection(isMobile:m)),
        FooterSection(isMobile:m),
      ])));
  }
}
