import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/function_extension.dart';
import '../../../core/widget/custom_button.dart';
import '../../../core/widget/recursive_mubit_widget.dart';
import '../../info/widget/info_dialog.dart';
import '../state/dependency_check_cubit.dart';
import '../state/dependency_check_data.dart';
import 'dependency_info.dart';

class DependencyFailScreen
    extends ProvidingWidget<DependencyCheckCubit, DependencyCheckData> {
  const DependencyFailScreen({super.key, required super.cubit});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size(double.infinity, 48),
        //   child: Center(
        //     child: Text("Comic Compress", style: context.textTheme.titleLarge),
        //   ),
        // ),
        // appBar: AppBar(centerTitle: true, title: Text("Comic Compress")),
        body: Padding(
          padding: .all(12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              spacing: 8,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text("Comic Compress", style: textTheme.titleLarge),
                    CustomButton(
                      text: "Info",
                      iconSize: 20,
                      padding: .symmetric(horizontal: 12, vertical: 8),
                      borderRadius: .circular(12),
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => BlocProvider.value(
                          value: cubit,
                          child: InfoDialog(),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Dependency check failed.",
                  style: textTheme.titleMedium!.copyWith(
                    color: context.colorScheme.tertiary,
                  ),
                ),
                Text(
                  "Please ensure these commands are reachable and restart Comic Compress.",
                  style: textTheme.bodyMedium,
                ),
                CjxlInfo(),
                CwebpInfo(),
                ExiftoolInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
