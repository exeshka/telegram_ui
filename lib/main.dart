import 'package:flutter/material.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
import 'package:telegram_ui/sliver_app_bar.dart';
import 'package:telegram_ui/telegram_body.dart';

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
      home: const TelegramStyleAppBar(),
    );
  }
}

class TelegramStyleAppBar extends StatefulWidget {
  const TelegramStyleAppBar({super.key});

  @override
  _TelegramStyleAppBarState createState() => _TelegramStyleAppBarState();
}

class _TelegramStyleAppBarState extends State<TelegramStyleAppBar>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;

  static const double kBaseHeight = kToolbarHeight;
  static const double expandedHeight = kBaseHeight + 300.0;
  static const double expandedMaxHeight = kBaseHeight + 450.0;
  static const double collapsedHeight = kBaseHeight + 60.0;

  bool isMaxHeight = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Более плавная анимация
    );

    _sizeAnimation = Tween<double>(
      begin: expandedHeight,
      end: expandedMaxHeight,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.position.isScrollingNotifier.addListener(_onScrollEnd);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScrollEnd() {
    if (!_scrollController.position.isScrollingNotifier.value) {
      _handleSnapScroll();
    }
  }

  void _handleSnapScroll() {
    double offset = _scrollController.offset;

    double snapThreshold = (_sizeAnimation.value - collapsedHeight) / 2;

    if (offset < snapThreshold) {
      _animateScrollTo(0.0); // Раскрыть шапку
    } else {
      _animateScrollTo(expandedHeight - collapsedHeight); // Свернуть шапку
    }
  }

  void _animateScrollTo(double offset) {
    Future.microtask(
      () {
        _scrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  void _updateAppBarHeight({required bool stretch}) {
    if (isMaxHeight == stretch)
      return; // Если состояние не меняется, ничего не делать.

    isMaxHeight = stretch;

    if (stretch) {
      _animationController.forward(); // Увеличение высоты
    } else {
      _animationController.reverse(); // Уменьшение высоты
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          AnimatedBuilder(
            animation: _sizeAnimation,
            builder: (context, child) {
              return SliverPersistentHeader(
                pinned: true,
                delegate: TelegramProfileAppBar(
                  isMaxOpened: isMaxHeight,
                  onScrollDown: () => _updateAppBarHeight(stretch: false),
                  onStretch: () => _updateAppBarHeight(stretch: true),
                  maxExtent: _sizeAnimation.value,
                  minExtent: collapsedHeight,
                ),
              );
            },
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const TelegramSettingsList(),
            ]),
          ),
        ],
      ),
    );
  }
}
