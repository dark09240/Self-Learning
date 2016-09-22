typedef struct {
    NSUInteger width;
    NSUInteger height;
} SnakeWorldSize;
SnakeWorldSize MakeSnakeWorldSize(NSUInteger width, NSUInteger height);

typedef struct {
    NSUInteger x;
    NSUInteger y;
} SnakePoint;
SnakePoint MakeSnakePoint(NSUInteger x, NSUInteger y);

@interface NSValue (SnakePoint)

+ (id)valueWithSnakePoint:(SnakePoint)inPoint;
- (SnakePoint)snakePointValue;

@end

typedef enum {
    SnakeDirectionLeft,
    SnakeDirectionUp,
    SnakeDirectionRight,
    SnakeDirectionDown
} SnakeDirection;

@interface SillySnakeData : NSObject

@property (readonly, nonatomic) NSArray *points;
@property (readonly, nonatomic) SnakeWorldSize worldSize;

- (id)initWithWorldSize:(SnakeWorldSize)inWorldSize length:(NSUInteger)inLength;
- (void)move;
- (BOOL)changeDirection:(SnakeDirection)inDirection;
- (void)increaseLength:(NSUInteger)inLength;
- (BOOL)isHeadHitBody;
- (void)lockDirection;
- (void)unlockDirection;

@end
