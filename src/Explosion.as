package
{
    import org.flixel.*;

    public class Explosion extends FlxSprite
    {
        [Embed(source="../media/explosion.png")] public var ExplosionImage:Class;
        public function Explosion(x: Number, y: Number, w:Number, h:Number):void
        {
            super(x - w, y - h, ExplosionImage);
        }

        override public function update():void
        {
            super.update();
        }
    }
}
