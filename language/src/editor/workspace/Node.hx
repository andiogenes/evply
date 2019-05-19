package editor.workspace;

import pixi.core.display.Container;
import pixi.core.graphics.Graphics;
import editor.workspace.Workspace;
import pixi.interaction.InteractionData;
import interpreter.Evaluator;

enum RealType {
    RNumber(number: Float);
    RString(string: String);
    RSymbol(string: String);
    RBoolean(boolean: Bool);
    RPicture(x: Int, y: Int);
    RList(list: List<Node>);
    RLambdaSymbol;
    RQuoteSymbol;
    RIfSymbol;
    RDefSymbol;
    RListSymbol;
    RBegin;
}

enum Nest {
    Children(children: List<Node>);
    Nothing;
}

class Node extends Container {
    public var nest: Nest;
    public var type: RealType;
    public var isSelected(default, null): Bool = false;
    public var workspace: Null<Workspace>;
    
    var data: InteractionData;
    var isDrag: Bool = false;

    var selectGraphic: Graphics;
    static inline var selectColor = 0xf10000;

    public function new() {
        super();
        interactive = true;
        buttonMode = true;

        initGraphic();

        selectGraphic = new Graphics();
        
        selectGraphic.beginFill(selectColor, 0.25);
        selectGraphic.drawRect(0, 0, 256, 256);
        selectGraphic.endFill();

        selectGraphic.visible = false;

        on("pointerdown", function(e) { 
            data = e.data; 
            isDrag = true; 
            select(); 
         });
        on("pointermove", move);
        on("pointerupoutside", dragExit);
        on("pointerup", dragExit);

        addChild(selectGraphic);
    }

    public function initGraphic() {
    
    }

    public function setWorkspace(workspace: Workspace) {
        this.workspace = workspace;
    }

    public function unsetWorkspace() {
        this.workspace = null;
    }

    public function select() {
        if (isSelected || workspace == null) return;

        isSelected = true;
        selectGraphic.width = width;
        selectGraphic.height = height;
        selectGraphic.visible = true;

        if (workspace != null) {
            if (workspace.shiftPressed == false) {
                workspace.clearSelection();
                if (workspace.evalSelector != null) {
                    workspace.evalSelector.visible = true;
                }
            } else {
                if (workspace.evalSelector != null) {
                    workspace.evalSelector.visible = false;
                }
            }

            workspace.recordSelection(this);
        }
    }

    public function unselect() {
        isSelected = false;
        selectGraphic.visible = false;

        if (workspace != null) {
            workspace.dispatchSelection(this);
        }
    }

    public function serialize(): String {
        var out = switch (type) {
            case RNumber(number):
                '{"type": "number","value": "$number","x": ${position.x}, "y": ${position.x}, "w": ${width}, "h": ${height},"children": []}';
            case RString(string):
                 '{"type": "string","value": "$string","x": ${position.x}, "y": ${position.y}, "w": ${width}, "h": ${height},"children": []}';
            case RSymbol(string):
                 '{"type": "string","value": "$string","x": ${position.x}, "y": ${position.y}, "w": ${width}, "h": ${height},"children": []}';
            case RBoolean(boolean):
                 '{"type": "boolean","value": "$boolean","x": ${position.x}, "y": ${position.y}, "w": ${width}, "h": ${height},"children": []}';
            case RPicture(xx, yy):
                 '{"type": "picture","value": "${xx}_${yy}","x": ${position.x}, "y": ${position.y}, "w": ${width}, "h": ${height},"children": []}';
            case RList(list):
                var resultString = "";
                for (i in list) {
                    resultString += i.serialize() + ',';
                }
                resultString = resultString.substr(0, resultString.length-1);
                '{"type": "parens","value": "","x": ${position.x}, "y": ${position.y}, "w": ${width}, "h": ${height},"children": [${resultString}]}';
            case RLambdaSymbol:
                '{"type": "lambda","value": "lambda","x": ${position.x}, "y": ${position.y}, "w": ${width}, "h": ${height},"children": []}';
            case RQuoteSymbol:
                '{"type": "quote","value": "quote","x": ${position.x}, "y": ${position.y}, "w": ${width}, "h": ${height},"children": []}';
            case RIfSymbol:
                '{"type": "if","value": "if","x": ${position.x}, "y": ${position.y}, "w": ${width}, "h": ${height},"children": []}';
            case RDefSymbol:
                '{"type": "define","value": "define","x": ${position.x}, "y": ${position.y}, "w": ${width}, "h": ${height},"children": []}';
            case RListSymbol:
                '{"type": "list","value": "lista","x": ${position.x}, "y": ${position.y}, "w": ${width}, "h": ${height},"children": []}';
            case RBegin:
                '{"type": "begin","value": "begin","x": ${position.x}, "y": ${position.y}, "w": ${width}, "h": ${height},"children": []}';
        }

        return out;
    }

    public function astfize() : ASTType {
         var out = switch (type) {
            case RNumber(number):
                ANumber(number);
            case RString(string):
                AString(string);
            case RSymbol(string):
                ASymbol(string);
            case RBoolean(boolean):
                ABoolean(boolean);
            case RPicture(x, y):
                APicture(x, y);
            case RList(list):
                var lst = new List<ASTType>();
                for (i in list) {
                    lst.add(i.astfize());
                }
                AList(lst);
            case RLambdaSymbol:
                ALambda;
            case RQuoteSymbol:
                AQuote;
            case RIfSymbol:
                AIf;
            case RDefSymbol:
                ADef;
            case RListSymbol:
                AListSymbol;
            case RBegin:
                ABegin;
         }

         return out;
    }

    function move() {
        if (isDrag) {
            var newPosition = data.getLocalPosition(workspace);

            for (i in workspace.selectedNodes) {
                if (i != this) {
                    i.x = i.x - position.x + newPosition.x;
                    i.y = i.y - position.y + newPosition.y;
                }
            }

            position.x = newPosition.x;
            position.y = newPosition.y;   

        }
    }

    function dragExit() {
        isDrag = false;
        data = null;
    }
}