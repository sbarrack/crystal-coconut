import 'package:objd/core.dart';

const interval = 71; // tps - 1
const timer = "realtime_timer";
const store = "storage";
const key = "realtime";
const objective = "cc_realtime";

class RealtimeLoad extends Widget {
  @override
  generate(Context context) {
    return If(
      Data.get(DataStorage("cc:" + store), path: key),
      then: [RealtimeOn()],
      orElse: [RealtimeOff()],
    );
  }
}

class RealtimeOn extends Widget {
  @override
  generate(Context context) {
    return For.of([
      Storage.set(store, key: key, value: true),
      Score(Entity(), objective).set(1),
      Command("gamerule doDaylightCycle false"),
      Timer(timer, children: [Command("time add 1")], ticks: interval),
    ]);
  }
}

class RealtimeOff extends Widget {
  @override
  generate(Context context) {
    return For.of([
      Storage.set(store, key: key, value: false),
      Score(Entity(), objective).set(0),
      Command("gamerule doDaylightCycle true"),
      Timer.stop(timer),
    ]);
  }
}
