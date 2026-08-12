import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import 'section_header.dart';
import 'fade_in_widget.dart';

class ExperienceSection extends StatelessWidget {
  final bool isMobile;
  const ExperienceSection({super.key, required this.isMobile});

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
                  eyebrow: '05 — EXPERIENCE & EDUCATION',
                  title: 'My Journey',
                  subtitle: 'From classroom to production code.',
                  isMobile: isMobile
              )
          ),
          const SizedBox(height: 52),
          isMobile
              ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildExp(isMobile),
                const SizedBox(height: 48),
                _buildEdu(isMobile)
              ]
          )
              : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildExp(isMobile)),
                const SizedBox(width: 48),
                SizedBox(width: 320, child: _buildEdu(isMobile))
              ]
          ),
        ]
    ),
  );

  Widget _buildExp(bool m) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
          'Experience',
          style: AppText.h4.copyWith(
            color: AppColors.sand,
            fontSize: m ? 20 : null,
          )
      ),
      const SizedBox(height: 24),
      ...List.generate(
        PortfolioData.experiences.length,
            (i) => FadeInOnScroll(
            delay: Duration(milliseconds: 80 * i),
            child: _ExpItem(
              exp: PortfolioData.experiences[i],
              isLast: i == PortfolioData.experiences.length - 1,
              isMobile: m,
            )
        ),
      ),
    ],
  );

  Widget _buildEdu(bool m) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
          'Education',
          style: AppText.h4.copyWith(
            color: AppColors.teal,
            fontSize: m ? 20 : null,
          )
      ),
      const SizedBox(height: 24),
      ...List.generate(
        PortfolioData.education.length,
            (i) => FadeInOnScroll(
            delay: Duration(milliseconds: 100 + 80 * i),
            child: Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: EdgeInsets.all(m ? 14 : 18),
              decoration: BoxDecoration(
                color: AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        PortfolioData.education[i].$1,
                        style: AppText.bodyStrong.copyWith(
                          fontSize: m ? 13 : 14,
                        )
                    ),
                    const SizedBox(height: 4),
                    Text(
                        PortfolioData.education[i].$2,
                        style: AppText.small.copyWith(
                          color: AppColors.teal,
                          fontSize: m ? 12 : null,
                        )
                    ),
                    const SizedBox(height: 2),
                    Text(
                        PortfolioData.education[i].$3,
                        style: AppText.mono.copyWith(
                          fontSize: m ? 9 : 10,
                        )
                    ),
                  ]
              ),
            )
        ),
      ),
      const SizedBox(height: 24),
      Text(
          'Certifications',
          style: AppText.h4.copyWith(
            color: AppColors.sand,
            fontSize: m ? 20 : null,
          )
      ),
      const SizedBox(height: 14),
      FadeInOnScroll(
          child: Container(
            padding: EdgeInsets.all(m ? 14 : 18),
            decoration: BoxDecoration(
              color: AppColors.surfaceCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
              gradient: LinearGradient(
                  colors: [
                    AppColors.sand.withOpacity(.08),
                    Colors.transparent
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
              ),
            ),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.all(m ? 6 : 8),
                      decoration: BoxDecoration(
                        color: AppColors.sand.withOpacity(.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.verified_rounded,
                        color: AppColors.sand,
                        size: m ? 18 : 22,
                      )
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Android Development',
                              style: AppText.bodyStrong.copyWith(
                                fontSize: m ? 13 : 14,
                              )
                          ),
                          Text(
                              'Coursera · 2023',
                              style: AppText.small.copyWith(
                                color: AppColors.teal,
                                fontSize: m ? 12 : null,
                              )
                          ),
                          const SizedBox(height: 4),
                          Text(
                              'Kotlin, Jetpack Compose, Firebase, SQLite, UI/UX Design',
                              style: AppText.small.copyWith(
                                fontSize: m ? 11 : null,
                              )
                          ),
                        ]
                    ),
                  ),
                ]
            ),
          )
      ),
    ],
  );
}

class _ExpItem extends StatelessWidget {
  final Experience exp;
  final bool isLast;
  final bool isMobile;

  const _ExpItem({
    required this.exp,
    required this.isLast,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext ctx) => IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline column
        Column(
          children: [
            Container(
                width: isMobile ? 12 : 14,
                height: isMobile ? 12 : 14,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.ink,
                    border: Border.all(
                      color: AppColors.sand,
                      width: isMobile ? 1.5 : 2,
                    )
                )
            ),
            if (!isLast)
              Expanded(
                  child: Container(
                    width: 1.5,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.sand.withOpacity(.4),
                            Colors.transparent
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                    ),
                  )
              ),
          ],
        ),
        SizedBox(width: isMobile ? 14 : 22),
        // Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isMobile ? 24 : 36),
            child: Container(
              padding: EdgeInsets.all(isMobile ? 14 : 20),
              decoration: BoxDecoration(
                color: AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(isMobile ? 12 : 14),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Role and organization - responsive layout
                  isMobile
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          exp.role,
                          style: AppText.h4.copyWith(
                            fontSize: 17,
                          )
                      ),
                      const SizedBox(height: 3),
                      Text(
                          exp.org,
                          style: AppText.bodyStrong.copyWith(
                            color: AppColors.teal,
                            fontSize: 13,
                          )
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 4
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                                exp.duration,
                                style: AppText.mono.copyWith(
                                  fontSize: 9,
                                )
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                              exp.location,
                              style: AppText.small.copyWith(
                                fontSize: 10,
                              )
                          ),
                        ],
                      ),
                    ],
                  )
                      : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exp.role,
                              style: AppText.h4,
                            ),
                            const SizedBox(height: 3),
                            Text(
                                exp.org,
                                style: AppText.bodyStrong.copyWith(
                                  color: AppColors.teal,
                                  fontSize: 13,
                                )
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 4
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                                exp.duration,
                                style: AppText.mono.copyWith(
                                  fontSize: 9,
                                )
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                              exp.location,
                              style: AppText.small.copyWith(
                                fontSize: 11,
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Points - responsive spacing
                  ...exp.points.map(
                          (p) => Padding(
                        padding: EdgeInsets.only(
                          bottom: isMobile ? 6 : 7,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: isMobile ? 6 : 7,
                                right: isMobile ? 7 : 9,
                              ),
                              child: Container(
                                  width: isMobile ? 4 : 5,
                                  height: isMobile ? 4 : 5,
                                  decoration: const BoxDecoration(
                                    color: AppColors.sand,
                                    shape: BoxShape.circle,
                                  )
                              ),
                            ),
                            Expanded(
                              child: Text(
                                  p,
                                  style: AppText.body.copyWith(
                                    fontSize: isMobile ? 12.5 : 13.5,
                                  )
                              ),
                            ),
                          ],
                        ),
                      )
                  ).toList(),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}