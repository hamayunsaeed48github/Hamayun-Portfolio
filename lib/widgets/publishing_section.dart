import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'fade_in_widget.dart';

class PublishingSection extends StatelessWidget {
  final bool isMobile;
  const PublishingSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext ctx) => Container(
    color: AppColors.surface,
    padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80, vertical: isMobile ? 60 : 110),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      FadeInOnScroll(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 32, height: 2,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(1),
                gradient: const LinearGradient(colors: [AppColors.sand, AppColors.teal]))),
            const SizedBox(width: 12),
            Text('APP PUBLISHING', style: AppText.mono),
          ]),
          const SizedBox(height: 14),
          Text('From Code to Store 🏪',
            style: isMobile ? AppText.h2.copyWith(fontSize: 26) : AppText.h2),
          const SizedBox(height: 10),
          ConstrainedBox(constraints: const BoxConstraints(maxWidth: 580),
            child: Text(
                'After building an app, it is important to bring it to the world. '
                'I handle complete publishing on both Google Play Store and Apple App Store — '
                'from submission to final live launch.',
              style: AppText.body)),
        ]),
      ),
      const SizedBox(height: 48),
      // Store badges row
      FadeInOnScroll(
        delay: const Duration(milliseconds: 100),
        child: isMobile
          ? Column(children: [_GooglePlayCard(), const SizedBox(height: 20), _AppStoreCard()])
          : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: _GooglePlayCard()),
              const SizedBox(width: 20),
              Expanded(child: _AppStoreCard()),
            ]),
      ),
      const SizedBox(height: 40),
      // Process steps
      FadeInOnScroll(
        delay: const Duration(milliseconds: 180),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('My Publishing Process', style: AppText.h4),
          const SizedBox(height: 24),
          isMobile
            ? Column(children: _steps().map((s) => Padding(padding: const EdgeInsets.only(bottom: 14), child: s)).toList())
            : _StepsGrid(),
        ]),
      ),
      const SizedBox(height: 36),
      // Bottom CTA banner
      FadeInOnScroll(
        delay: const Duration(milliseconds: 220),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 22 : 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [AppColors.sand.withOpacity(.12), AppColors.teal.withOpacity(.08)],
              begin: Alignment.topLeft, end: Alignment.bottomRight),
            border: Border.all(color: AppColors.sand.withOpacity(.3))),
          child: isMobile
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _ctaText(),
                const SizedBox(height: 16),
                _ctaBadges(isMobile),
              ])
            : Row(children: [
                Expanded(child: _ctaText()),
                const SizedBox(width: 32),
                _ctaBadges(isMobile),
              ]),
        ),
      ),
    ]),
  );

  Widget _ctaText() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('🚀', style: TextStyle(fontSize: 28)),
    const SizedBox(height: 8),
    Text('Ready to go live?', style: AppText.h3.copyWith(fontSize: 20)),
    const SizedBox(height: 6),
    Text(
        'I handle your app from start to finish '
        'from development to publishing on app stores.',
      style: AppText.body.copyWith(fontSize: 14)),
  ]);

  Widget _ctaBadges(bool mobile) => Wrap(
    spacing: 14, runSpacing: 14,
    alignment: mobile ? WrapAlignment.start : WrapAlignment.center,
    children: [
      _StorePill('Google Play', '▶', const Color(0xFF01875F)),
      _StorePill('App Store',   '🍎', const Color(0xFF0071E3)),
    ]);

  List<Widget> _steps() => [
    _StepCard(n:'1',icon:'📋',title:'Planning & Requirements',desc:'Store guidelines review, target audience, content rating determination.'),
    _StepCard(n:'2',icon:'🎨',title:'Store Assets Preparation',desc:'App icon (512×512), feature graphic, screenshots (all sizes), promo video.'),
    _StepCard(n:'3',icon:'🔑',title:'Signing & Certificates',desc:'Keystore generation (Android), Apple certificates & provisioning profiles (iOS).'),
    _StepCard(n:'4',icon:'📝',title:'Store Listing (ASO)',desc:'Optimised title, description, keywords, category selection for better discoverability.'),
    _StepCard(n:'5',icon:'📤',title:'Submission & Review',desc:'Upload build, fill compliance forms, submit for review — handle any rejections.'),
    _StepCard(n:'6',icon:'🌍',title:'Live Launch & Monitoring',desc:'Phased rollout, crash monitoring, user feedback tracking, update releases.'),
  ];
}

