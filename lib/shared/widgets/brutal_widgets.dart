import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyspace/app/theme/keyspace_theme.dart';

// ─────────────────────────────────────────────────────────────
// BrutalCard — entrance animation + hard-shadow
// ─────────────────────────────────────────────────────────────

class BrutalCard extends StatefulWidget {
  const BrutalCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(16),
    this.color,
    this.animate = true,
    this.delay = Duration.zero,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color? color;
  final bool animate;
  final Duration delay;

  @override
  State<BrutalCard> createState() => _BrutalCardState();
}

class _BrutalCardState extends State<BrutalCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    if (widget.animate) {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ink = Theme.of(context).colorScheme.onSurface;
    final card = Padding(
      padding: const EdgeInsets.only(right: 4, bottom: 4),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.color ?? Theme.of(context).colorScheme.surface,
          border: Border.all(color: ink, width: 3),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: ink, offset: const Offset(4, 4))],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          child: Padding(padding: widget.padding, child: widget.child),
        ),
      ),
    );

    if (!widget.animate) return card;
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: card),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// BrutalButton — press physics (translate + shadow collapse)
// ─────────────────────────────────────────────────────────────

class BrutalButton extends StatefulWidget {
  const BrutalButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.secondary = false,
    this.fullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool secondary;
  final bool fullWidth;

  @override
  State<BrutalButton> createState() => _BrutalButtonState();
}

