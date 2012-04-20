package
{
    import org.flixel.*;

    public class SplashState extends FlxState
    {
        [Embed(source="../media/splash.png")] public var splash_image:Class;

        override public function create():void
        {
            // declaring the sprite variable that will hold the splash image
            var splash:FlxSprite = new FlxSprite(0,0,splash_image);
            add(splash);
/*
            // this variable will hold all texts
            var my_text:FlxText
            // adding the splash image on state
            // adding and styling the first text, the title itself
            my_text = new FlxText(0, 20, FlxG.width, "GAMENAME")
            var textColour:Number = 0xFFFFFFFF;
//            my_text.setFormat(null,16,0xFFFFFFFF,"center")
            my_text.setFormat(null,16,textColour,"center")
            my_text.setFormat(null,16,textColour,"center", 0xFF000000)
            add(my_text);

            my_text = new FlxText(0, 80, FlxG.width, "A game by Jonathan Frawley <9lines.com>")
            my_text.setFormat(null,16,textColour,"center", 0xFF000000)
            add(my_text);

            // adding and styling a text saying the player has to press SPACE to play
            my_text = new FlxText(0, 180, FlxG.width, "Press SPACE to begin")
            my_text.setFormat(null, 8, textColour, "center", 0xFF000000);
            add(my_text);
*/

            super.create();
        }

        override public function update():void
        {
            // checking if the player pressed SPACE...
            if (FlxG.keys.pressed("SPACE"))
            {
                FlxG.switchState(new PlayState());
            //    FlxG.switchState(new CreditsState());
            }
            super.update();
        }

    }
}
