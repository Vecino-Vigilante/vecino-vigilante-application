import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final String placeholder;

  const CustomSearchBar({
    super.key,
    required this.onSearch,
    required this.placeholder,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: widget.placeholder,
      controller: _controller,
      leading: const Icon(Icons.search),
      onChanged: widget.onSearch,
    );
  }
}
