package
{
    import org.flixel.*;

    public class Rock extends FlxSprite
    {
        [Embed(source="../media/rock.png")] private var RockImage:Class;

        private var type:int;

        public function Rock(x: Number, y: Number, rockType:int):void
        {
            super(x, y, RockImage);
            type=rockType;
            var speed:Number = 100;
            if(type == 0)
            {
                velocity.x = -speed;
            }
            else if(type == 1)
            {
                velocity.x = speed;
            }
            else if(type == 2)
            {
                velocity.y = -speed;
            }
            else if(type == 3)
            {
                velocity.y = speed;
            }
        }

        override public function update():void
        {
            super.update();
        }
    }
}

