package
{
    import org.flixel.*;

    public class PlayState extends FlxState
    {
        [Embed(source="media/back.jpg")]
            private var BackgroundImageClass:Class;
        [Embed(source="media/greenBlock.png")] public var PlayerImage:Class;

        private var background:FlxSprite;
        private var player:FlxSprite;

        override public function create():void
        {
            //Background
            background = new FlxSprite(0, 0, BackgroundImageClass);
            add(background);

            //Create player
            player = new FlxSprite(FlxG.width/2, FlxG.height/2, PlayerImage);
            player.maxVelocity.x = 80;
            player.maxVelocity.y = 80;
            add(player);
        }

        override public function update():void
        {
            if(FlxG.keys.LEFT)
                player.x -= 2;
            if(FlxG.keys.RIGHT)
                player.x += 2;
            if(FlxG.keys.UP)
                player.y -= 2;
            if(FlxG.keys.DOWN)
                player.y += 2;
        }
    }
}
