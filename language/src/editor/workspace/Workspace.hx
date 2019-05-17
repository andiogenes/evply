package editor.workspace;

import pixi.core.display.Container;

class Workspace extends Container {

    public function new() {
        super();
        interactive = true;

        var text = new pixi.core.text.Text("abcd");

        addChild(text);
    }

    public function zoom(percent: Float) {
        scale.x += percent;
        scale.y += percent;
    }
}