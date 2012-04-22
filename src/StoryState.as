package
{
    import org.flixel.*;

    public class StoryState extends FlxState
    {
        [Embed(source="../media/StoryBackground.png")] private var BackgroundImage:Class;

        override public function create():void
        {
            //Background
            var background :FlxSprite = new FlxSprite(0, 0, BackgroundImage);
            add(background);

            var text:FlxText= new FlxText(0, FlxG.height/3, FlxG.width, "LittleEarth's people were left to die after BigEmpire's forces attacked and stole LittleEarth's food and natural resources.\n LittleEarth's people managed to construct a giant cannon as a last defence.\n You are given control of the cannon as BigEmpire launch another attack...\nAim with the mouse and left click to fire was all they said.\n \nPress space to continue");
            //text.setFormat(null, 16, 0xFFFFFF, "center");
            //text.setFormat(null, 16, 0x487e9d, "center");
            text.setFormat("04B", 16, 0x487e9d, "center");
            add(text);
        }

        override public function update():void
        {
            if (FlxG.keys.pressed("SPACE"))
            {
            //    FlxG.switchState(new PlayState());
                FlxG.switchState(new PlayState());
            }
        }

    }
}
