import 'package:flutter/material.dart';
import 'package:keyspace/app/theme/keyspace_theme.dart';

class BrutalCard extends StatelessWidget {
  const BrutalCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(16),
    this.color,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ink = Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.only(right: 4, bottom: 4),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.surface,
          border: Border.all(color: ink, width: 3),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: ink, offset: const Offset(4, 4))],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

class BrutalButton extends StatelessWidget {
  const BrutalButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.secondary = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool secondary;

  @override
  Widget build(BuildContext context) {
    final ink = Theme.of(context).colorScheme.onSurface;
    final button = secondary
        ? OutlinedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon ?? Icons.arrow_forward),
            label: Text(label),
            style: OutlinedButton.styleFrom(
              foregroundColor: ink,
              backgroundColor: Theme.of(context).colorScheme.surface,
              side: BorderSide(color: ink, width: 3),
              minimumSize: const Size(48, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )
        : FilledButton.icon(
            onPressed: onPressed,
            icon: Icon(icon ?? Icons.arrow_forward),
            label: Text(label),
          );
    return Semantics(button: true, child: button);
  }
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.label,
    required this.icon,
    required this.color,
    super.key,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Status: $label',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: KeySpaceColors.ink, width: 2),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: KeySpaceColors.ink),
              const SizedBox(width: 6),
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  color: KeySpaceColors.ink,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalorieProgressBar extends StatelessWidget {
  const CalorieProgressBar({
    required this.consumed,
    required this.target,
    super.key,
  });

  final double consumed;
  final int? target;

  @override
  Widget build(BuildContext context) {
    final ratio = target == null || target! <= 0 ? 0.0 : consumed / target!;
    final clamped = ratio.clamp(0.0, 1.0);
    final label = target == null
        ? '${consumed.round()} kilokalori, target belum diatur.'
        : '${consumed.round()} dari $target kilokalori.';
    return Semantics(
      label: label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            target == null
                ? '${consumed.round()} KKAL'
                : '${consumed.round()} / $target KKAL',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.onSurface,
                width: 3,
              ),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: clamped,
              child: const ColoredBox(color: KeySpaceColors.signalYellow),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            target == null
                ? 'ATUR TARGET UNTUK MELIHAT PROGRES'
                : consumed <= target!
                ? '${(target! - consumed).round()} KKAL LAGI'
                : '${(consumed - target!).round()} KKAL DI ATAS TARGET',
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.title,
    required this.message,
    super.key,
    this.action,
  });

  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return BrutalCard(
      child: Column(
        children: [
          const Icon(Icons.inbox_outlined, size: 42),
          const SizedBox(height: 10),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(message, textAlign: TextAlign.center),
          if (action != null) ...[const SizedBox(height: 12), action!],
        ],
      ),
    );
  }
}
