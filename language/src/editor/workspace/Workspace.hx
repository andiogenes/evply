package editor.workspace;

import pixi.core.display.Container;
import editor.workspace.Node;

class Workspace extends Container {

    public var selectedNodes: List<Node>;
    public var shiftPressed: Bool = false;
    public var evalSelector(default, default): Null<editor.gui.EvalSelector>;
    public var nodes: List<Node>;

    public function new() {
        super();
        interactive = true;

        selectedNodes = new List<Node>();
        nodes = new List<Node>();
    }

    public function zoom(percent: Float) {
        scale.x += percent;
        scale.y += percent;
    }

    public function addNode(node: Node) {
        addChild(node);
        nodes.add(node);
        node.setWorkspace(this);
    }

    public function recordSelection(node: Node) {
        selectedNodes.add(node);
    }

    public function dispatchSelection(node: Node) {
        selectedNodes.remove(node);
    }

    public function deleteSelected() {
        for (i in selectedNodes) {
            removeChild(i);
        }
    }

    public function clearSelection() {
        for (i in selectedNodes) {
            i.unselect();
        }
        if (evalSelector != null) {
            evalSelector.visible = false;
        }
    }
}