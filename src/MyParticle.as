package
{ 
    import org.flixel.*;

    public class MyParticle extends FlxParticle
    {
        public function MyParticle():void
        {
            super();
            var a:Number = 2;
            makeGraphic(16, 4, 0xFFff0000);
        }
    }
}
