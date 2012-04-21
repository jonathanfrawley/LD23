package
{
    import org.flixel.*;

    public class Cursor extends FlxSprite
    {
        [Embed(source="../media/cursor.png")] public var CursorImage:Class;
        public function Cursor()
        {
            super(0,0,CursorImage);
        }

        override public function update():void
        {
            x = FlxG.mouse.x - (width/2);
            y = FlxG.mouse.y - (height/2);
            super.update();
        }
    }
}
