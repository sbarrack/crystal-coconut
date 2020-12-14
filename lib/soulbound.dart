import 'package:objd/core.dart';

const store = "global";
const key = "sb";
const vars = "#cc";

Score state = Score(Entity(playerName: vars), key);

class SoulboundOn extends Widget {
  @override
  generate(Context context) {
    return If(state.matches(0), then: [
      
      SoulboundEnable(),
    ]);
  }
}

class SoulboundEnable extends Widget {
  @override
  generate(Context context) {
    return For.of([
      Storage.set(store, key: key, value: true),
      Command("gamerule keepInventory true"),

      state.set(1),
    ]);
  }
}

class SoulboundOff extends Widget {
  @override
  generate(Context context) {
    return If(state.matches(1), then: [

      SoulboundDisable(),
    ]);
  }
}

class SoulboundDisable extends Widget {
  @override
  generate(Context context) {
    return For.of([
      Storage.set(store, key: key, value: false),
      Command("gamerule keepInventory false"),

      state.set(0),
    ]);
  }
}

class SoulboundLoad extends Widget {
  @override
  generate(Context context) {
    return For.of([

      If(
        Data.get(DataStorage("cc:" + store), path: key),
        then: [SoulboundEnable()],
        orElse: [SoulboundDisable()],
      ),
    ]);
  }
}

class SoulboundMain extends Widget {
  @override
  generate(Context context) {
    return If(state.matches(1), then: [
      // TODO clear/replaceitem items that can be soulbound
    ]);
  }
}
