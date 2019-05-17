package editor.gui;

import pixi.core.display.Container;
import pixi.core.textures.Texture;
import editor.gui.SelectorElement;

class CursorSelector extends Container {

    public function new(cursorHandler: Void->Void, handHandler: Void->Void, magnifierHandler: Void->Void) {
        super();

        interactive = true;

        var left = new SelectorElement(Left, 50, 25, Texture.from("assets/cursor.png"));
        left.on("pointerdown", cursorHandler);

        var center = new SelectorElement(Center, 50, 25, Texture.from("assets/hand.png"));
        center.position.x = 50;
        center.on("pointerdown", handHandler);

        var right = new SelectorElement(Right, 50, 25, Texture.from("assets/magnifier.png"));
        right.position.x = 100;
        right.on("pointerdown", magnifierHandler);

        addChild(left);
        addChild(center);
        addChild(right);
    }

}