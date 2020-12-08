import "package:objd/core.dart";
import "package:path/path.dart" as Path;
import "dart:io" show Platform;
import "./nightowl.dart";
import "./realtime.dart";
import "./soulbound.dart";

void main(List<String> args) {
  var path = Platform.environment["HOME"];
  if (Platform.isWindows) {
    path = Path.join(Platform.environment["UserProfile"], "AppData\\Roaming");
  }
  path = Path.join(path, ".minecraft\\saves\\Datapack test\\datapacks\\");

  createProject(
    Project(
      name: "Crystal Coconut",
      description: "Same mechanics, improved UX\nby SteveTheMCKing",
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
      name: "cc",
      load: File(
        "load",
        child: For.of([
          RealtimeLoad(),
        ]),
      ),
      main: File(
        "main",
        child: For.of([
          NightowlMain(),
        ]),
      ),
      files: [
        File("nightowl", child: Nightowl()),
        File("realtime_on", child: RealtimeOn()),
        File("realtime_off", child: RealtimeOff()),
        File("soulbound", child: Soulbound()),
      ],
    );
  }
}
