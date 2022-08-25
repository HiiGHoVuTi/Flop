import 'package:flutter/material.dart';

Widget bibli(context) {
  return ListView.separated(
    padding: const EdgeInsets.all(8),
    itemCount: 20,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        onTap: () {},
        leading: const FlutterLogo(size: 50),
        title: const Text('Titres likés'),
        subtitle: const Text('Playlist'),
      );
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(
      indent: 8,
      endIndent: 8,
    ),
  );
}
