import "package:objd/core.dart";
import "package:path/path.dart" as Path;
import "dart:io" show Platform;

import "./lib/nightowl.dart";
import "./lib/soulbound.dart";

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
        File("no/sleep", child: Nightowl()),
        File("no/on", child: NightowlOn()),
        File("no/off", child: NightowlOff()),
        File("sb/on", child: SoulboundOn()),
        File("sb/off", child: SoulboundOff()),
      ],
    );
  }
}

class Load extends Widget {
  @override
  generate(Context context) {
    return For.of([
      NightowlLoad(),
      SoulboundLoad(),
    ]);
  }
}

class Main extends Widget {
  @override
  generate(Context context) {
    return For.of([
      SoulboundMain(),
    ]);
  }
}

class AllOn extends Widget {
  @override
  generate(Context context) {
    return CommandList([
      Command("function cc:no/on"),
      Command("function cc:sb/on"),
    ]);
  }
}

class AllOff extends Widget {
  @override
  generate(Context context) {
    return CommandList([
      Command("function cc:no/off"),
      Command("function cc:sb/off"),
    ]);
  }
}
