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