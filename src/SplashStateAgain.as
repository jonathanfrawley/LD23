package
{
    import org.flixel.*;

    public class SplashStateAgain extends FlxState
    {
        [Embed(source="../media/splash_infinite.png")] public var splash_image:Class;

        override public function create():void
        {
            // declaring the sprite variable that will hold the splash image
            var splash:FlxSprite = new FlxSprite(0,0,splash_image);
            add(splash);

            super.create();
        }

        override public function update():void
        {
            // checking if the player pressed SPACE...
            if (FlxG.keys.pressed("SPACE"))
            {
            //    FlxG.switchState(new PlayState());
                FlxG.switchState(new StoryState());
            }
            else if (FlxG.keys.pressed("ENTER"))
            {
            //    FlxG.switchState(new PlayState());
                FlxG.level = 10;//10 is infinity here.
                FlxG.switchState(new PlayState());
            }
            super.update();
        }

    }
}
