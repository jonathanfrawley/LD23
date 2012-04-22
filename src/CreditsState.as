package
{
    import org.flixel.*;

    public class CreditsState extends FlxState
    {
        [Embed(source="../media/credits.png")] public var credits_image:Class;

        override public function create():void
        {
            // declaring the sprite variable that will hold the credits image
            var credits:FlxSprite = new FlxSprite(0,0,credits_image);
            add(credits);

            super.create();
        }

        override public function update():void
        {

            // checking if the player pressed SPACE...
            if (FlxG.keys.pressed("SPACE"))
            {
                FlxG.switchState(new SplashStateAgain());
            }
            super.update();
        }

    }
}
