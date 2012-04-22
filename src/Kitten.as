package
{
    import org.flixel.*;

    public class Kitten extends FlxSprite
    {
        [Embed(source="../media/kitten.png")] public var KittenImage:Class;

        public var realx:Number;
        public var realy:Number;
        private var w:Number = 12;
        private var h:Number = 5;

        public function Kitten(x: Number, y: Number):void
        {
            super(x - w, y - h, KittenImage);
            realx = x;
            realy = y;
        }

        override public function update():void
        {
            super.update();
        }
    }
}
