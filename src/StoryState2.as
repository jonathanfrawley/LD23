package
{
    import org.flixel.*;

    public class StoryState2 extends FlxState
    {
        [Embed(source="../media/StoryBackground.png")] private var BackgroundImage:Class;

        public var state:PlayState;

        override public function create():void
        {
            //Background
            var background :FlxSprite = new FlxSprite(0, 0, BackgroundImage);
            add(background);

            var text:FlxText= new FlxText(0, FlxG.height/3, FlxG.width,
                                "LittleEarth's army will have sufficient resources to launch a counterattack after three more attacks.\n You must defend them until this happens.\n The Kittens of the Fluffy Nebula may lend their support...\nI've heard kittens like living in asteroids.\n \nPress space to continue");

            var kitten:KittenAnimated = new KittenAnimated(FlxG.width/2,FlxG.height-180);
            kitten.velocity.x = 0;
            add(kitten);

            //text.setFormat(null, 16, 0xFFFFFF, "center");
            text.setFormat("04B", 16, 0x487e9d, "center");
            add(text);
        }

        override public function update():void
        {
            if (FlxG.keys.pressed("SPACE"))
            {
                FlxG.switchState(new PlayState());
            }
            super.update();
        }

    }
}