// ── Google Play Card ─────────────────────────────────────────────────────────
class _GooglePlayCard extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: AppColors.surfaceCard,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF01875F).withOpacity(.4))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 44, height: 44,
          decoration: BoxDecoration(color: const Color(0xFF01875F).withOpacity(.15), borderRadius: BorderRadius.circular(10)),
          child: const Center(child: Text('▶', style: TextStyle(fontSize: 20)))),
        const SizedBox(width: 14),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Google Play Store', style: AppText.h4),
          Text('Android App Publishing', style: AppText.small.copyWith(color: const Color(0xFF01875F))),
        ]),
      ]),
      const SizedBox(height: 18),
      ...[
        'APK / AAB build generation',
        'Play Console account setup',
        'Internal → Closed → Open testing',
        'Production release & phased rollout',
        'Store listing in multiple languages',
        'Data safety form & privacy policy',
      ].map((f) => _FeatureRow(f, const Color(0xFF01875F))),
    ]));
}

// ── App Store Card ────────────────────────────────────────────────────────────
class _AppStoreCard extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: AppColors.surfaceCard,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF0071E3).withOpacity(.4))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 44, height: 44,
          decoration: BoxDecoration(color: const Color(0xFF0071E3).withOpacity(.15), borderRadius: BorderRadius.circular(10)),
          child: const Center(child: Text('🍎', style: TextStyle(fontSize: 20)))),
        const SizedBox(width: 14),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Apple App Store', style: AppText.h4),
          Text('iOS App Publishing', style: AppText.small.copyWith(color: const Color(0xFF0071E3))),
        ]),
      ]),
      const SizedBox(height: 18),
      ...[
        'Xcode archive & IPA build',
        'Apple Developer account setup',
        'TestFlight beta distribution',
        'App Store Connect submission',
        'App Review compliance & guidelines',
        'Certificates, provisioning & signing',
      ].map((f) => _FeatureRow(f, const Color(0xFF0071E3))),
    ]));
}

class _FeatureRow extends StatelessWidget {
  final String text; final Color color;
  const _FeatureRow(this.text, this.color);
  @override Widget build(BuildContext ctx) => Padding(
    padding: const EdgeInsets.only(bottom: 7),
    child: Row(children: [
      Container(width: 5, height: 5, margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      Expanded(child: Text(text, style: AppText.small)),
    ]));
}

// ── Steps Grid ───────────────────────────────────────────────────────────────
class _StepsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) => LayoutBuilder(
    builder: (ctx, con) {
      final w = (con.maxWidth - 20) / 3;
      return Wrap(spacing: 20, runSpacing: 20, children: [
        _StepCard(n:'1',icon:'📋',title:'Planning & Requirements',   desc:'Store guidelines review, content rating, target audience.',    width:w),
        _StepCard(n:'2',icon:'🎨',title:'Store Assets Preparation',  desc:'Icon, feature graphic, screenshots (all device sizes).',       width:w),
        _StepCard(n:'3',icon:'🔑',title:'Signing & Certificates',    desc:'Keystore (Android), Apple certs & provisioning profiles.',     width:w),
        _StepCard(n:'4',icon:'📝',title:'Store Listing (ASO)',        desc:'Optimised title, description & keywords for discoverability.',  width:w),
        _StepCard(n:'5',icon:'📤',title:'Submission & Review',        desc:'Upload build, compliance forms, handle rejections.',           width:w),
        _StepCard(n:'6',icon:'🌍',title:'Live Launch & Monitoring',   desc:'Phased rollout, crash monitoring & update releases.',          width:w),
      ]);
    });
}

class _StepCard extends StatelessWidget {
  final String n, icon, title, desc;
  final double? width;
  const _StepCard({required this.n, required this.icon, required this.title, required this.desc, this.width});
  @override
  Widget build(BuildContext ctx) => SizedBox(
    width: width,
    child: Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 28, height: 28,
          decoration: BoxDecoration(
            color: AppColors.sand.withOpacity(.12),
            borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          child: Text(n, style: AppText.mono.copyWith(color: AppColors.sand, fontSize: 11, letterSpacing: 0))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Text(icon, style: const TextStyle(fontSize: 14)), const SizedBox(width: 6),
            Expanded(child: Text(title, style: AppText.bodyStrong.copyWith(fontSize: 13)))]),
          const SizedBox(height: 4),
          Text(desc, style: AppText.small),
        ])),
      ])));
}

class _StorePill extends StatefulWidget {
  final String label, icon; final Color color;
  const _StorePill(this.label, this.icon, this.color);
  @override State<_StorePill> createState() => _SPState();
}
class _SPState extends State<_StorePill> {
  bool _h = false;
  @override Widget build(BuildContext ctx) => MouseRegion(
    onEnter: (_) => setState(() => _h = true),
    onExit:  (_) => setState(() => _h = false),
    child: AnimatedContainer(duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: _h ? widget.color.withOpacity(.18) : widget.color.withOpacity(.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.color.withOpacity(_h ? .7 : .4))),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(widget.icon, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 8),
        Text(widget.label, style: AppText.bodyStrong.copyWith(color: widget.color, fontSize: 14)),
      ])));
}
