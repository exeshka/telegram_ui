import 'package:flutter/material.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
import 'package:telegram_ui/sliver_app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: TelegramStyleAppBar(),
    );
  }
}

class TelegramStyleAppBar extends StatefulWidget {
  const TelegramStyleAppBar({super.key});

  @override
  _TelegramStyleAppBarState createState() => _TelegramStyleAppBarState();
}

class _TelegramStyleAppBarState extends State<TelegramStyleAppBar> {
  final GlobalKey _appBarKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  double expandedHeight = 300.0;
  double collapsedHeight = kToolbarHeight + 60;

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        print(_scrollController.position);
        _scrollController.position.isScrollingNotifier.addListener(
          () {
            if (!_scrollController.position.isScrollingNotifier.value) {
              _handleSnapScroll();
            }
          },
        );
      },
    );
    super.initState();
  }

  void _handleSnapScroll() async {
    double offset = _scrollController.offset;
    double snapThreshold = (expandedHeight - collapsedHeight) / 2;

    // Проверка, на какой позиции находится скролл
    if (offset < snapThreshold) {
      // Скрол до раскрытой шапки

      Future.microtask(
        () {
          _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        },
      );
    } else if (offset < expandedHeight - collapsedHeight) {
      // Скролл до свернутой шапки

      Future.microtask(
        () {
          _scrollController.animateTo(
            expandedHeight - collapsedHeight,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,

      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPersistentHeader(
            key: _appBarKey,
            pinned: true,
            delegate: TelegramProfileAppBar(
                maxExtent: expandedHeight, minExtent: collapsedHeight),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            TelegramGroupTileWidget(
              children: [
                SizedBox(
                  height: 16,
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
          ]))
        ],
      ),
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
      decoration: BoxDecoration(color: const Color.fromARGB(255, 23, 23, 23)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
