import 'package:objd/core.dart';

const interval = 71; // (irl ticks (1/20th of a second) per tick) - 1
const timer = "rt_timer";
const store = "global";
const key = "rt";
const vars = "#cc";

Score state = Score(Entity(playerName: vars), key);
Score realtimeRatio = Score(Entity(playerName: vars), "rt_ratio");
Score sleep = Score(Entity.All(), "cc_no_sleep");

class RealtimeOn extends Widget {
  @override
  generate(Context context) {
    return If(state.matches(0), then: [
      sleep.multiplyByScore(realtimeRatio),

      RealtimeEnable(),
    ]);
  }
}

class RealtimeEnable extends Widget {
  @override
  generate(Context context) {
    return For.of([
      Storage.set(store, key: key, value: true),
      Command("gamerule doDaylightCycle false"),
      Timer(timer, children: [Command("time add 1")], ticks: interval),
      state.set(1),
    ]);
  }
}

class RealtimeOff extends Widget {
  @override
  generate(Context context) {
    return If(state.matches(1), then: [
      sleep.divideByScore(realtimeRatio),
      
      RealtimeDisable(),
    ]);
  }
}

class RealtimeDisable extends Widget {
  @override
  generate(Context context) {
    return For.of([
      Storage.set(store, key: key, value: false),
      Command("gamerule doDaylightCycle true"),
      Timer.stop(timer),
      state.set(0),
    ]);
  }
}

class RealtimeLoad extends Widget {
  @override
  generate(Context context) {
    return For.of([
      realtimeRatio.set(72),
      If(
        Data.get(DataStorage("cc:" + store), path: key),
        then: [RealtimeEnable()],
        orElse: [RealtimeDisable()],
      ),
    ]);
  }
}
