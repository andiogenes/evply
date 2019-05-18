package editor.workspace;

import pixi.core.display.Container;
import pixi.core.graphics.Graphics;
import editor.workspace.Workspace;
import pixi.interaction.InteractionData;

enum RealType {
    RNumber(number: Float);
    RString(string: String);
    RBoolean(boolean: Bool);
    RPicture(x: Int, y: Int); // или (x: Int, y: Int)
    NotPrimitive;
}

enum Nest {
    Children(children: List<Node>);
    Nothing;
}

class Node extends Container {
    // Типы:
    // Число 12345
    // Строка "абцд"
    // Булево true/false
    // Символ
    // Список белая табличка
    // Цитата?
    // Картинка картинка

    // Комплексные выражения??

    // Требования к символу??

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

    public function select() {
        if (isSelected) return;

        isSelected = true;
        selectGraphic.width = width;
        selectGraphic.height = height;
        selectGraphic.visible = true;

        if (workspace != null) {
            if (workspace.shiftPressed == false) {
                workspace.clearSelection();
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