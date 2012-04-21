package
{
    import org.flixel.*;

    public class MathHelp
    {
        public static function square(x:Number):Number
        {
            return x * x;
        }
        public static function dist(x1:Number,y1:Number,x2:Number, y2:Number):Number
        {
            return Math.sqrt( MathHelp.square(x2-x1) + MathHelp.square(y2-y1) );
        }
    }
}

