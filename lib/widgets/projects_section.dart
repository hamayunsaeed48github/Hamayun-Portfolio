import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import 'section_header.dart';
import 'fade_in_widget.dart';

class ProjectsSection extends StatelessWidget {
  final bool isMobile;
  const ProjectsSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext ctx) => Padding(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 80, vertical: isMobile ? 60 : 120),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        FadeInOnScroll(
            child: SectionHeader(
                eyebrow: '04 — PROJECTS',
                title: 'Things I have shipped',
                subtitle:
                'Each project was a real problem, solved with real technology, delivered to real users.',
                isMobile: isMobile)),
        const SizedBox(height: 56),
        ...List.generate(
            PortfolioData.projects.length,
                (i) => FadeInOnScroll(
                delay: Duration(milliseconds: 60 * i),
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: _ProjectDetailCard(
                        project: PortfolioData.projects[i],
                        isMobile: isMobile)))),
      ]));
}

// ── Full detail card ──────────────────────────────────────────────────────────
class _ProjectDetailCard extends StatefulWidget {
  final Project project;
  final bool isMobile;
  const _ProjectDetailCard(
      {required this.project, required this.isMobile});
  @override
  State<_ProjectDetailCard> createState() => _PDCState();
}

class _PDCState extends State<_ProjectDetailCard>
    with SingleTickerProviderStateMixin {
  bool _h = false;
  bool _expanded = false;
  int _selectedScreen = 0;
  late final AnimationController _expandCtrl;
  late final Animation<double> _expandAnim;

  @override
  void initState() {
    super.initState();
    _expandCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    _expandAnim =
        CurvedAnimation(parent: _expandCtrl, curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() {
    _expandCtrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    _expanded ? _expandCtrl.forward() : _expandCtrl.reverse();
  }

  Color get _accent => Color(widget.project.accentColor[0]);

  @override
  Widget build(BuildContext ctx) => MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: AppColors.surfaceCard,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color:
                  _h ? _accent.withOpacity(.45) : AppColors.border,
                  width: _h ? 1.2 : .8),
              boxShadow: _h
                  ? [
                BoxShadow(
                    color: _accent.withOpacity(.06),
                    blurRadius: 40,
                    offset: const Offset(0, 12))
              ]
                  : null),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // ── Poster / Screenshot area (auto-scrolling carousel) ──────────
            _PosterArea(
                project: widget.project,
                selected: _selectedScreen,
                onSelect: (i) => setState(() => _selectedScreen = i),
                isMobile: widget.isMobile,
                accent: _accent),
            // ── Body ─────────────────────────────────────────────────
            Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title row
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.project.title,
                                          style: AppText.h3),
                                      const SizedBox(height: 3),
                                      Text(widget.project.subtitle,
                                          style: AppText.body.copyWith(
                                              fontSize: 13, color: _accent)),
                                    ])),
                            _TagPill(widget.project.yourRole
                                .split('—')
                                .first
                                .trim()),
                          ]),
                      const SizedBox(height: 16),
                      // Tags
                      Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.project.tags
                              .map((t) => _Chip(t, _accent))
                              .toList()),
                      const SizedBox(height: 20),
                      // Problem / Solution row
                      widget.isMobile
                          ? Column(children: [
                        _ProbSol('🔴', 'Problem',
                            widget.project.problem, AppColors.warning),
                        const SizedBox(height: 12),
                        _ProbSol('🟢', 'Solution',
                            widget.project.solution, AppColors.success)
                      ])
                          : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: _ProbSol(
                                    '🔴',
                                    'Problem',
                                    widget.project.problem,
                                    AppColors.warning)),
                            const SizedBox(width: 16),
                            Expanded(
                                child: _ProbSol(
                                    '🟢',
                                    'Solution',
                                    widget.project.solution,
                                    AppColors.success))
                          ]),
                      // Expand toggle
                      const SizedBox(height: 20),
                      GestureDetector(
                          onTap: _toggle,
                          child: Row(children: [
                            AnimatedRotation(
                              turns: _expanded ? 0.5 : 0.0,
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                Icons.expand_more_rounded,
                                color: _accent,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                                _expanded
                                    ? 'Hide Details'
                                    : 'View Full Details',
                                style: AppText.bodyStrong
                                    .copyWith(color: _accent, fontSize: 13)),
                          ])),
                      // Expandable details
                      SizeTransition(
                          sizeFactor: _expandAnim,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                const _Divider(),
                                const SizedBox(height: 20),
                                // Technologies
                                _DetailBlock(
                                    title: 'Technologies Used',
                                    icon: '⚙️',
                                    child: Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: widget.project.technologies
                                            .map((t) => _TechPill(t))
                                            .toList())),
                                const SizedBox(height: 20),
                                // Features
                                _DetailBlock(
                                    title: 'Features',
                                    icon: '✨',
                                    child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: widget.project.features
                                            .map((f) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 7),
                                            child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          top: 6,
                                                          right: 9),
                                                      child: Container(
                                                          width: 5,
                                                          height: 5,
                                                          decoration: BoxDecoration(
                                                              color:
                                                              _accent,
                                                              shape: BoxShape
                                                                  .circle))),
                                                  Expanded(
                                                      child: Text(f,
                                                          style: AppText
                                                              .body
                                                              .copyWith(
                                                              fontSize:
                                                              14))),
                                                ])))
                                            .toList())),
                                const SizedBox(height: 20),
                                // Your Role
                                _DetailBlock(
                                    title: 'My Role',
                                    icon: '👤',
                                    child: Container(
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                            color: AppColors.surface,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors.border)),
                                        child: Text(widget.project.yourRole,
                                            style: AppText.body
                                                .copyWith(fontSize: 14)))),
                                const SizedBox(height: 20),
                                // Links
                                // Row(children: [
                                //   _LinkBtn(
                                //       label: 'Source Code',
                                //       icon: Icons.code_rounded,
                                //       url: widget.project.repoUrl,
                                //       accent: _accent),
                                //   const SizedBox(width: 20),
                                //   _LinkBtn(
                                //       label: 'Live Demo',
                                //       icon: Icons.open_in_new_rounded,
                                //       url: widget.project.liveUrl,
                                //       accent: _accent),
                                // ]),
                              ])),
                    ])),
          ])));
}

