package editor.gui;

import pixi.core.display.Container;
import pixi.core.textures.Texture;
import editor.gui.SelectorElement;

class ScaleSelector extends Container {

    public function new(decreaseHandler: Void->Void, increaseHandler: Void->Void) {
        super();

        interactive = true;

        var left = new SelectorElement(Left, 75, 25, null, "-");
        left.on("pointerdown", decreaseHandler);

        var right = new SelectorElement(Right, 75, 25, null, "+");
        right.position.x = 75;
        right.on("pointerdown", increaseHandler);

        addChild(left);
        addChild(right);
    }

}