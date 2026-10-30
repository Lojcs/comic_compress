import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'dependency_check_data.g.dart';

@CopyWith()
class DependencyCheckData with Equatable {
  final bool cjxlAvailable;
  final bool cwebpAvailable;
  final bool exiftoolAvailable;
  const new({
    required this.cjxlAvailable,
    required this.cwebpAvailable,
    required this.exiftoolAvailable,
  });
  const new blank()
    : cjxlAvailable = false,
      cwebpAvailable = false,
      exiftoolAvailable = false;

  bool get verdict => cjxlAvailable && cwebpAvailable && exiftoolAvailable;
  @override
  List<Object?> get props => [cjxlAvailable, cwebpAvailable, exiftoolAvailable];
}
