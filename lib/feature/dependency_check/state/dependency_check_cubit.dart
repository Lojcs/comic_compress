import '../../../core/state/mubit.dart';
import '../../../core/util/processr.dart';
import 'dependency_check_data.dart';

class DependencyCheckCubit extends Mubit<DependencyCheckData> {
  new() : super(.blank());

  Future<bool> check() async {
    emit(
      DependencyCheckData(
        cjxlAvailable: await _checkCxjl(),
        cwebpAvailable: await _checkCwebp(),
        exiftoolAvailable: await _checkExiftool(),
      ),
    );
    return state.verdict;
  }

  Future<bool> _checkCxjl() async {
    final result = await Processr.run("command", [
      "-v",
      "cjxl",
    ], runInShell: true);
    return result.exitCode == 0;
  }

  Future<bool> _checkCwebp() async {
    final result = await Processr.run("command", [
      "-v",
      "cwebp",
    ], runInShell: true);
    return result.exitCode == 0;
  }

  Future<bool> _checkExiftool() async {
    final result = await Processr.run("command", [
      "-v",
      "exiftool",
    ], runInShell: true);
    return result.exitCode == 0;
  }
}
