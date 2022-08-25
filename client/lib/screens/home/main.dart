import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget home(context) {
  return CustomScrollView(
    slivers: <Widget>[
      SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                    onTap: () {},
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(45.0),
                              child: const Image(
                                image:
                                    AssetImage('assets/floppa_pictures/1.jpg'),
                                width: 60,
                                height: 60,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Maxime',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.swap_horiz,
                                      size: 20,
                                      color: Colors.blueGrey,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .switch_account,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Colors.blueGrey),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
              childCount: 1)),
      SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                    children: [
                      ListTile(
                        title: Text(AppLocalizations.of(context).your_music),
                        trailing: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.shuffle),
                            label: Text(
                                AppLocalizations.of(context).shuffle_play)),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.favorite_border_outlined),
                                    label: Text(AppLocalizations.of(context)
                                        .liked_songs)),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.history),
                                    label: Text(
                                        AppLocalizations.of(context).history)),
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.trending_up),
                                    label: Text(AppLocalizations.of(context)
                                        .top_listened)),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.import_export),
                                    label: Text(
                                        AppLocalizations.of(context).import)),
                              ),
                            ],
                          )),
                    ],
                  ),
              childCount: 1))
    ],
  );
}
