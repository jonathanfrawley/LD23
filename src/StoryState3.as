package
{
    import org.flixel.*;

    public class StoryState3 extends FlxState
    {
        [Embed(source="../media/StoryBackground.png")] private var BackgroundImage:Class;

        public var state:PlayState;

        override public function create():void
        {
            //Background
            var background :FlxSprite = new FlxSprite(0, 0, BackgroundImage);
            add(background);

            var text:FlxText= new FlxText(0, FlxG.height/3, FlxG.width,
                                "The people of LittleEarth rally around their new champion. A parade is held in your honour. After holding off 2 more attacks LittleEarth will be saved, and you will be famous forever. \nPress space to continue");
            //text.setFormat(null, 16, 0xFFFFFF, "center");
            text.setFormat(null, 16, 0x487e9d, "center");
            add(text);
        }

        override public function update():void
        {
            if (FlxG.keys.pressed("SPACE"))
            {
                FlxG.switchState(new PlayState());
            }
        }

    }
}
