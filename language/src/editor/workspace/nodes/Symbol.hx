package editor.workspace.nodes;

import editor.workspace.Node;

class Symbol extends Node {
    
    var text: String;
    var txt: pixi.core.text.Text;

    public function new(text: String) {
        this.text = text;
        super();
        type = RSymbol(text);
    }

    override public function initGraphic() {
        txt = new pixi.core.text.Text(text);
        txt.height = 32;
        addChild(txt);
    }
}