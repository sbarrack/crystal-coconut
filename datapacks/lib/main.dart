import 'package:objd/core.dart';

void main(List<String> args) {
  createProject(
    Project(
      name: "Crystal Coconut",
      target: "./",
      generate: CustomWidget(),
    ),
    args,
  );
}

class CustomWidget extends Widget {
  @override
  Widget generate(Context context) {
    return Pack(
      name: "crystal_coconut",
      main: File(
        'main',
        // every frame
        child: For.of([
          Log('Testing testaroo'),
          Command('say Testing testaroo'),
        ]),
      ),
    );
  }
}
