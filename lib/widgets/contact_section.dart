import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import 'section_header.dart';
import 'fade_in_widget.dart';

class ContactSection extends StatefulWidget {
  final bool isMobile;
  const ContactSection({super.key, required this.isMobile});
  @override State<ContactSection> createState() => _State();
}

class _State extends State<ContactSection> {
  final _nameC = TextEditingController();
  final _emailC = TextEditingController();
  final _subC = TextEditingController();
  final _msgC = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _nameC.dispose();
    _emailC.dispose();
    _subC.dispose();
    _msgC.dispose();
    super.dispose();
  }

  InputDecoration _dec(String label, IconData icon) => InputDecoration(
      labelText: label, labelStyle: AppText.body.copyWith(fontSize: 13.5),
      prefixIcon: Icon(icon, color: AppColors.mist, size: 18),
      filled: true, fillColor: AppColors.surface,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.border)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.border)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.sand, width: 1.5)));

  Future<void> sendEmail() async {
    final name = _nameC.text.trim();
    final email = _emailC.text.trim();
    final subject = _subC.text.trim();
    final message = _msgC.text.trim();

    // ❌ Validation first
    if (name.isEmpty || email.isEmpty || subject.isEmpty || message.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _sending = true);

    try {
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': 'service_y86zxix',
          'template_id': 'template_4saj04v',
          'user_id': 'hG_ZvIeQA7f3qZWTx',
          'template_params': {
            'title': subject,
            'from_name': name,
            'from_email': email,
            'subject': subject,
            'message': message,
            'name': name,
            'email': email,
          }
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        // ✅ SUCCESS
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message sent successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // clear fields
        _nameC.clear();
        _emailC.clear();
        _subC.clear();
        _msgC.clear();
      } else {
        // ❌ EmailJS error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send (${response.statusCode}): ${response.body}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 6),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _sending = false);
      }
    }
  }
  @override
  Widget build(BuildContext ctx)=>Container(color:AppColors.surface,
      padding:EdgeInsets.symmetric(horizontal:widget.isMobile?24:80,vertical:widget.isMobile?60:120),
      child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        FadeInOnScroll(child:SectionHeader(eyebrow:'06 — CONTACT',title:"Let's build something great",
            subtitle:'Have a project in mind? I am one message away.',isMobile:widget.isMobile)),
        const SizedBox(height:52),
        widget.isMobile
            ? Column(crossAxisAlignment:CrossAxisAlignment.start,children:[FadeInOnScroll(child:_info()),const SizedBox(height:36),FadeInOnScroll(delay:const Duration(milliseconds:100),child:_form())])
            : Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Expanded(child:FadeInOnScroll(child:_info())),const SizedBox(width:60),
          Expanded(child:FadeInOnScroll(delay:const Duration(milliseconds:100),child:_form()))]),
      ]));

  Widget _info()=>Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    _InfoRow(Icons.email_outlined,'Email',PortfolioData.email),const SizedBox(height:14),
    _InfoRow(Icons.phone_outlined,'Phone',PortfolioData.phone),const SizedBox(height:14),
    _InfoRow(Icons.location_on_outlined,'Location',PortfolioData.location),
    const SizedBox(height:28),
    Text('Available for',style:AppText.bodyStrong),
    const SizedBox(height:10),
    ...['Freelance projects','Full-time remote roles','Contract work','Consulting'].map((s)=>Padding(
        padding:const EdgeInsets.only(bottom:7),
        child:Row(children:[
          Container(width:5,height:5,margin:const EdgeInsets.only(right:10),
              decoration:const BoxDecoration(color:AppColors.success,shape:BoxShape.circle)),
          Text(s,style:AppText.body.copyWith(fontSize:14)),
        ]))),
    const SizedBox(height:28),
    Wrap(spacing:10,runSpacing:10,children:PortfolioData.socials.map((s)=>
        _SocialBtn(s)).toList()),
  ]);

  Widget _form()=>Container(padding:const EdgeInsets.all(28),
      decoration:BoxDecoration(color:AppColors.surfaceCard,borderRadius:BorderRadius.circular(16),border:Border.all(color:AppColors.border)),
      child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
        Text('Send Me a Message',style:AppText.h4),const SizedBox(height:20),
        Row(children:[Expanded(child:TextField(controller:_nameC,style:AppText.bodyStrong,decoration:_dec('Your Name',Icons.person_outline_rounded))),
          const SizedBox(width:14),
          Expanded(child:TextField(controller:_emailC,style:AppText.bodyStrong,decoration:_dec('Your Email',Icons.email_outlined)))]),
        const SizedBox(height:14),
        TextField(controller:_subC,style:AppText.bodyStrong,decoration:_dec('Subject',Icons.subject_rounded)),
        const SizedBox(height:14),
        TextField(controller:_msgC,maxLines:5,style:AppText.bodyStrong,decoration:_dec('Your Message',Icons.message_outlined)),
        const SizedBox(height:22),
        _SendBtn(onTap:sendEmail,loading:_sending),
      ]));
}

