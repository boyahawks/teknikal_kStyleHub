part of "./widget.dart";

class ExpandedView2Row extends StatelessWidget {
  // TITLE
  final int? flexLeft;
  final int? flexRight;
  final Widget? widgetLeft;
  final Widget? widgetRight;

  const ExpandedView2Row({
    Key? key,
    required this.flexLeft,
    required this.flexRight,
    required this.widgetLeft,
    required this.widgetRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: flexLeft!,
            child: widgetLeft!,
          ),
          Expanded(
            flex: flexRight!,
            child: widgetRight!,
          )
        ],
      ),
    );
  }
}
