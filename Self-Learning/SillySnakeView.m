#import "SillySnakeView.h"

@implementation SillySnakeView

- (void)drawRect:(CGRect)rect {
    SillySnakeData *snake = [self.delegate sillySnakeViewOfSnake:self];
    SnakeWorldSize worldSize = snake.worldSize;
    if (worldSize.width <= 0 || worldSize.height <= 0) {
        return;
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat w = self.bounds.size.width/worldSize.width;
    CGFloat h = self.bounds.size.height/worldSize.height;
    
    if (snake) {
        NSArray *points = snake.points;
        [[UIColor grayColor] set];
        
        for (NSValue *value in points) {
            SnakePoint point = [value snakePointValue];
            CGRect rect = CGRectMake(w*point.x, h*point.y, w, h);
            CGContextFillRect(ctx, rect);
        }
    }
    
    NSValue *fruit = [self.delegate sillySnakeViewOfFruit:self];
    if (fruit) {
        [[UIColor redColor] set];
        SnakePoint point = [fruit snakePointValue];
        CGRect rect = CGRectMake(w*point.x, h*point.y, w, h);
        CGContextFillEllipseInRect(ctx, rect);
    }
}

@end
