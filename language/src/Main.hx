import pixi.plugins.app.Application;
import js.Browser;
import editor.gui.CursorSelector;
import editor.gui.ScaleSelector;

class Main extends Application {

	public function new() {
		super();

		backgroundColor = 0xe1e1e1;
		width = Browser.window.innerWidth;
		height = Browser.window.innerHeight;
		position = "fixed";
		antialias = true;

		super.start(null, Browser.document.body);

		var cursorSelector = new CursorSelector(function() {}, function(){}, function(){});
		cursorSelector.position.x = 10;
		cursorSelector.position.y = 10;

		stage.addChild(cursorSelector);

		var scaleSelector = new ScaleSelector(function() {}, function() {});
		scaleSelector.position.x = 10;
		scaleSelector.position.y = height - 45;
		stage.addChild(scaleSelector);
	}

	static function main() {
		new Main();
	}
}