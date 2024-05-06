import 'dart:developer';

import 'package:flutter/material.dart';

class ComplaintsSearchBar extends StatefulWidget {
  const ComplaintsSearchBar({
    super.key,
  });

  @override
  State<ComplaintsSearchBar> createState() => _ComplaintsSearchBarState();
}

class _ComplaintsSearchBarState extends State<ComplaintsSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: "Buscar denuncias",
      leading: const Icon(Icons.search),
      trailing: <Widget>[
        Tooltip(
          message: "Filtrar denuncias",
          child: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              log("Menú presionado");
            },
          ),
        )
      ],
    );
  }
}
