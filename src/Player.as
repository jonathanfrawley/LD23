package
{
    import org.flixel.*;

    public class Player extends FlxSprite
    {
        [Embed(source="../media/litteworld.png")] public var PlayerImage:Class;

        public var realx:Number;
        public var realy:Number;

        public function Player(x: Number, y: Number, w:Number, h:Number):void
        {
            super(x - w, y - h, PlayerImage);
            realx = x;
            realy = y;
        }

        override public function update():void
        {
            super.update();
        }
    }
}

