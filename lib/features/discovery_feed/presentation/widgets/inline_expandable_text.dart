import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class InlineExpandableText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final TextStyle linkStyle;
  final int maxLines;

  const InlineExpandableText({
    super.key,
    required this.text,
    required this.style,
    required this.linkStyle,
    this.maxLines = 2,
  });

  @override
  State<InlineExpandableText> createState() => _InlineExpandableTextState();
}

class _InlineExpandableTextState extends State<InlineExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calcul virtuel pour vérifier si le texte dépasse le nombre de lignes max
        final textPainter = TextPainter(
          text: TextSpan(text: widget.text, style: widget.style),
          textDirection: TextDirection.ltr,
          maxLines: widget.maxLines,
        )..layout(maxWidth: constraints.maxWidth);

        final bool isOverflowing = textPainter.didExceedMaxLines;

        // CAS 1 : Le texte est court (ne dépasse pas) 
        if (!isOverflowing) {
          return Text(widget.text, style: widget.style);
        }

        // CAS 2 : Texte long déplié (Tout le texte + "Voir moins") sur la même ligne
        if (_isExpanded) {
          return Text.rich(
            TextSpan(
              children: [
                TextSpan(text: widget.text, style: widget.style),
                TextSpan(
                  text: '  Voir moins',
                  style: widget.linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => setState(() => _isExpanded = false),
                ),
              ],
            ),
          );
        }

        // CAS 3 : Texte long replié (Text visible + "... plus") sur la 2ème ligne
        final linkSpan = TextSpan(text: '... plus', style: widget.linkStyle);
        final linkPainter = TextPainter(
          text: linkSpan,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        // Position de coupe exacte en tenant compte de la largeur du bouton "... plus"
        final pos = textPainter.getPositionForOffset(
          Offset(constraints.maxWidth - linkPainter.width, textPainter.height),
        );
        final truncatedText = widget.text.substring(0, pos.offset.clamp(0, widget.text.length));

        return Text.rich(
          TextSpan(
            children: [
              TextSpan(text: truncatedText, style: widget.style),
              TextSpan(
                text: '... plus',
                style: widget.linkStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => setState(() => _isExpanded = true),
              ),
            ],
          ),
        );
      },
    );
  }
}