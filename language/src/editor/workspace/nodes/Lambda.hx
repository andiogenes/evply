package editor.workspace.nodes;

import editor.workspace.ListNode;
import editor.workspace.Node;
import pixi.core.sprites.Sprite;

class Lambda extends ListNode {

    public function new(list: List<Node>) {
        super(list);
    }
}

class LambdaPicture extends Node {
    var sprite: Sprite;
    public function new() {
        super();
        type = RLambdaSymbol;
    }

    override public function initGraphic() {
        sprite = Sprite.from("assets/lambda.png");
        addChild(sprite);
    }
}