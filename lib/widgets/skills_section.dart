import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import 'section_header.dart';
import 'fade_in_widget.dart';

class SkillsSection extends StatelessWidget {
  final bool isMobile;
  const SkillsSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext ctx) => Container(
    color: AppColors.surface,
    padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 80,
        vertical: isMobile ? 40 : 120
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInOnScroll(
            child: SectionHeader(
                eyebrow: '03 — SKILLS',
                title: 'My Technical Toolkit',
                subtitle: 'Everything I use to build complete, production-ready mobile products.',
                isMobile: isMobile
            )
        ),
        const SizedBox(height: 52),

        // ===== NEW: Skill Categories with Icon Headers =====
        LayoutBuilder(
            builder: (ctx, con) {
              final cols = isMobile ? 1 : 2;
              final spacing = isMobile ? 12.0 : 20.0;
              final w = (con.maxWidth - (cols - 1) * spacing) / cols;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: List.generate(
                    PortfolioData.skillGroups.length,
                        (i) => FadeInOnScroll(
                        delay: Duration(milliseconds: 70 * i),
                        child: SizedBox(
                            width: w,
                            child: _ModernSkillCard(
                              group: PortfolioData.skillGroups[i],
                              isMobile: isMobile,
                            )
                        )
                    )
                ),
              );
            }
        ),

        const SizedBox(height: 60),

        // ===== NEW: Soft Skills with Gradient Cards =====
        FadeInOnScroll(
            delay: const Duration(milliseconds: 300),
            child: _ModernSoftSkillsBlock(isMobile: isMobile)
        ),
      ],
    ),
  );
}

// ============================================================
// MODERN SKILL CARD (with Progress/Level Indicator)
// ============================================================
class _ModernSkillCard extends StatelessWidget {
  final SkillGroup group;
  final bool isMobile;
  const _ModernSkillCard({required this.group, required this.isMobile});

  @override
  Widget build(BuildContext ctx) => Container(
    padding: EdgeInsets.all(isMobile ? 16 : 24),
    decoration: BoxDecoration(
      color: AppColors.surfaceCard,
      borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
      border: Border.all(color: AppColors.border.withOpacity(0.3)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with emoji and title
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(isMobile ? 8 : 10),
              decoration: BoxDecoration(
                color: AppColors.sand.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                group.emoji,
                style: TextStyle(fontSize: isMobile ? 20 : 24),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                group.title,
                style: AppText.h4.copyWith(
                  fontSize: isMobile ? 15 : 17,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Skills as Modern Chips
        Wrap(
          spacing: isMobile ? 6 : 8,
          runSpacing: isMobile ? 6 : 8,
          children: group.items.map((item) => _ModernChip(
            label: item,
            isMobile: isMobile,
          )).toList(),
        ),

        // Small divider at bottom
        const SizedBox(height: 12),
        Container(
          height: 2,
          width: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.sand, AppColors.teal],
            ),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// MODERN CHIP (with subtle gradient)
// ============================================================
class _ModernChip extends StatelessWidget {
  final String label;
  final bool isMobile;
  const _ModernChip({required this.label, required this.isMobile});

  @override
  Widget build(BuildContext ctx) => Container(
    padding: EdgeInsets.symmetric(
      horizontal: isMobile ? 10 : 14,
      vertical: isMobile ? 5 : 7,
    ),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.surfaceLight.withOpacity(0.6),
          AppColors.surfaceCard,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: AppColors.border.withOpacity(0.2),
        width: 0.5,
      ),
    ),
    child: Text(
      label,
      style: AppText.small.copyWith(
        color: AppColors.paper,
        fontSize: isMobile ? 11 : 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

// ============================================================
// MODERN SOFT SKILLS BLOCK
// ============================================================
class _ModernSoftSkillsBlock extends StatelessWidget {
  final bool isMobile;
  const _ModernSoftSkillsBlock({required this.isMobile});

  @override
  Widget build(BuildContext ctx) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Section Header
      Row(
        children: [
          Container(
            width: 32,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: const LinearGradient(
                colors: [AppColors.sand, AppColors.teal],
              ),
            ),
          ),
          const SizedBox(width: 14),
          Text(
            'SOFT SKILLS',
            style: AppText.mono.copyWith(
              fontSize: isMobile ? 11 : 12,
              letterSpacing: 1.5,
            ),
          ),
          const Spacer(),
          // Decorative element
          Container(
            width: isMobile ? 30 : 60,
            height: 1,
            color: AppColors.border.withOpacity(0.3),
          ),
        ],
      ),
      const SizedBox(height: 24),

      // Soft Skills Grid
      LayoutBuilder(
        builder: (ctx, con) {
          final cols = isMobile ? 1 : 3;
          final spacing = isMobile ? 12.0 : 16.0;
          final w = (con.maxWidth - (cols - 1) * spacing) / cols;

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: PortfolioData.softSkills.map(
                    (s) => SizedBox(
                  width: w,
                  child: _ModernSoftSkillCard(
                    skill: s,
                    isMobile: isMobile,
                  ),
                )
            ).toList(),
          );
        },
      ),
    ],
  );
}

// ============================================================
// MODERN SOFT SKILL CARD (with hover effect & gradient)
// ============================================================
class _ModernSoftSkillCard extends StatelessWidget {
  final SoftSkill skill;
  final bool isMobile;
  const _ModernSoftSkillCard({required this.skill, required this.isMobile});

  @override
  Widget build(BuildContext ctx) => Container(
    padding: EdgeInsets.all(isMobile ? 16 : 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.surfaceCard,
          AppColors.surface.withOpacity(0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(isMobile ? 12 : 14),
      border: Border.all(
        color: AppColors.border.withOpacity(0.2),
        width: 0.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 12,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon with gradient background
        Container(
          padding: EdgeInsets.all(isMobile ? 8 : 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.sand.withOpacity(0.15),
                AppColors.teal.withOpacity(0.15),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            skill.icon,
            style: TextStyle(fontSize: isMobile ? 22 : 28),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                skill.title,
                style: AppText.bodyStrong.copyWith(
                  fontSize: isMobile ? 13 : 14,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                skill.description,
                style: AppText.small.copyWith(
                  fontSize: isMobile ? 11 : 12,
                  height: 1.5,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}