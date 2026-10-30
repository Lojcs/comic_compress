import 'package:comic_compress/core/state/theme_mode.dart';
import 'package:comic_compress/feature/home/widget/home_screen.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';

import 'feature/dependency_check/state/dependency_check_cubit.dart';
import 'feature/dependency_check/widget/dependency_fail_screen.dart';
import 'feature/home/state/home_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  Future.microtask(() async {
    await windowManager.setSize(
      HomeScreen.size(ImageSettings.blank(), .initial),
    );
    await windowManager.setMinimumSize(HomeScreen.minSize);
    // await windowManager.setMaximumSize(HomeScreen.maxSize);
  });
  final color = await DynamicColorPlugin.getAccentColor();
  final dependencies = DependencyCheckCubit();
  final depsSatisfied = await dependencies.check();
  runApp(
    MyApp(
      color: color ?? Colors.deepOrange,
      home: depsSatisfied
          ? HomeScreen()
          : DependencyFailScreen(cubit: dependencies),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Color color;
  final Widget home;
  const new({super.key, required this.color, required this.home});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeModeCubit(),
      child: BlocBuilder<ThemeModeCubit, ThemeMode>(
        builder: (context, state) => MaterialApp(
          title: 'Transcript Checker',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorScheme: .fromSeed(seedColor: color)),
          darkTheme: ThemeData(
            colorScheme: .fromSeed(
              seedColor: color,
              brightness: .dark,
            ).copyWith(),
          ),
          // themeMode: state,
          home: home,
        ),
      ),
    );
  }
}
