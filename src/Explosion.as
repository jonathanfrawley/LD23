package
{
    import org.flixel.*;

    public class Explosion extends FlxSprite
    {
        [Embed(source="../media/explosion.png")] public var ExplosionImage:Class;

        private var w : Number = 16;
        private var h : Number = 16;
        private var hangAroundTime : Number = 0.5;
        private var currentTime : Number = 0;

        public function Explosion(x: Number, y: Number):void
        {
            super(x - w, y - h, ExplosionImage);
//            super(x, y, ExplosionImage);
        }

        override public function update():void
        {
            currentTime += FlxG.elapsed;
            if(currentTime > hangAroundTime)
            {
                kill();
            }
            super.update();
        }
    }
}
