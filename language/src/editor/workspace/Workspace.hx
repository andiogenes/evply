package editor.workspace;

import pixi.core.display.Container;
import editor.workspace.Node;

class Workspace extends Container {

    public var selectedNodes: List<Node>;
    public var shiftPressed: Bool = false;

    public function new() {
        super();
        interactive = true;

        selectedNodes = new List<Node>();

        var text = new editor.workspace.nodes.Text("Abcd");
        text.position.x = 250;
        addNode(text);

        // var number = new editor.workspace.nodes.Number(10);
        // addChild(number);

        var boolean = new editor.workspace.nodes.Boolean(false);
        boolean.position.y = 100;
        addNode(boolean);

        var picture = new editor.workspace.nodes.Picture(0, 5);
        picture.position.x = 256;
        picture.position.y = 256;
        addNode(picture);
    }

    public function zoom(percent: Float) {
        scale.x += percent;
        scale.y += percent;
    }

    public function addNode(node: Node) {
        addChild(node);
        node.setWorkspace(this);
    }

    public function recordSelection(node: Node) {
        selectedNodes.add(node);
    }

    public function dispatchSelection(node: Node) {
        selectedNodes.remove(node);
    }

    public function clearSelection() {
        for (i in selectedNodes) {
            i.unselect();
        }
    }
}