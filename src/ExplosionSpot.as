package
{
    import org.flixel.*;

    public class ExplosionSpot extends FlxSprite
    {
        [Embed(source="../media/explosionSpot.png")] public var ExplosionSpotImage:Class;

        private var w : Number = 4;
        private var h : Number = 4;
        public var realx:Number;
        public var realy:Number;
        public var id:int;

        public function ExplosionSpot(x: Number, y: Number, id:int):void
        {
            super(x - w, y - h, ExplosionSpotImage);
            realx = x;
            realy = y;
            this.id = id;
        }

        override public function update():void
        {
            super.update();
        }
    }
}
