import 'package:objd/core.dart';

const timer = "nightowl_timer";
const store = "storage";
const key = "nightowl";
const objective = "cc_nightowl";

const interval = 19; // tps - 1
var queryTimeout = (200 / interval).floor();
var sleepTimeout = (12000 / interval).floor();
const queryObjective = "cc_no_query";
const sleepObjective = "cc_no_sleep";
var sleepTimeoutRealtime = (sleepTimeout * 72 / interval).floor();

class NightowlMain extends Widget {
  @override
  generate(Context context) {
    return Raycast(
      Entity.All(),
      ray: (stop, hit) {
        return For.of([
          If(Condition.not(Scoreboard(sleepObjective)[Entity.Self()].matches(0)), then: [
            Score.fromSelected(sleepObjective).subtract(1),
            stop(),
          ], orElse: [
            If(Condition.not(Scoreboard(queryObjective)[Entity.Self()].matches(0)), then: [
              Score.fromSelected(queryObjective).subtract(1),
              stop(),
            ], orElse: [
              If(Block.nbt("#minecraft:beds"), then: [
                Score.fromSelected(queryObjective).set(queryTimeout),
                Scoreboard.setdisplay(queryObjective), // debug
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
                      clickEvent: TextClickEvent.run_command(Command("function cc:nightowl")),
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
        Scoreboard(sleepObjective)[Entity.Self()].matches(0),
        Condition.not(Scoreboard(queryObjective)[Entity.Self()].matches(0)),
      ]),
      then: [
        Score(Entity.All(), queryObjective).set(queryTimeout),
        If(
          Scoreboard("cc_realtime")[Entity.Self()].matches(1),
          then: [Score(Entity.All(), sleepObjective).set(sleepTimeoutRealtime)],
          orElse: [Score(Entity.All(), sleepObjective).set(sleepTimeout)],
        ),
        Scoreboard.setdisplay(sleepObjective), // debug
        Command("time set night"),
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

class NightowlLoad extends Widget {
  @override
  generate(Context context) {
    return If(
      Data.get(DataStorage("cc:" + store), path: key),
      then: [NightowlOn()],
      orElse: [NightowlOff()],
    );
  }
}

class NightowlOn extends Widget {
  @override
  generate(Context context) {
    return For.of([
      Storage.set(store, key: key, value: true),
      Score(Entity(), objective).set(1),
      Timer(timer, children: [NightowlMain()], ticks: interval),
    ]);
  }
}

class NightowlOff extends Widget {
  @override
  generate(Context context) {
    return For.of([
      Storage.set(store, key: key, value: false),
      Score(Entity(), objective).set(0),
      Timer.stop(timer),
    ]);
  }
}
