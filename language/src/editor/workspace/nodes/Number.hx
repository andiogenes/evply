package editor.workspace.nodes;

import editor.workspace.Node;

class Number extends Node {
    
    var text: String;
    var txt: pixi.core.text.Text;
    
    public function new(number: Float) {
        this.text = Std.string(number);
        super();
        type = RNumber(number);
    }

    override public function initGraphic() {
        txt = new pixi.core.text.Text(text);
        txt.height = 32;
        addChild(txt);
    }
}