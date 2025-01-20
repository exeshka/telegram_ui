import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TelegramProfileAppBar extends SliverPersistentHeaderDelegate {
  final void Function() onStretch;
  final void Function() onScrollDown;
  final bool isMaxOpened;

  @override
  final double maxExtent;
  @override
  final double minExtent;

  TelegramProfileAppBar(
      {required this.onStretch,
      required this.isMaxOpened,
      required this.onScrollDown,
      required this.maxExtent,
      required this.minExtent});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Параметры для расчета анимации
    double maxScale = 1.6;
    double minScale = 0.9;

    log(shrinkOffset.toString());

    if (shrinkOffset > 0 && maxExtent > 350) {
      onScrollDown();
    }

    // Плавное изменение масштабирования
    double currentScale = maxScale - (shrinkOffset / maxExtent) * 2;
    currentScale = currentScale.clamp(minScale, maxScale);

    // Плавное изменение размера аватара
    double avatarSize = (shrinkOffset / maxExtent) * 2;
    avatarSize = avatarSize.clamp(
        0.2, 1); // Устанавливаем минимальный и максимальный размеры

    // Плавное изменение положения красного круга
    double containerBottom = 100 + (shrinkOffset / maxExtent) * 500;
    containerBottom = containerBottom.clamp(100, 150);

    // Плавное изменение положения текста
    double textBottom = 60 - (shrinkOffset / maxExtent) * 70;
    textBottom = textBottom.clamp(16, 60);

    // Прозрачность текста, который исчезает, плавно уходит в 0
    double disappearingTextOpacity =
        (1 - shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    return Stack(
      fit: StackFit.expand,
      children: [
        // Эффект размытия на фоне
        Positioned.fill(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 50,
                sigmaY: 50,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.01), // Фон для размытия
                ),
              ),
            ),
          ),
        ),

        // // Фон градиент
        Positioned.fill(
          child: Opacity(
            opacity: disappearingTextOpacity,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.deepPurple,
                Colors.purple,
              ], end: Alignment.topRight, begin: Alignment.bottomCenter)),
            ),
          ),
        ),

        // Приглушение цветов фона
        Positioned.fill(
          child: Opacity(
            opacity: disappearingTextOpacity,
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.20)),
            ),
          ),
        ),

        Positioned(
            right: 16,
            top: (minExtent - kToolbarHeight / 1.2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      color: Colors.black.withOpacity(0.01),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(32)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: Text('Изм.'),
                    ),
                  ),
                ],
              ),
            )),

        // Красный круг, движущийся вниз
        AnimatedPositioned(
          duration: Duration(milliseconds: 150),
          bottom: isMaxOpened ? 0 : containerBottom,
          left: 0,
          right: 0,
          top: isMaxOpened ? 0 : null,
          child: Opacity(
            opacity: disappearingTextOpacity,
            child: Transform.scale(
              scale: isMaxOpened ? 1 : 1 - avatarSize,
              child: Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  height: isMaxOpened ? null : 140,
                  width: isMaxOpened ? null : 140,
                  decoration: BoxDecoration(
                    borderRadius: isMaxOpened
                        ? BorderRadius.circular(0)
                        : BorderRadius.circular(80),
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Текст, который перемещается и масштабируется

        AnimatedPositioned(
          duration: Duration(milliseconds: 100),
          bottom: textBottom,
          left: 46,
          right: isMaxOpened ? null : 46,
          child: Center(
            child: Transform.scale(
              scale: currentScale,
              child: const Text(
                "exeshka",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        // Текст, который исчезает
        AnimatedPositioned(
          duration: Duration(milliseconds: 400),
          bottom: 30,
          left: 32,
          right: isMaxOpened ? null : 32,
          child: Center(
            child: Opacity(
              opacity: disappearingTextOpacity,
              child: Transform.scale(
                scale: currentScale - 0.2,
                child: Text(
                  "@exeshkaa",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration(
        onStretchTrigger: () async => onStretch(),
      );

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
