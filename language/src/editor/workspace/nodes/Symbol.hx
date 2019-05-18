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

class Quote extends Symbol {

    public function new() {
        super("quote");
        type = RQuoteSymbol;
    }
}

class Conditional extends Symbol {

    public function new() {
        super("if");
        type = RIfSymbol;
    }
}

class Define extends Symbol {
    public function new() {
        super("define");
        type = RDefSymbol;
    }
}

class ListSymbol extends Symbol {
    public function new() {
        super("list");
        type = RListSymbol;
    }
}