// ── Split Poster Area — now with AUTO-SCROLLING screenshots ──────────────────
// Left half  → screenshot / image (contained, no stretch), auto-advances
// Right half → animated decorative info panel
class _PosterArea extends StatefulWidget {
  final Project project;
  final int selected;
  final bool isMobile;
  final void Function(int) onSelect;
  final Color accent;

  const _PosterArea({
    required this.project,
    required this.selected,
    required this.onSelect,
    required this.isMobile,
    required this.accent,
  });

  @override
  State<_PosterArea> createState() => _PosterAreaState();
}

class _PosterAreaState extends State<_PosterArea>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatCtrl;
  late final Animation<double> _floatAnim;
  late final Animation<double> _fadeAnim;

  // ── Auto-scroll carousel timer ──────────────────────────────────────────
  Timer? _autoScrollTimer;
  static const _autoScrollInterval = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _floatAnim = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );
    _fadeAnim = CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut);

    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    final count = widget.project.screenshots.length;
    // Only auto-scroll when there's more than one screenshot to cycle through.
    if (count <= 1) return;
    _autoScrollTimer = Timer.periodic(_autoScrollInterval, (_) {
      if (!mounted) return;
      final next = (widget.selected + 1) % count;
      widget.onSelect(next);
    });
  }

  /// Called when the user manually taps a dot — jumps to that screenshot
  /// and restarts the auto-scroll timer so it doesn't immediately skip
  /// past the one they just picked.
  void _onManualSelect(int i) {
    widget.onSelect(i);
    _startAutoScroll();
  }

  @override
  void didUpdateWidget(covariant _PosterArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Restart the cycle if the project (and its screenshot count) changes.
    if (oldWidget.project.screenshots.length !=
        widget.project.screenshots.length) {
      _startAutoScroll();
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _floatCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    final shots = widget.project.screenshots;
    final posterHeight = widget.isMobile ? 240.0 : 360.0;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: SizedBox(
        height: posterHeight,
        child: widget.isMobile
        // ── Mobile: stacked, image on top ──────────────────────────────
            ? Stack(children: [
          // Full-width gradient bg
          Positioned.fill(
            child: _GradientBg(project: widget.project),
          ),
          // Image centered, contained — auto-advances via AnimatedSwitcher
          Positioned.fill(
            child: _ScreenImage(
              shots: shots,
              selected: widget.selected,
              accent: widget.accent,
              project: widget.project,
            ),
          ),
          // Dots at bottom (still tappable for manual override)
          if (shots.length > 1)
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: _DotsRow(
                count: shots.length,
                selected: widget.selected,
                accent: widget.accent,
                onSelect: _onManualSelect,
                project: widget.project,
              ),
            ),
        ])
        // ── Desktop: side by side ───────────────────────────────────────
            : Row(children: [
          // LEFT — screenshot (half width), auto-cycles
          Expanded(
            child: Stack(children: [
              Positioned.fill(
                child: _GradientBg(project: widget.project),
              ),
              Positioned.fill(
                child: _ScreenImage(
                  shots: shots,
                  selected: widget.selected,
                  accent: widget.accent,
                  project: widget.project,
                ),
              ),
              // Dots
              if (shots.length > 1)
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: _DotsRow(
                    count: shots.length,
                    selected: widget.selected,
                    accent: widget.accent,
                    onSelect: _onManualSelect,
                    project: widget.project,
                  ),
                ),
            ]),
          ),

          // RIGHT — animated decorative panel (half width)
          Expanded(
            child: _DecorativePanel(
              project: widget.project,
              accent: widget.accent,
              floatAnim: _floatAnim,
              fadeAnim: _fadeAnim,
            ),
          ),
        ]),
      ),
    );
  }
}

