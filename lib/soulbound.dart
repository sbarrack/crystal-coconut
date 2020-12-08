import 'package:objd/core.dart';

const timer = "soulbound_timer";
const store = "storage";
const key = "soulbound";
const objective = "cc_soulbound";

class Soulbound extends Widget {
  @override
  generate(Context context) {
    return;
  }
}
class SoulboundMain extends Widget {
  @override
  generate(Context context) {
    return Entity.All().forEach((player, strait) => {
      
    });
  }
}

class SoulboundLoad extends Widget {
  @override
  generate(Context context) {
    return If(
      Data.get(DataStorage("cc:" + store), path: key),
      then: [SoulboundOn()],
      orElse: [SoulboundOff()],
    );
  }
}

class SoulboundOn extends Widget {
  @override
  generate(Context context) {
    return For.of([
      Storage.set(store, key: key, value: true),
      Score(Entity(), objective).set(1),
      Command("gamerule keepInventory true"),
      Timer(timer, children: [SoulboundMain()], ticks: 0),
    ]);
  }
}

class SoulboundOff extends Widget {
  @override
  generate(Context context) {
    return For.of([
      Storage.set(store, key: key, value: false),
      Score(Entity(), objective).set(0),
      Command("gamerule keepInventory false"),
      Timer.stop(timer),
    ]);
  }
}