class _InfoRow extends StatelessWidget {
  final IconData icon; final String label,text;
  const _InfoRow(this.icon,this.label,this.text);
  @override Widget build(BuildContext ctx)=>Row(children:[
    Container(padding:const EdgeInsets.all(9),
        decoration:BoxDecoration(color:AppColors.surfaceCard,borderRadius:BorderRadius.circular(8),border:Border.all(color:AppColors.border)),
        child:Icon(icon,color:AppColors.sand,size:18)),
    const SizedBox(width:14),
    Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Text(label,style:AppText.small.copyWith(fontSize:11)),
      Text(text,style:AppText.bodyStrong.copyWith(fontSize:13)),
    ]),
  ]);
}

class _SocialBtn extends StatefulWidget {
  final SocialLink link; const _SocialBtn(this.link);
  @override State<_SocialBtn> createState()=>_SBState();
}
class _SBState extends State<_SocialBtn>{
  bool _h=false;
  @override Widget build(BuildContext ctx)=>MouseRegion(
      onEnter:(_)=>setState(()=>_h=true),onExit:(_)=>setState(()=>_h=false),
      child:GestureDetector(onTap:()=>launchUrl(Uri.parse(widget.link.url)),
          child:AnimatedContainer(duration:const Duration(milliseconds:180),
              padding:const EdgeInsets.symmetric(horizontal:16,vertical:9),
              decoration:BoxDecoration(
                  color:_h?AppColors.sand.withValues(alpha: .12):Colors.transparent,
                  border:Border.all(color:_h?AppColors.sand:AppColors.border),
                  borderRadius:BorderRadius.circular(8)),
              child:Text(widget.link.label,style:AppText.bodyStrong.copyWith(fontSize:13,color:_h?AppColors.sand:AppColors.mistLight)))));
}

class _SendBtn extends StatefulWidget {
  final VoidCallback onTap;
  final bool loading;
  const _SendBtn({required this.onTap, this.loading=false});
  @override State<_SendBtn> createState()=>_SendBtnState();
}
class _SendBtnState extends State<_SendBtn>{
  bool _h=false;
  @override Widget build(BuildContext ctx)=>MouseRegion(
      onEnter:(_)=>setState(()=>_h=true),onExit:(_)=>setState(()=>_h=false),
      child:GestureDetector(onTap: widget.loading ? null : widget.onTap,
          child:AnimatedContainer(duration:const Duration(milliseconds:180),
              padding:const EdgeInsets.symmetric(vertical:16),alignment:Alignment.center,
              decoration:BoxDecoration(
                  gradient:LinearGradient(colors: widget.loading
                      ? [AppColors.mist, AppColors.mist]
                      : (_h?[AppColors.sandLight,AppColors.sand]:[AppColors.sand,AppColors.tealDark])),
                  borderRadius:BorderRadius.circular(10),
                  boxShadow:_h && !widget.loading?[BoxShadow(color:AppColors.sand.withValues(alpha: .3),blurRadius:24)]:null),
              child: widget.loading
                  ? const SizedBox(
                  width:18,height:18,
                  child:CircularProgressIndicator(strokeWidth:2.2,color: AppColors.ink))
                  : Row(mainAxisAlignment:MainAxisAlignment.center,children:[
                const Icon(Icons.send_rounded,color:AppColors.ink,size:16),const SizedBox(width:8),
                Text('Send Message',style:AppText.button.copyWith(color:AppColors.ink))]))));
}