// ── Gradient background ───────────────────────────────────────────────────────
class _GradientBg extends StatelessWidget {
  final Project project;
  const _GradientBg({required this.project});

  @override
  Widget build(BuildContext ctx) => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(project.gradient[0]),
          Color(project.gradient[1])
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  );
}

// ── Screenshot image (no stretch) ────────────────────────────────────────────
class _ScreenImage extends StatelessWidget {
  final List<ProjectScreenshot> shots;
  final int selected;
  final Color accent;
  final Project project;

  const _ScreenImage({
    required this.shots,
    required this.selected,
    required this.accent,
    required this.project,
  });

  @override
  Widget build(BuildContext ctx) {
    if (shots.isEmpty) {
      return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.phone_android_rounded,
              size: 60, color: Colors.white.withOpacity(.25)),
          const SizedBox(height: 8),
          Text('Screenshots coming soon',
              style: AppText.small.copyWith(color: Colors.white54)),
        ]),
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: child,
      ),
      child: _SingleScreen(
        key: ValueKey(selected),
        screen: shots[selected],
        accent: accent,
      ),
    );
  }
}

class _SingleScreen extends StatelessWidget {
  final ProjectScreenshot screen;
  final Color accent;
  const _SingleScreen({super.key, required this.screen, required this.accent});

  @override
  Widget build(BuildContext ctx) => Stack(fit: StackFit.expand, children: [
    // Image — BoxFit.contain so no stretch, letterboxed within half
    Image.asset(
      screen.assetPath,
      fit: BoxFit.fill,
      alignment: Alignment.center,
      errorBuilder: (_, __, ___) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.add_photo_alternate_outlined,
              size: 44, color: Colors.white.withOpacity(.3)),
          const SizedBox(height: 6),
          Text(screen.assetPath.split('/').last,
              style: const TextStyle(color: Colors.white38, fontSize: 10)),
          const SizedBox(height: 3),
          Text('Add screenshot here',
              style: TextStyle(
                  color: accent.withOpacity(.7),
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ]),
      ),
    ),
    // // Caption label
    // Positioned(
    //   bottom: 36,
    //   left: 10,
    //   child: Container(
    //     padding:
    //     const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
    //     decoration: BoxDecoration(
    //         color: Colors.black54,
    //         borderRadius: BorderRadius.circular(6)),
    //     child: Text(screen.caption,
    //         style:
    //         const TextStyle(color: Colors.white70, fontSize: 10)),
    //   ),
    // ),
  ]);
}

// ── Dots row ──────────────────────────────────────────────────────────────────
class _DotsRow extends StatelessWidget {
  final int count, selected;
  final Color accent;
  final void Function(int) onSelect;
  final Project project;
  const _DotsRow(
      {required this.count,
        required this.selected,
        required this.accent,
        required this.onSelect,
        required this.project});

