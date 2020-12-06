import 'package:objd/core.dart';

class NightowlMain extends Widget {
  @override
  generate(Context context) {
    return Raycast(
      Entity.All(),
      ray: (stop, hit) {
        return For.of([
          If(Condition.not(Scoreboard("cc_no_sleep")[Entity.Self()].matches(0)), then: [
            Score.fromSelected("cc_no_sleep").subtract(1),
            stop(),
          ]),
          If(Condition.not(Scoreboard("cc_no_query")[Entity.Self()].matches(0)), then: [
            Score.fromSelected("cc_no_query").subtract(1),
            stop(),
          ]),
          If(Block.nbt("#minecraft:beds"), then: [
            Score.fromSelected("cc_no_query").set(300),
            // Scoreboard.setdisplay("cc_no_query"), // debug
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
          ]),
          If(Condition.not(Blocks.air), then: [stop()]),
          If(Condition.not(Entity.Self(distance: Range(0, 4))), then: [stop()]),
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
        Scoreboard("cc_no_sleep")[Entity.Self()].matches(0),
        Condition.not(Scoreboard("cc_no_query")[Entity.Self()].matches(0)),
      ]),
      then: [
        Score(Entity.All(), "cc_no_query").set(0),
        Score(Entity.All(), "cc_no_sleep").set(12000),
        // Scoreboard.setdisplay("cc_no_sleep"), // debug
        Command("time set night"),
      ],
      orElse: [
        Tellraw(
          Entity.Self(),
          show: [
            TextComponent(
              "You are not at a bed or 10 minutes (12 game hours) have not passed!",
              color: Color.Red,
            )
          ],
        ),
      ],
    );
  }
}
