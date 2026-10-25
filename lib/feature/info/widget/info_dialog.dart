import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/widget/custom_button.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Dialog(
      constraints: BoxConstraints(maxWidth: 900),
      backgroundColor: context.colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: .circular(8)),
      child: Padding(
        padding: .all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: 8,
            children: [
              Text("Comic Compress", style: textTheme.titleLarge),
              Text("A Flutter program to compress and filter comic files."),
              Text("Developed with ❤️‍🔥 and 🚫🤖 by Lojcs."),
              Row(
                mainAxisAlignment: .center,
                children: [
                  CustomButton(
                    text: "Licenses",
                    iconSize: 20,
                    padding: .symmetric(horizontal: 12, vertical: 8),
                    borderRadius: .horizontal(left: .circular(12)),
                    onTap: () => showLicensePage(context: context),
                  ),
                  CustomButton(
                    text: "GitHub",
                    iconSize: 20,
                    padding: .symmetric(horizontal: 12, vertical: 8),
                    borderRadius: .horizontal(right: .circular(12)),
                    onTap: () async {
                      final uri = Uri.https(
                        "www.github.com",
                        "/lojcs/comic_compress",
                      );
                      if (await canLaunchUrl(uri)) await launchUrl(uri);
                    },
                  ),
                ],
              ),
              Text("Help", style: textTheme.titleMedium),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Source Folder: ",
                      style: textTheme.titleSmall,
                    ),
                    TextSpan(
                      text: "Folder to scan for .cbz and .cbr files. All its subdirectories will be scanned. Files added after the folder was scanned won't be processed.",
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Destination Folder: ",
                      style: textTheme.titleSmall,
                    ),
                    TextSpan(
                      text: "Folder to deposit the compressed files. The hierarchy of the source folder will be preserved",
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Jxl: ", style: textTheme.titleSmall),
                    TextSpan(
                      text: "Best compression ratio, poor adoption. Distance determines how similar the result is to the source. 0 is lossless and 1 is visually lossless. If the source is jpeg and distance is 0 jxl's special mode is used.",
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "WebP: ", style: textTheme.titleSmall),
                    TextSpan(
                      text: "Good compression ratio and adoption. Lossless mode is less commonly adopted.",
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Jpeg: ", style: textTheme.titleSmall),
                    TextSpan(text: "Worst compression ratio, best adoption."),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Quality: ", style: textTheme.titleSmall),
                    TextSpan(
                      text: "Higher numbers increase image quality and file size.",
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Effort: ", style: textTheme.titleSmall),
                    TextSpan(
                      text: "Higher numbers increase compression time and decrease file size.",
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Archive Filter: ",
                      style: textTheme.titleSmall,
                    ),
                    TextSpan(
                      text: "Rules to apply to the files and folders int the comic archives. Click 'Modify' for more details.",
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Normalize Archive: ",
                      style: textTheme.titleSmall,
                    ),
                    TextSpan(
                      text: "Renames all images in the comic archive to ascending numbers located at the root of the archive, preserving their alphanumeric order.",
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Thread Count: ",
                      style: textTheme.titleSmall,
                    ),
                    TextSpan(text: "Number of workers to spawn."),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Copy Non-Comic Files: ",
                      style: textTheme.titleSmall,
                    ),
                    TextSpan(
                      text: "Copies non comic files found in the source folder to the destination folder. This is performed before the start of compression.",
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Zip Effort: ", style: textTheme.titleSmall),
                    TextSpan(
                      text: "Effort for the archive zip. Higher numbers increase compression time and might decrease file size.",
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Stats: ", style: textTheme.titleSmall),
                    TextSpan(text: "Statistics for the scanned files."),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Queue: ", style: textTheme.titleSmall),
                    TextSpan(text: "Files currently being processed."),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