  @override
  Widget build(BuildContext ctx) => Center(
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      ...List.generate(
          count,
              (i) => GestureDetector(
            onTap: () => onSelect(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: i == selected ? 36 : 24,
              height: i == selected ? 5 : 4,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                  color: i == selected
                      ? Colors.white
                      : Colors.white38,
                  borderRadius: BorderRadius.circular(3)),
            ),
          )),
      // Demo video pill
      // if (project.demoVideoPath != null) ...[
      //   const SizedBox(width: 10),
      //   Container(
      //     padding:
      //     const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      //     decoration: BoxDecoration(
      //         color: Colors.black45,
      //         borderRadius: BorderRadius.circular(20)),
      //     child: Row(mainAxisSize: MainAxisSize.min, children: [
      //       const Icon(Icons.play_circle_outline_rounded,
      //           color: Colors.white70, size: 12),
      //       const SizedBox(width: 4),
      //       Text('Demo',
      //           style: AppText.mono.copyWith(
      //               fontSize: 8,
      //               color: Colors.white70,
      //               letterSpacing: 1)),
      //     ]),
      //   ),
      // ],
    ]),
  );
}

// ── RIGHT PANEL: Animated decorative info panel ───────────────────────────────
class _DecorativePanel extends StatelessWidget {
  final Project project;
  final Color accent;
  final Animation<double> floatAnim;
  final Animation<double> fadeAnim;

  const _DecorativePanel({
    required this.project,
    required this.accent,
    required this.floatAnim,
    required this.fadeAnim,
  });

  @override
  Widget build(BuildContext ctx) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accent.withOpacity(.18),
            AppColors.surfaceCard,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border(
          left: BorderSide(color: accent.withOpacity(.15), width: 1),
        ),
      ),
      child: Stack(children: [
        // ── Decorative background circles ─────────────────────────────
        Positioned(
          top: -40,
          right: -40,
          child: _PulsingCircle(accent: accent, size: 180, opacity: .07),
        ),
        Positioned(
          bottom: -30,
          left: -20,
          child: _PulsingCircle(accent: accent, size: 130, opacity: .05),
        ),

        // ── Floating grid dots decoration ─────────────────────────────
        Positioned.fill(
          child: CustomPaint(painter: _DotGridPainter(accent: accent)),
        ),

        // ── Content ───────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Eyebrow label
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: accent.withOpacity(.15),
                  borderRadius: BorderRadius.circular(20),
                  border:
                  Border.all(color: accent.withOpacity(.3), width: .8),
                ),
                child: Text(
                  'PROJECT OVERVIEW',
                  style: AppText.mono.copyWith(
                      fontSize: 8,
                      color: accent,
                      letterSpacing: 2),
                ),
              ),

              const SizedBox(height: 16),

              // Floating animated stat cards
              AnimatedBuilder(
                animation: floatAnim,
                builder: (_, __) => Transform.translate(
                  offset: Offset(0, floatAnim.value),
                  child: _StatCard(
                    label: 'Technologies',
                    value: '${project.technologies.length}+',
                    accent: accent,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              AnimatedBuilder(
                animation: floatAnim,
                builder: (_, __) => Transform.translate(
                  // Opposite phase for second card
                  offset: Offset(0, -floatAnim.value * .7),
                  child: _StatCard(
                    label: 'Features Shipped',
                    value: '${project.features.length}',
                    accent: accent,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Subtle separator
              Container(
                height: .6,
                width: 60,
                color: accent.withOpacity(.4),
              ),

              const SizedBox(height: 16),

              // Tags strip
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: project.tags
                    .take(3)
                    .map((t) => _MiniTag(label: t, accent: accent))
                    .toList(),
              ),

              const SizedBox(height: 16),

              // Animated "scroll to explore" hint
              // AnimatedBuilder(
              //   animation: fadeAnim,
              //   builder: (_, child) => Opacity(
              //     opacity: (.4 + .6 * fadeAnim.value).clamp(0.0, 1.0),
              //     child: child,
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Icon(Icons.touch_app_outlined,
              //           size: 13, color: accent.withOpacity(.7)),
              //       const SizedBox(width: 5),
              //       Text(
              //         'Tap card to explore',
              //         style: AppText.mono.copyWith(
              //             fontSize: 9,
              //             color: accent.withOpacity(.7),
              //             letterSpacing: 1.2),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ]),
    );
  }
}

// ── Animated pulsing circle ───────────────────────────────────────────────────
class _PulsingCircle extends StatefulWidget {
  final Color accent;
  final double size, opacity;
  const _PulsingCircle(
      {required this.accent, required this.size, required this.opacity});

  @override
  State<_PulsingCircle> createState() => _PulsingCircleState();
}

class _PulsingCircleState extends State<_PulsingCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2400))
      ..repeat(reverse: true);
    _scale = Tween<double>(begin: .9, end: 1.1)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) => AnimatedBuilder(
    animation: _scale,
    builder: (_, __) => Transform.scale(
      scale: _scale.value,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.accent.withOpacity(widget.opacity),
        ),
      ),
    ),
  );
}

