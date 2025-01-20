import 'package:flutter/material.dart';

class TelegramSettingsList extends StatelessWidget {
  const TelegramSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 16,
        ),
        TelegramGroupTileWidget(
          children: [
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            ),
          ],
        ),
        TelegramGroupTileWidget(
          children: [
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            ),
          ],
        ),
        TelegramGroupTileWidget(
          children: [
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            ),
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            ),
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            ),
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            )
          ],
        ),
        TelegramGroupTileWidget(
          children: [
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            ),
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            ),
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            ),
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            ),
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            ),
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            )
          ],
        ),
        TelegramGroupTileWidget(
          children: [
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            ),
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            ),
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            ),
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            )
          ],
        ),
        TelegramGroupTileWidget(
          children: [
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            ),
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            ),
            TelegramTileWidget(
              icon: Icon(Icons.star),
              title: 'Описание',
            )
          ],
        )
      ],
    );
  }
}

class TelegramGroupTileWidget extends StatelessWidget {
  final List<Widget> children;
  const TelegramGroupTileWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadiusDirectional.circular(12),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

class TelegramTileWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  const TelegramTileWidget(
      {super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 23, 23, 23)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
