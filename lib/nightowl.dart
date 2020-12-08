import 'package:objd/core.dart';

const queryTimeout = 200;
const queryObjective = "cc_no_query";
const sleepTimeout = 12000;
const sleepTimeoutRealtime = 12000 * 72;
const sleepObjective = "cc_no_sleep";

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
          ],
          orElse: [
            If(Condition.not(Scoreboard(queryObjective)[Entity.Self()].matches(0)), then: [
              Score.fromSelected(queryObjective).subtract(1),
              stop(),
            ],
            orElse: [
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
                      clickEvent: TextClickEvent.run_command(Command("function cc:nightowl")),
                    ),
                    TextComponent(
                      " (click)",
                      color: Color.Gray,
                    ),
                  ],
                ),
                stop(),
              ],
              orElse: [
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
        If(Scoreboard("cc_realtime")[Entity.Self()].matches(1),
          then: [Score(Entity.All(), sleepObjective).set(sleepTimeoutRealtime)],
          orElse: [Score(Entity.All(), sleepObjective).set(sleepTimeout)],
        ),
        // Scoreboard.setdisplay(sleepObjective), // debug
        Command("time set night"),
      ],
      orElse: [
        Tellraw(
          Entity.Self(),
          show: [
            TextComponent(
              "You are not at a bed or 10 minutes (12 hours with realtime enabled) have not passed!",
              color: Color.Red,
            )
          ],
        ),
      ],
    );
  }
}