// ── Dot-grid background painter ───────────────────────────────────────────────
class _DotGridPainter extends CustomPainter {
  final Color accent;
  _DotGridPainter({required this.accent});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = accent.withOpacity(.06)
      ..style = PaintingStyle.fill;

    const spacing = 20.0;
    const radius = 1.5;

    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotGridPainter old) => old.accent != accent;
}

// ── Stat card (floating) ──────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String label, value;
  final Color accent;
  const _StatCard(
      {required this.label, required this.value, required this.accent});

  @override
  Widget build(BuildContext ctx) => Container(
    padding:
    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: AppColors.surfaceCard.withOpacity(.8),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withOpacity(.25), width: .8),
      boxShadow: [
        BoxShadow(
            color: accent.withOpacity(.08),
            blurRadius: 12,
            offset: const Offset(0, 4)),
      ],
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Text(
        value,
        style: AppText.h3.copyWith(color: accent, fontSize: 22),
      ),
      const SizedBox(width: 10),
      Text(
        label,
        style: AppText.body.copyWith(fontSize: 12, color: AppColors.paper.withOpacity(.7)),
      ),
    ]),
  );
}

// ── Mini tag for panel ────────────────────────────────────────────────────────
class _MiniTag extends StatelessWidget {
  final String label;
  final Color accent;
  const _MiniTag({required this.label, required this.accent});

  @override
  Widget build(BuildContext ctx) => Container(
    padding:
    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: accent.withOpacity(.1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(label,
        style: AppText.mono
            .copyWith(fontSize: 9, color: accent, letterSpacing: .8)),
  );
}

// ── Small helpers ─────────────────────────────────────────────────────────────
class _ProbSol extends StatelessWidget {
  final String emoji, title, text;
  final Color color;
  const _ProbSol(this.emoji, this.title, this.text, this.color);

  @override
  Widget build(BuildContext ctx) => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: color.withOpacity(.07),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(.2))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(title,
              style: AppText.bodyStrong
                  .copyWith(fontSize: 13, color: color))
        ]),
        const SizedBox(height: 8),
        Text(text, style: AppText.body.copyWith(fontSize: 13)),
      ]));
}

class _DetailBlock extends StatelessWidget {
  final String title, icon;
  final Widget child;
  const _DetailBlock(
      {required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext ctx) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(icon, style: const TextStyle(fontSize: 15)),
          const SizedBox(width: 8),
          Text(title, style: AppText.bodyStrong)
        ]),
        const SizedBox(height: 12),
        child,
      ]);
}

class _Chip extends StatelessWidget {
  final String label;
  final Color accent;
  const _Chip(this.label, this.accent);

  @override
  Widget build(BuildContext ctx) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: accent.withOpacity(.4)),
          borderRadius: BorderRadius.circular(20)),
      child: Text(label,
          style: AppText.mono
              .copyWith(fontSize: 10, color: accent, letterSpacing: 1)));
}

class _TechPill extends StatelessWidget {
  final String t;
  const _TechPill(this.t);

  @override
  Widget build(BuildContext ctx) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(20)),
      child: Text(t,
          style: AppText.small.copyWith(color: AppColors.paper)));
}

class _TagPill extends StatelessWidget {
  final String t;
  const _TagPill(this.t);

  @override
  Widget build(BuildContext ctx) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: AppColors.tealDark.withOpacity(.2),
          borderRadius: BorderRadius.circular(20),
          border:
          Border.all(color: AppColors.teal.withOpacity(.3))),
      child: Text(t,
          style: AppText.mono.copyWith(
              fontSize: 9, color: AppColors.teal, letterSpacing: 1)));
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext ctx) =>
      Container(height: .7, color: AppColors.border);
}

class _LinkBtn extends StatelessWidget {
  final String label, url;
  final IconData icon;
  final Color accent;
  const _LinkBtn(
      {required this.label,
        required this.icon,
        required this.url,
        required this.accent});

  @override
  Widget build(BuildContext ctx) => InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 15, color: accent),
        const SizedBox(width: 6),
        Text(label,
            style: AppText.bodyStrong
                .copyWith(color: accent, fontSize: 13))
      ]));
}