package editor.workspace.nodes;

import editor.workspace.Node;

class Boolean extends Node {
    
    var text: String;
    var txt: pixi.core.text.Text;
    
    public function new(boolean: Bool) {
        this.text = if (boolean) "true" else "false";
        super();
        type = RBoolean(boolean);
    }

    override public function initGraphic() {
        txt = new pixi.core.text.Text(text);
        txt.height = 32;
        addChild(txt);
    }
}