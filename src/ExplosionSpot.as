package
{
    import org.flixel.*;

    public class ExplosionSpot extends FlxSprite
    {
        [Embed(source="../media/explosion.png")] public var ExplosionSpotImage:Class;

        public var id:int;
        public function ExplosionSpot(x: Number, y: Number, w:Number, h:Number, id:int):void
        {
            super(x - w, y - h, ExplosionSpotImage);
            this.id = id;
        }

        override public function update():void
        {
            super.update();
        }
    }
}
