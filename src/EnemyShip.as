package
{
    import org.flixel.*;

    public class EnemyShip extends FlxSprite
    {
        [Embed(source="../media/enemySpaceshipVertical.png")] public var EnemyShipVerticalImage:Class;
        [Embed(source="../media/enemySpaceshipHorizontal.png")] public var EnemyShipHorizontalImage:Class;
        [Embed(source="../media/enemySpaceshipDownward.png")] public var EnemyShipDownwardImage:Class;
        [Embed(source="../media/enemySpaceshipLeft.png")] public var EnemyShipLeftImage:Class;

        public var realx:Number;
        public var realy:Number;

        public var w:Number = 16;
        public var h:Number = 16;

        private var type:int;

        public function EnemyShip(x: Number, y: Number, type:int):void
        {
            //super(x - w, y - h, EnemyShipImage);
            super(x - w, y - h);

            //loadRotatedGraphic(EnemyShipImage,8);

            realx = x;
            realy = y;

            this.type=type;
            var speed:Number = 50;
            if(type == 0)
            {
                velocity.x = -speed;
                loadGraphic(EnemyShipLeftImage);
            }
            else if(type == 1)
            {
                velocity.x = speed;
                loadGraphic(EnemyShipHorizontalImage);
            }
            else if(type == 2)
            {
                velocity.y = -speed;
                loadGraphic(EnemyShipVerticalImage);
            }
            else if(type == 3)
            {
                velocity.y = speed;
                loadGraphic(EnemyShipDownwardImage);
            }
/*
            if(type == 0)
            {
                velocity.x = speed * 0.5;
                velocity.y = -speed * 0.5;
//                addAnimation("Default",[2],0,true);
//                play("Default");
            }
            else if(type == 1)
            {
                velocity.x = speed * 0.5;
                velocity.y = speed * 0.5;
            }
            else if(type == 2)
            {
                velocity.x = -speed * 0.5;
                velocity.y = -speed * 0.5;
            }
            else if(type == 3)
            {
                velocity.x = -speed * 0.5;
                velocity.y = speed * 0.5;
            }
*/
        }

        override public function update():void
        {
            super.update();
        }
    }
}

