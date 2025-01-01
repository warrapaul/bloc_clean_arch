import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post_tag.dart';
import 'package:flutter/material.dart';

class DummyPostTagsScrollView extends StatefulWidget {
  final List<DummyPostTag> tags;
  final Function(DummyPostTag) onTagSelected;
  final int selectedIndex;

  const DummyPostTagsScrollView({
    super.key,
    required this.tags,
    required this.onTagSelected,
    required this.selectedIndex,
  });

  @override
  State<DummyPostTagsScrollView> createState() =>
      _DummyPostTagsScrollViewState();
}

class _DummyPostTagsScrollViewState extends State<DummyPostTagsScrollView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.tags.length,
        itemBuilder: (context, index) {
          final tag = widget.tags[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              selected: widget.selectedIndex == index,
              label: Text(tag.name),
              onSelected: (_) => widget.onTagSelected(tag),
            ),
          );
        },
      ),
    );
  }
}
