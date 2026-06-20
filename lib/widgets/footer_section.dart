import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';

class FooterSection extends StatelessWidget {
  final bool isMobile;
  const FooterSection({super.key,required this.isMobile});
  @override
  Widget build(BuildContext ctx)=>Container(
    padding:EdgeInsets.symmetric(horizontal:isMobile?24:80,vertical:28),
    decoration:const BoxDecoration(border:Border(top:BorderSide(color:AppColors.border,width:.8))),
    child:Wrap(alignment:WrapAlignment.spaceBetween,crossAxisAlignment:WrapCrossAlignment.center,runSpacing:10,children:[
      Text('© 2025 ${PortfolioData.name}. All rights reserved.',style:AppText.small),
      Row(mainAxisSize:MainAxisSize.min,children:[
        Text('Built with ',style:AppText.small),
        Text('Flutter',style:AppText.small.copyWith(color:AppColors.teal,fontWeight:FontWeight.w700)),
        Text(' & ❤️',style:AppText.small),
      ]),
    ]));
}
