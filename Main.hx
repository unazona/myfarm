package;

import scene.PlayScene;
import openfl.display.Sprite;

class Main extends Sprite {
	private var play_scene:PlayScene;

	public function new() {
		super();

		play_scene = new PlayScene();
		addChild(play_scene);
	}
}
