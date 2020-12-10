import "package:objd/core.dart";
import "package:path/path.dart" as Path;
import "dart:io" show Platform;

import "./lib/realtime.dart";
import "./lib/nightowl.dart";

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
      generate: Index(),
    ),
    args,
  );
}

class Index extends Widget {
  @override
  generate(Context context) {
    return Pack(
      name: "cc",
      load: File(
        "load",
        child: Load(),
      ),
      main: File(
        "main",
        child: Main(),
      ),
      files: [
        File("on", child: AllOn()),
        File("off", child: AllOff()),
        File("rt/on", child: RealtimeOn()),
        File("rt/off", child: RealtimeOff()),
        File("no/sleep", child: Nightowl()),
        File("no/on", child: NightowlOn()),
        File("no/off", child: NightowlOff()),
      ],
    );
  }
}

class Load extends Widget {
  @override
  generate(Context context) {
    return For.of([
      RealtimeLoad(),
      NightowlLoad(),
    ]);
  }
}

class Main extends Widget {
  @override
  generate(Context context) {
    return;
  }
}

class AllOn extends Widget {
  @override
  generate(Context context) {
    return CommandList([
      Command("function cc:rt/on"),
      Command("function cc:no/on"),
    ]);
  }
}

class AllOff extends Widget {
  @override
  generate(Context context) {
    return CommandList([
      Command("function cc:rt/off"),
      Command("function cc:no/off"),
    ]);
  }
}
