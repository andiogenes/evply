package editor.gui;

import pixi.core.sprites.Sprite;
import pixi.core.graphics.Graphics;
import pixi.core.display.Container;

class PictureItem extends Container  {
    public var horiz(default, null): Int;
    public var vert(default, null): Int;
    private var pParent: PictureSelector;

    public function new(i: Int, j: Int, pParent: PictureSelector) {
        super();
        horiz = j;
        vert = i;
        this.pParent = pParent;
        on("pointerdown", onButton);
        addChild(Sprite.from("pictures_"+i+"_"+j+".png"));
    }

    public function onButton() {
        var picture = new editor.workspace.nodes.Picture(vert, horiz);
        picture.position.set(-pParent.workspace.x+pParent.app.width/2, -pParent.workspace.y+pParent.app.height/2);
        pParent.workspace.addNode(picture);
    }
}

class PictureSelector extends Container {

    static inline var fillColor = 0x222222;
    static inline var lineColor = 0xF5F5DC;

    public var workspace: editor.workspace.Workspace;
    public var app: pixi.plugins.app.Application;
    public function new(x: Float, y: Float, width: Float, height: Float, workspace: editor.workspace.Workspace, app: pixi.plugins.app.Application) {
        super();
    
        this.app = app;
        this.workspace = workspace;

        var graphic = new Graphics();
        graphic.lineStyle(5);
        graphic.beginFill(fillColor, 0.5);
        graphic.drawRoundedRect(x, y, width, height, 10);
        graphic.endFill();

        addChild(graphic);

        for (i in 0...16) {
            for (j in 0...15) {
                var sprite = new PictureItem(i, j, this);
                sprite.position.set(i*(width*0.8/16) + x * 1.2, j*(height*0.9/15) + y*1.1);
                sprite.width = sprite.height = width/32;
                sprite.interactive = true;
                sprite.buttonMode = true;
                addChild(sprite);
            }
        }

        var btn = new SelectorElement(Center, width * 0.2, height * 0.05, null, "Выход");
        btn.position.set(x + width * 0.4, y + height * 0.92);
        btn.on("pointerdown", function() visible = false);
        addChild(btn);
    }
}