class _BrutalButtonState extends State<BrutalButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _press;
  late final Animation<Offset> _offset;
  late final Animation<double> _shadow;

  @override
  void initState() {
    super.initState();
    _press = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 120),
    );
    _offset = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(4, 4),
    ).animate(CurvedAnimation(parent: _press, curve: Curves.easeIn));
    _shadow = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _press, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _press.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    if (widget.onPressed != null) _press.forward();
  }

  void _onTapUp(TapUpDetails _) => _press.reverse();
  void _onTapCancel() => _press.reverse();

  @override
  Widget build(BuildContext context) {
    final ink = Theme.of(context).colorScheme.onSurface;
    final isDisabled = widget.onPressed == null;
    final bgColor = isDisabled
        ? Theme.of(context).colorScheme.surface
        : widget.secondary
        ? Theme.of(context).colorScheme.surface
        : KeySpaceColors.signalYellow;
    final fgColor = isDisabled ? ink.withValues(alpha: 0.35) : ink;
    final borderColor = isDisabled ? ink.withValues(alpha: 0.25) : ink;

    return Semantics(
      button: true,
      enabled: !isDisabled,
      child: AnimatedBuilder(
        animation: _press,
        builder: (context, child) {
          return Padding(
            padding: EdgeInsets.only(
              right: 4 * _shadow.value,
              bottom: 4 * _shadow.value,
            ),
            child: Transform.translate(
              offset: Offset(_offset.value.dx, _offset.value.dy),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: borderColor.withValues(alpha: _shadow.value),
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: child,
              ),
            ),
          );
        },
        child: GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: (d) {
            _onTapUp(d);
            widget.onPressed?.call();
          },
          onTapCancel: _onTapCancel,
          child: Container(
            width: widget.fullWidth ? double.infinity : null,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(color: borderColor, width: 3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: widget.fullWidth
                  ? MainAxisSize.max
                  : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, color: fgColor, size: 18),
                  const SizedBox(width: 10),
                ],
                Text(
                  widget.label,
                  style: GoogleFonts.spaceGrotesk(
                    color: fgColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// StatusBadge — pulse for healthy, shake for error
// ─────────────────────────────────────────────────────────────

class StatusBadge extends StatefulWidget {
  const StatusBadge({
    required this.label,
    required this.icon,
    required this.color,
    super.key,
    this.pulse = false,
    this.shake = false,
  });

  final String label;
  final IconData icon;
  final Color color;
  final bool pulse;
  final bool shake;

  @override
  State<StatusBadge> createState() => _StatusBadgeState();
}

class _StatusBadgeState extends State<StatusBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _shakeX;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this);

    if (widget.pulse) {
      _ctrl.duration = const Duration(milliseconds: 1800);
      _scale = TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.06), weight: 30),
        TweenSequenceItem(tween: Tween(begin: 1.06, end: 1.0), weight: 30),
        TweenSequenceItem(tween: ConstantTween(1.0), weight: 40),
      ]).animate(_ctrl);
      _shakeX = ConstantTween<double>(0.0).animate(_ctrl);
      _ctrl.repeat();
    } else if (widget.shake) {
      _ctrl.duration = const Duration(milliseconds: 500);
      _scale = ConstantTween<double>(1.0).animate(_ctrl);
      _shakeX = TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 0.0, end: -4.0), weight: 15),
        TweenSequenceItem(tween: Tween(begin: -4.0, end: 4.0), weight: 30),
        TweenSequenceItem(tween: Tween(begin: 4.0, end: -4.0), weight: 30),
        TweenSequenceItem(tween: Tween(begin: -4.0, end: 0.0), weight: 25),
      ]).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
      _ctrl.forward();
    } else {
      _ctrl.duration = const Duration(milliseconds: 1);
      _scale = ConstantTween<double>(1.0).animate(_ctrl);
      _shakeX = ConstantTween<double>(0.0).animate(_ctrl);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Status: ${widget.label}',
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) => Transform.translate(
          offset: Offset(_shakeX.value, 0),
          child: Transform.scale(scale: _scale.value, child: child),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: widget.color,
            border: Border.all(color: KeySpaceColors.ink, width: 2),
            borderRadius: BorderRadius.circular(99),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, size: 14, color: KeySpaceColors.ink),
                const SizedBox(width: 5),
                Text(
                  widget.label.toUpperCase(),
                  style: GoogleFonts.spaceGrotesk(
                    color: KeySpaceColors.ink,
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// CalorieProgressBar — animated fill + count-up number
// ─────────────────────────────────────────────────────────────

class CalorieProgressBar extends StatefulWidget {
  const CalorieProgressBar({
    required this.consumed,
    required this.target,
    super.key,
  });

  final double consumed;
  final int? target;

  @override
  State<CalorieProgressBar> createState() => _CalorieProgressBarState();
}

class _CalorieProgressBarState extends State<CalorieProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late Animation<double> _progress;
  late Animation<double> _count;
  double _prevConsumed = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _updateAnimations(from: 0);
    _ctrl.forward();
  }

  @override
  void didUpdateWidget(CalorieProgressBar old) {
    super.didUpdateWidget(old);
    if (old.consumed != widget.consumed || old.target != widget.target) {
      _prevConsumed = old.consumed;
      _ctrl.reset();
      _updateAnimations(from: _prevConsumed);
      _ctrl.forward();
    }
  }

  void _updateAnimations({required double from}) {
    final target = widget.target;
    final ratio = target == null || target <= 0
        ? 0.0
        : widget.consumed / target;
    final fromRatio = target == null || target <= 0 ? 0.0 : from / target;

    _progress = Tween<double>(
      begin: fromRatio.clamp(0.0, 1.0),
      end: ratio.clamp(0.0, 1.0),
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    _count = Tween<double>(
      begin: from,
      end: widget.consumed,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ink = Theme.of(context).colorScheme.onSurface;
    final target = widget.target;
    final semanticLabel = target == null
        ? '${widget.consumed.round()} kilokalori, target belum diatur.'
        : '${widget.consumed.round()} dari $target kilokalori.';

    return Semantics(
      label: semanticLabel,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, _) {
          final displayed = _count.value;
          final isOver = target != null && widget.consumed > target;
          final remaining = target != null
              ? (target - widget.consumed).abs().round()
              : null;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Big number display
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    displayed.round().toString(),
                    style: GoogleFonts.ibmPlexMono(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: ink,
                      height: 1.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4, left: 6),
                    child: Text(
                      target != null ? '/ $target KKAL' : 'KKAL',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: ink.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Segmented progress bar
              SizedBox(
                height: 32,
                child: Stack(
                  children: [
                    // Background track
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: ink, width: 3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    // Fill
                    FractionallySizedBox(
                      widthFactor: _progress.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: isOver
                              ? KeySpaceColors.error
                              : KeySpaceColors.signalYellow,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        margin: const EdgeInsets.all(3),
                      ),
                    ),
                    // Segment lines overlay
                    if (target != null)
                      ...List.generate(4, (i) {
                        final fraction = (i + 1) / 5;
                        return Positioned(
                          left: null,
                          right: null,
                          top: 3,
                          bottom: 3,
                          child: FractionallySizedBox(
                            widthFactor: fraction,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 2,
                                color: ink.withValues(alpha: 0.25),
                              ),
                            ),
                          ),
                        );
                      }),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                target == null
                    ? 'ATUR TARGET UNTUK MELIHAT PROGRES'
                    : isOver
                    ? '${remaining!} KKAL DI ATAS TARGET'
                    : '${remaining!} KKAL LAGI',
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  letterSpacing: 0.8,
                  color: isOver ? KeySpaceColors.error : ink,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// EmptyState — bounce entrance
// ─────────────────────────────────────────────────────────────

class EmptyState extends StatefulWidget {
  const EmptyState({
    required this.title,
    required this.message,
    super.key,
    this.action,
    this.icon = Icons.inbox_outlined,
  });

  final String title;
  final String message;
  final Widget? action;
  final IconData icon;

  @override
  State<EmptyState> createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.4,
          end: 1.1,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.1,
          end: 0.95,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.95,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
    ]).animate(_ctrl);
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BrutalCard(
      animate: false,
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _ctrl,
            builder: (context, child) => FadeTransition(
              opacity: _opacity,
              child: ScaleTransition(scale: _scale, child: child),
            ),
            child: Icon(widget.icon, size: 48),
          ),
          const SizedBox(height: 12),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(widget.message, textAlign: TextAlign.center),
          if (widget.action != null) ...[
            const SizedBox(height: 16),
            widget.action!,
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// BrutalSectionHeader — uppercase label with line
// ─────────────────────────────────────────────────────────────

class BrutalSectionHeader extends StatelessWidget {
  const BrutalSectionHeader(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    final ink = Theme.of(context).colorScheme.onSurface;
    return Row(
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.spaceGrotesk(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: ink,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Container(height: 2, color: ink)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// BrutalChip — tag chip
// ─────────────────────────────────────────────────────────────

class BrutalChip extends StatelessWidget {
  const BrutalChip({required this.label, super.key, this.color});
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ink = Theme.of(context).colorScheme.onSurface;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surface,
        border: Border.all(color: ink, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          label.toUpperCase(),
          style: GoogleFonts.spaceGrotesk(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.8,
            color: ink,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// BrutalGripHandle — drag handle for reorderable lists
// ─────────────────────────────────────────────────────────────

class BrutalGripHandle extends StatelessWidget {
  const BrutalGripHandle({super.key});

  @override
  Widget build(BuildContext context) {
    final ink = Theme.of(context).colorScheme.onSurface;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        3,
        (i) => Padding(
          padding: EdgeInsets.only(bottom: i < 2 ? 4 : 0),
          child: Container(height: 2.5, width: 22, color: ink),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// BrutalProgressIndicator — replaces CircularProgressIndicator
// ─────────────────────────────────────────────────────────────

class BrutalProgressIndicator extends StatefulWidget {
  const BrutalProgressIndicator({super.key, this.size = 32});
  final double size;

  @override
  State<BrutalProgressIndicator> createState() =>
      _BrutalProgressIndicatorState();
}

class _BrutalProgressIndicatorState extends State<BrutalProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ink = Theme.of(context).colorScheme.onSurface;
    return SizedBox.square(
      dimension: widget.size,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, _) {
          return CustomPaint(
            painter: _SquareSpinnerPainter(progress: _ctrl.value, color: ink),
          );
        },
      ),
    );
  }
}

class _SquareSpinnerPainter extends CustomPainter {
  _SquareSpinnerPainter({required this.progress, required this.color});
  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.square;

    final rect = Rect.fromLTWH(4, 4, size.width - 8, size.height - 8);
    const totalAngle = math.pi * 2;
    const sweepAngle = math.pi * 1.2;
    final startAngle = totalAngle * progress - math.pi / 2;
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(_SquareSpinnerPainter old) => old.progress != progress;
}
