package editor.gui;

import pixi.core.display.Container;
import pixi.core.textures.Texture;
import editor.gui.SelectorElement;

class EvalSelector extends Container {

    public function new(handler: Void->Void) {
        super();

        interactive = true;

        var button = new SelectorElement(Center, 50, 25, Texture.from("assets/eval.png"));
        button.position.x = 50;
        button.on("pointerdown", handler);

        addChild(button);
    }

}