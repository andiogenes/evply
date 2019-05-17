import pixi.plugins.app.Application;
import js.Browser;
import editor.gui.CursorSelector;
import editor.gui.ScaleSelector;
import editor.workspace.Workspace;
import pixi.core.display.Container;
import pixi.core.math.shapes.Rectangle;
import pixi.interaction.InteractionEvent;
import pixi.core.math.Point;
import pixi.interaction.InteractionData;

enum PointerBehaviourType {
	Select;
	Zoom;
	Move;
}

class Main extends Application {

	var pointerState: PointerBehaviourType;
	var dragStart: Point;
	var dragEnd: Point;
	var dragData: InteractionData;
	var wsPosBuffer: Point;
	var workspace: Workspace;
	var isDragging: Bool;

	public function new() {
		super();

		Browser.document.body.addEventListener("contextmenu", function(e) {
			if (e.button == 2) {
				e.preventDefault();
			}
		});

		backgroundColor = 0xe1e1e1;
		width = Browser.window.innerWidth;
		height = Browser.window.innerHeight;
		position = "fixed";
		antialias = true;

		super.start(null, Browser.document.body);

		pointerState = Select;
		isDragging = false;

		// Рабочее пространство
		workspace = new Workspace();
		wsPosBuffer = new Point(workspace.position.x, workspace.position.y);
		stage.addChild(workspace);

		// Промежуточный слой для d'n'd и зума
		var screenTransformLayer = new Container();

		screenTransformLayer.hitArea = new Rectangle(0, 0, width, height);
		screenTransformLayer.interactive = true;
		screenTransformLayer.visible = false;

		screenTransformLayer.on("pointerdown", onDragStart);
		screenTransformLayer.on("pointerup", onDragEnd);
		screenTransformLayer.on("pointermove", onDragMove);
		stage.addChild(screenTransformLayer);

		// Меню выбора поведения курсора
		var cursorSelector = new CursorSelector(
			function() { pointerState = Select; screenTransformLayer.visible = false; setCursor(Select); }, 
			function() { pointerState = Zoom; screenTransformLayer.visible = true; setCursor(Zoom); }, 
			function() { pointerState = Move; screenTransformLayer.visible = true; setCursor(Move); } );


		cursorSelector.position.x = 10;
		cursorSelector.position.y = 10;

		stage.addChild(cursorSelector);

		// Меню zoom-in / zoom-out
		var scaleSelector = new ScaleSelector(
			function() workspace.zoom(-0.1), 
			function() workspace.zoom(0.1));

		scaleSelector.position.x = 10;
		scaleSelector.position.y = height - 45;

		stage.addChild(scaleSelector);
	}

	function setCursor(type: PointerBehaviourType) {
		Browser.document.body.style.cursor = switch (type) {
			case Select:
				"default";
			case Move:
				"grab";
			case Zoom:
				"zoom-in";
		}
	}

	function onDragStart(event: InteractionEvent) {
		switch (pointerState) {
			case Select:

			case Zoom:
				var button = cast(untyped __js__("event.data.originalEvent.button"), Int);
				if (button == 0) {
					workspace.zoom(0.1);
				} else if (button == 2) {
					workspace.zoom(-0.1);
				}
			case Move:
				dragStart = event.data.getLocalPosition(stage);
				dragData = event.data;
				isDragging = true;
				wsPosBuffer.x = workspace.position.x;
				wsPosBuffer.y = workspace.position.y;
		}
	}

	function onDragMove() {
		if (pointerState == Move && isDragging) {
			dragEnd = dragData.getLocalPosition(stage);
			dragEnd.x = dragEnd.x - dragStart.x;
			dragEnd.y = dragEnd.y - dragStart.y;
			workspace.position.x = wsPosBuffer.x + dragEnd.x;
			workspace.position.y = wsPosBuffer.y + dragEnd.y;
		}
	}

	function onDragEnd() {
		if (pointerState == Move) {
			isDragging = false;
		}
	}

	static function main() {
		new Main();
	}
}