package
{
    import org.flixel.*;

    public class KittenAnimated extends FlxSprite
    {
        [Embed(source="../media/kitten_anim.png")] public var KittenAnimatedImage:Class;

        public var realx:Number;
        public var realy:Number;
        private var w:Number = 12;
        private var h:Number = 5;

        public function KittenAnimated(x: Number, y: Number):void
        {
            super(x - w, y - h);
            realx = x;
            realy = y;

            loadGraphic(KittenAnimatedImage,true);

            var speed:Number = 100;
            velocity.x = -speed;

            //addAnimation("Default",[0,0,1,2],10);
            addAnimation("Default",[0,1,2],4);
            play("Default");
        }

        override public function update():void
        {

            if(x<0)
            {
                x=FlxG.width;
            }
            super.update();
        }
    }
}
