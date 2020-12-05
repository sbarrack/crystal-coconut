import 'package:objd/core.dart';
import 'package:path/path.dart' as Path;
import 'dart:io' show Platform, Directory;

void main(List<String> args) {
  var path = Platform.environment['HOME'];
  if (Platform.isWindows) {
    path = Path.join(Platform.environment['UserProfile'], 'AppData\\Roaming');
  }
  path = Path.join(path, '.minecraft\\saves\\Datapack test\\datapacks\\');
  print(path);
  if (Directory(path).existsSync()) {
    print('true');
  } else {
    print('false');
  }

  createProject(
    Project(
      name: "Crystal Coconut",
      description: "Improving UX without changing game mechanics",
      version: 16,
      target: path,
      generate: MainWidget(),
    ),
    args,
  );
}

class MainWidget extends Widget {
  @override
  Widget generate(Context context) {
    return Pack(
      name: "crystal_coconut",
      main: File(
        'main',
        child: For.of([
          Log('Testing testaroo'),
          Command('say Testing testaroo'),
        ]),
      ),
    );
  }
}
