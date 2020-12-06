import "package:objd/core.dart";
import "package:path/path.dart" as Path;
import "dart:io" show Platform;
import "./nightowl.dart";

void main(List<String> args) {
  var path = Platform.environment["HOME"];
  if (Platform.isWindows) {
    path = Path.join(Platform.environment["UserProfile"], "AppData\\Roaming");
  }
  path = Path.join(path, ".minecraft\\saves\\Datapack test\\datapacks\\");

  createProject(
    Project(
      name: "Crystal Coconut",
      description: "Improving UX without changing game mechanics",
      version: 16,
      target: path,
      generate: Main(),
    ),
    args,
  );
}

class Main extends Widget {
  @override
  generate(Context context) {
    return Pack(
      name: "crystal_coconut",
      load: File(
        "load",
        child: null,
      ),
      main: File(
        "main",
        child: For.of([
          Nightowl(),
        ]),
      ),
    );
  }
}
