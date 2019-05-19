package editor.gui;

import pixi.core.display.Container;
import pixi.core.graphics.Graphics;

class BoolSelector extends Container {

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

        var trBtn = new SelectorElement(Center, width * 0.2, height * 0.20, null, "true");
        trBtn.position.set(x + width * 0.2, y + height * 0.26);
        trBtn.on("pointerdown", function() {
            var bool = new editor.workspace.nodes.Boolean(true);
            bool.position.set(-workspace.x+app.width/2, -workspace.y+app.height/2 - 128);
            workspace.addNode(bool);
        });
        addChild(trBtn);
        var flBtn = new SelectorElement(Center, width * 0.2, height * 0.20, null, "false");
        flBtn.position.set(x + width * 0.6, y + height * 0.26);
        flBtn.on("pointerdown", function() {
            var bool = new editor.workspace.nodes.Boolean(false);
            bool.position.set(-workspace.x+app.width/2, -workspace.y+app.height/2 - 128);
            workspace.addNode(bool);
        });
        addChild(flBtn);

        var btn = new SelectorElement(Center, width * 0.2, height * 0.20, null, "Выход");
        btn.position.set(x + width * 0.4, y + height * 0.62);
        btn.on("pointerdown", function() visible = false);
        addChild(btn);
    }
}