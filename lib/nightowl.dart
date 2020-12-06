import 'package:objd/core.dart';

class Nightowl extends Widget {
  @override
  generate(Context context) {
    return Raycast(
      Entity.Player(),
      ray: (stop, hit) {
        return For.of([
          If(Block.nbt("#minecraft:beds"), then: [
            Say("TODO offer to sleep through the day"),
          ]),
          If(Condition.not(Blocks.air), then: [ stop() ]),
          If(Condition.not(Entity.Self(distance: Range(0, 4))), then: [ stop() ]),
        ]);
      },
    );
  }
}
