package editor.gui;

import pixi.core.display.Container;
import pixi.core.graphics.Graphics;
import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;
import pixi.core.text.Text;

enum ButtonAlignType {
    Left;
    Center;
    Right;
}

class SelectorElement extends Container {

    static inline var fillColor = 0x222222;
    static inline var lineColor = 0xF5F5DC;
    public function new(type: ButtonAlignType, width: Float, height: Float, ?image: Texture, ?text: String) {
        super();

        interactive = true;
        buttonMode = true;

        var graphic: Graphics = new Graphics();

        graphic.beginFill(fillColor);
        graphic.lineStyle(0.5, lineColor);
        switch (type) {
            case Left:
                graphic.drawRoundedRect(0, 0, width, height, 8);
                graphic.lineStyle(0);
                graphic.drawRect(8, 0, width - 8, height);
                graphic.lineStyle(0.5, lineColor);
                graphic.drawRect(width-1, 0, 1, height);
            case Center:
                graphic.drawRect(0, 0, width, height);
            case Right:
                graphic.drawRoundedRect(0, 0, width, height, 8);
                graphic.lineStyle(0);
                graphic.drawRect(0, 0, width-8, height);
                graphic.lineStyle(0.5, lineColor);
                graphic.drawRect(0, 0, 1, height);
        }
        graphic.endFill();

        // На случай, если buttonMode работает некорректно
        // on("mouseover", function() Browser.document.body.style.cursor = "pointer");
        // on("mouseout", function() Browser.document.body.style.cursor = "default");

        addChild(graphic);
        
        if (image != null) {
            var sprite = new Sprite(image);
            sprite.scale.x = 0.8;
            sprite.scale.y = 0.8;
            // sprite.position.x = (width - sprite.width)/2;
            sprite.position.x = 16;
            sprite.position.y = 2.5;
            addChild(sprite);
        }

        if (text != null) {
            var grText = new Text(text, {fill: 0xffffff});
            grText.position.x = (width - grText.width)/2;
            grText.position.y = -2.5;
            addChild(grText);
        }
    }
}