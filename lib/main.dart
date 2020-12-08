import "package:objd/core.dart";
import "package:path/path.dart" as Path;
import "dart:io" show Platform;
import "./nightowl.dart";
import "./realtime.dart";
import "./soulbound.dart";

const mcVer = 16;

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
      version: mcVer,
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
          ServerVersionCheck(
            minVersion: mcVer,
            versionTooLow: [Log(
              "[ Crystal Coconut ]: Your Minecraft version is out of date!"
              " Please use 1.$mcVer or greater. Failure to comply will result"
              " in unexpected behavior which will not be supported by the"
              " developer of this datapack."
            )],
          ),
          NightowlLoad(),
          RealtimeLoad(),
          SoulboundLoad(),
        ]),
      ),
      files: [
        // custom commands
        File("nightowl", child: Nightowl()),
        File("nightowl_on", child: NightowlOn()),
        File("nightowl_off", child: NightowlOff()),
        File("realtime_on", child: RealtimeOn()),
        File("realtime_off", child: RealtimeOff()),
        File("soulbound_on", child: SoulboundOn()),
        File("soulbound_off", child: SoulboundOff()),
      ],
    );
  }
}
