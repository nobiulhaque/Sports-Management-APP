import 'package:flutter/material.dart';

class RoleTile extends StatefulWidget {
  final String label;
  final String? iconPath;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final double elevation;

  const RoleTile({
    super.key,
    required this.label,
    this.iconPath,
    this.onTap,
    this.backgroundColor = const Color(0xFFF5F7FE),
    this.elevation = 0,
  });

  @override
  State<RoleTile> createState() => _RoleTileState();
}

class _RoleTileState extends State<RoleTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Card(
        color: widget.backgroundColor,
        elevation: widget.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12),
          splashColor: Colors.blue.withOpacity(0.1),
          highlightColor: Colors.blue.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Leading Icon
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 24,
                  child: widget.iconPath != null
                      ? Image.asset(
                    widget.iconPath!,
                    width: 28,
                    height: 28,
                    fit: BoxFit.contain,
                  )
                      : Icon(
                    Icons.person_outline,
                    size: 28,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(width: 16),
                // Title
                Expanded(
                  child: Text(
                    widget.label,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A202C),
                    ),
                  ),
                ),
                // Trailing Icon
                AnimatedRotation(
                  turns: _isHovered ? 0.15 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.chevron_right,
                    color: _isHovered ? Colors.blue : Colors.grey[600],
                    size: 24,
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
