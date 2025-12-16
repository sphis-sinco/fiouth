package frontend.debug;

import lime.utils.Assets;
import backend.state.State;

class Preloading extends State
{
    public var assetsList:Array<String>;

    override function create() {
        super.create();

        assetsList = Assets.list();

        trace(assetsList.length + ' assets');
    }

}