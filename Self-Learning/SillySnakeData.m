#import "SillySnakeData.h"

SnakeWorldSize MakeSnakeWorldSize(NSUInteger width, NSUInteger height){
    SnakeWorldSize size;
    size.width = width;
    size.height = height;
    return size;
}

SnakePoint MakeSnakePoint(NSUInteger x, NSUInteger y){
    SnakePoint point;
    point.x = x;
    point.y = y;
    return point;
}

@implementation NSValue (SnakePoint)

+ (id)valueWithSnakePoint:(SnakePoint)inPoint {
    return	[NSValue valueWithBytes:&inPoint objCType:@encode(SnakePoint)];
}

- (SnakePoint)snakePointValue {
    if (strcmp([self objCType], @encode(SnakePoint)) == 0) {
        SnakePoint origin;
        [self getValue:&origin];
        return origin;
    }
    return MakeSnakePoint(0, 0);
}

@end

@interface SillySnakeData (){
    NSMutableArray *points;
    SnakeWorldSize worldSize;
    SnakeDirection direction;
    BOOL directionLocked;
}
@end

@implementation SillySnakeData

- (id)initWithWorldSize:(SnakeWorldSize)inWorldSize length:(NSUInteger)inLength {
    self = [super init];
    if (self) {
        points = [[NSMutableArray alloc] init];
        worldSize = inWorldSize;
        direction = SnakeDirectionLeft;
        NSUInteger x = (NSUInteger)(worldSize.width / 2.0);
        NSUInteger y = (NSUInteger)(worldSize.height / 2.0);
        for (NSInteger i = 0; i < inLength; i++) {
            [points addObject:[NSValue valueWithSnakePoint:MakeSnakePoint(x + i, y)]];
        }
    }
    return self;
}

- (void)move {
    [points removeObject:[points lastObject]];
    SnakePoint firstPoint = [points[0] snakePointValue];
    NSInteger x = firstPoint.x;
    NSInteger y = firstPoint.y;
    switch (direction) {
        case SnakeDirectionLeft:
            if (--x < 0) x = worldSize.width - 1;
            break;
        case SnakeDirectionUp:
            if (--y < 0) y = worldSize.height - 1;
            break;
        case SnakeDirectionRight:
            if (++x >= worldSize.width) x = 0;
            break;
        case SnakeDirectionDown:
            if (++y >= worldSize.height) y = 0;
        default:
            break;
    }
    [points insertObject:[NSValue valueWithSnakePoint:MakeSnakePoint(x, y)] atIndex:0];
}

- (BOOL)changeDirection:(SnakeDirection)inDirection {
    if (directionLocked) {
        return NO;
    }
    if (inDirection == SnakeDirectionLeft || inDirection == SnakeDirectionRight) {
        if (direction == SnakeDirectionUp || direction == SnakeDirectionDown) {
            direction = inDirection;
            return YES;
        }
    }
    if (inDirection == SnakeDirectionUp || inDirection == SnakeDirectionDown) {
        if (direction == SnakeDirectionLeft || direction == SnakeDirectionRight) {
            direction = inDirection;
            return YES;
        }
    }
    return NO;
}

- (void)increaseLength:(NSUInteger)inLength {
    SnakePoint lastPoint = [[points lastObject] snakePointValue];
    SnakePoint theOneBeforeLastPoint = [[points objectAtIndex:[points count]-2] snakePointValue];
    NSInteger x = lastPoint.x - theOneBeforeLastPoint.x;
    NSInteger y = lastPoint.y - theOneBeforeLastPoint.y;
    if (lastPoint.x == 0 && theOneBeforeLastPoint.x == worldSize.width - 1) x = 1;
    if (lastPoint.x == worldSize.width - 1 && theOneBeforeLastPoint.x == 0) x = -1;
    if (lastPoint.y == 0 && theOneBeforeLastPoint.y == worldSize.height - 1) y = 1;
    if (lastPoint.y == worldSize.height - 1 && theOneBeforeLastPoint.y == 0) y = -1;
    for (NSInteger i = 0; i < inLength; i++) {
        NSInteger theX = (lastPoint.x + x * (i + 1)) % worldSize.width;
        NSInteger theY = (lastPoint.y + y * (i + 1)) % worldSize.height;
        [points addObject:[NSValue valueWithSnakePoint:MakeSnakePoint(theX, theY)]];
    }
}

- (BOOL)isHeadHitBody {
    SnakePoint firstPoint = [points[0] snakePointValue];
    for (NSInteger i = 1; i < [points count]; i++) {
        SnakePoint point = [points[i] snakePointValue];
        if (point.x == firstPoint.x && point.y == firstPoint.y) {
            return YES;
        }
    }
    return NO;
}

- (void)lockDirection
{
    directionLocked = YES;
}
- (void)unlockDirection
{
    directionLocked = NO;
}

@synthesize points;
@synthesize worldSize;
@end
