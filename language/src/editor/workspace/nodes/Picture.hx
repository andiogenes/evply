package editor.workspace.nodes;

import editor.workspace.Node;
import pixi.core.sprites.Sprite;

class Picture extends Node {
    
    var text: String;
    var sprite: Sprite;
    
    public function new(x: Int, y: Int) {
        text = 'pictures_'+x+'_'+y+'.png';
        super();
        type = RPicture(x, y);
    }

    override public function initGraphic() {
        sprite = Sprite.from(text);
        addChild(sprite);
    }
}