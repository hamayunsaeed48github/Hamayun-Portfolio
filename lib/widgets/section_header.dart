import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String eyebrow, title;
  final bool isMobile;
  final String? subtitle;
  const SectionHeader({super.key,required this.eyebrow,required this.title,required this.isMobile,this.subtitle});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        Container(width:32, height:2,
          decoration:BoxDecoration(borderRadius:BorderRadius.circular(1),
            gradient:const LinearGradient(colors:[AppColors.sand,AppColors.teal]))),
        const SizedBox(width:12),
        Text(eyebrow, style:AppText.mono),
      ]),
      const SizedBox(height:14),
      Text(title, style:isMobile ? AppText.h2.copyWith(fontSize:26) : AppText.h2),
      if (subtitle!=null) ...[
        const SizedBox(height:10),
        ConstrainedBox(constraints:const BoxConstraints(maxWidth:560),
          child:Text(subtitle!, style:AppText.body)),
      ],
    ],
  );
}
