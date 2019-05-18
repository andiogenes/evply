package editor.workspace;

import editor.workspace.Node;
import pixi.core.graphics.Graphics;

class ListNode extends Node {

    var list: List<Node>;
    var graphic: Graphics;

    inline static var maxWidth = 528;

    public function new(list: List<Node>) {
        this.list = list;
        super();
        type = RList(list);
    }

    override function initGraphic() {
        graphic = new Graphics();
        graphic.beginFill(0x00f100, 0.2);
        graphic.drawRect(0, 0, 64, 64);
        graphic.endFill();
        addChild(graphic);

        for (i in list) {
            i.interactive = false;
            i.unselect();
            i.unsetWorkspace();
            i.setParent(this);
        }

        gridify();
    }

    public function gridify() {
        var isFirst = true;

        var currentCellX = 0;
        var currentCellY = 0;

        var maxCellX = 0;
        var maxCellY = 0;

        for (i in list) {
            if (isFirst) {
                i.position.set(8, 8);
                currentCellY++;

                if (currentCellY > maxCellY)
                    maxCellY = currentCellY;

                isFirst = false;
            } else {
                if (currentCellX * 48 + i.width + 8 > maxWidth) { 
                    currentCellX = 0;
                    currentCellY++;

                    if (currentCellY > maxCellY)
                        maxCellY = currentCellY;

                    i.position.x = currentCellX * 48 + 8;
                    i.position.y = currentCellY * 48 + 8;
                } else {
                    i.position.x = currentCellX * 48 + 8;
                    i.position.y = currentCellY * 48 + 8;
                    currentCellX += Math.ceil(i.width/48);

                    if (currentCellX > maxCellX)
                        maxCellX = currentCellX;
                }
            }
        }

        var leftUpperObject = list.first();
        var rightLowerObject = list.last();

        if (leftUpperObject != null)
            graphic.height = rightLowerObject.y + rightLowerObject.height - leftUpperObject.y + 16;

        graphic.width = maxCellX * 48 + 16;
        // graphic.height = maxCellY * 48 + 64;
    }
}