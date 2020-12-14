import 'package:objd/core.dart';

const timer = "no_timer";
const store = "global";
const key = "no";
const vars = "#cc";

const queryObjective = "cc_no_query";
const sleepObjective = "cc_no_sleep";
const interval = 19; // tps - 1
var queryTimeout = 9; // secs
var sleepTimeout = 12000 ~/ (interval + 1); // one night
Score state = Score(Entity(playerName: vars), key);
Score zero = Score(Entity(playerName: vars), "zero");

class NightowlOn extends Widget {
  @override
  generate(Context context) {
    return If(state.matches(0), then: [
      NightowlEnable(),
    ]);
  }
}

class NightowlEnable extends Widget {
  @override
  generate(Context context) {
    return For.of([
      Storage.set(store, key: key, value: true),
      Timer(timer, children: [NightowlMain()], ticks: interval),
      state.set(1),
    ]);
  }
}

class NightowlOff extends Widget {
  @override
  generate(Context context) {
    return If(state.matches(1), then: [
      NightowlDisable(),
    ]);
  }
}

class NightowlDisable extends Widget {
  @override
  generate(Context context) {
    return For.of([
      Storage.set(store, key: key, value: false),
      Timer.stop(timer),
      state.set(0),
    ]);
  }
}

class NightowlLoad extends Widget {
  @override
  generate(Context context) {
    return For.of([
      zero.set(0),
      If(
        Data.get(DataStorage("cc:" + store), path: key),
        then: [NightowlEnable()],
        orElse: [NightowlDisable()],
      ),
    ]);
  }
}

class NightowlMain extends Widget {
  @override
  generate(Context context) {
    return Raycast(
      Entity.All(),
      ray: (stop, hit) {
        return For.of([
          If(Scoreboard(sleepObjective)[Entity.Self()].isBigger(zero), then: [
            Score.fromSelected(sleepObjective).subtract(1),
            stop(),
          ], orElse: [
            If(Scoreboard(queryObjective)[Entity.Self()].isBigger(zero), then: [
              Score.fromSelected(queryObjective).subtract(1),
              stop(),
            ], orElse: [
              If(Block.nbt("#minecraft:beds"), then: [
                Score.fromSelected(queryObjective).set(queryTimeout),
                // Scoreboard.setdisplay(queryObjective), // debug
                Tellraw(
                  Entity.Self(),
                  show: [
                    TextComponent(
                      "Sleep until nightfall?",
                      color: Color.Aqua,
                      hoverEvent: TextHoverEvent.text([
                        TextComponent(
                          "Click to hit the sack...",
                          color: Color.Gray,
                        ),
                      ]),
                      clickEvent: TextClickEvent.run_command(Command("function cc:no/sleep")),
                    ),
                    TextComponent(
                      " (click)",
                      color: Color.Gray,
                    ),
                  ],
                ),
                stop(),
              ], orElse: [
                If(
                  Condition.not(Condition.or([
                    Blocks.air,
                    Entity.Self(distance: Range(0, 4)),
                  ])),
                  then: [stop()],
                ),
              ]),
            ]),
          ]),
        ]);
      },
    );
  }
}

class Nightowl extends Widget {
  @override
  generate(Context context) {
    return If(
      Condition.and([
        Scoreboard(sleepObjective)[Entity.Self()].isSmallerOrEqual(zero),
        Scoreboard(queryObjective)[Entity.Self()].isBigger(zero),
      ]),
      then: [
        Score(Entity.All(), queryObjective).set(1),
        Score(Entity.All(), sleepObjective).set(sleepTimeout),
        // Scoreboard.setdisplay(sleepObjective), // debug
        Command("time set 12000"),
        Particle(
          Particles.poof,
          location: Location.here(),
          delta: Location.glob(x: 2, y: 1, z: 2),
          speed: 0.5,
          count: 50,
        ),
        Execute.asat(Entity.Self(), children: [Command("playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 0.2")]),
      ],
      orElse: [
        Tellraw(
          Entity.Self(),
          show: [
            TextComponent(
              "You are not at a bed or 10 minutes (12 hours with realtime on) have not passed!",
              color: Color.Red,
            )
          ],
        ),
      ],
    );
  }
}
