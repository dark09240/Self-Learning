#import "SillySnakeViewController.h"
#import "SillySnakeData.h"

@interface SillySnakeViewController()

@property (retain, nonatomic) SillySnakeData *snake;
@property (retain, nonatomic) NSTimer *timer;
@property (retain, nonatomic) NSValue *fruitPoint;

@end

@implementation SillySnakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mySillySnakeView.delegate = self;
    [self addGestureRecognizerWithDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizerWithDirection:UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizerWithDirection:UISwipeGestureRecognizerDirectionUp];
    [self addGestureRecognizerWithDirection:UISwipeGestureRecognizerDirectionDown];
}

- (void)addGestureRecognizerWithDirection:(UISwipeGestureRecognizerDirection)direction {
    UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    gr.direction = direction;
    [self.mySillySnakeView addGestureRecognizer:gr];
}

- (void)swipe:(UISwipeGestureRecognizer *)gr {
    UISwipeGestureRecognizerDirection direction = gr.direction;
    NSDictionary *directionMap = @{@(UISwipeGestureRecognizerDirectionRight): @"moveRight:",
                                   @(UISwipeGestureRecognizerDirectionLeft): @"moveLeft:",
                                   @(UISwipeGestureRecognizerDirectionUp): @"moveUp:",
                                   @(UISwipeGestureRecognizerDirectionDown): @"moveDown:"};
    SuppressPerformSelectorLeakWarning(
        [self performSelector:NSSelectorFromString(directionMap[@(direction)]) withObject:self];
    );
}

- (void)moveLeft:(id)sender {
    if ([self.snake changeDirection:SnakeDirectionLeft]) {
        [self.snake lockDirection];
    }
}
- (void)moveRight:(id)sender {
    if ([self.snake changeDirection:SnakeDirectionRight]) {
        [self.snake lockDirection];
    }
}
- (void)moveUp:(id)sender {
    if ([self.snake changeDirection:SnakeDirectionUp]) {
        [self.snake lockDirection];
    }
}
- (void)moveDown:(id)sender {
    if ([self.snake changeDirection:SnakeDirectionDown]) {
        [self.snake lockDirection];
    }
}

- (IBAction)start:(UIButton *)sender {
    [self startGame];
}

- (void)startGame {
    if (self.timer) {
        return;
    }
//    SnakeWorldSize worldSize = MakeSnakeWorldSize(24, 15);
    NSUInteger viewHeight = self.mySillySnakeView.bounds.size.height;
    NSUInteger viewWidth = self.mySillySnakeView.bounds.size.width;
    NSUInteger worldWidth = 15;
    SnakeWorldSize worldSize = MakeSnakeWorldSize(worldWidth, worldWidth * viewHeight / viewWidth);
    self.myStartButton.hidden = YES;
    self.myBackButton.hidden = YES;
    self.snake = [[SillySnakeData alloc] initWithWorldSize:worldSize length:2];
    [self makeNewFruit];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerMethod:) userInfo:nil repeats:YES];
}

- (void)endGame {
    self.myStartButton.hidden = NO;
    self.myBackButton.hidden = NO;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerMethod:(NSTimer *)inTimer {
    [self.snake move];
    if ([self.snake isHeadHitBody]) {
        [self endGame];
        return;
    }
    SnakePoint head = [self.snake.points[0] snakePointValue];
    SnakePoint friut = [self.fruitPoint snakePointValue];
    if (head.x == friut.x && head.y == friut.y) {
        [self.snake increaseLength:2];
        [self makeNewFruit];
    }
    
    [self.snake unlockDirection];
    [self.mySillySnakeView setNeedsDisplay];
}

- (void)makeNewFruit {
    srandomdev();
    NSInteger x = 0;
    NSInteger y = 0;
    SnakeWorldSize worldSize = self.snake.worldSize;
    while (1) {
        x = random() % worldSize.width;
        y = random() % worldSize.height;
        BOOL inBody = NO;
        for (NSValue *v in self.snake.points) {
            SnakePoint point = [v snakePointValue];
            if (point.x == x && point.y == y) {
                inBody = YES;
                break;
            }
        }
        if (!inBody) {
            break;
        }
    }
    self.fruitPoint = [NSValue valueWithSnakePoint:MakeSnakePoint(x, y)];
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (SillySnakeData *)sillySnakeViewOfSnake:(SillySnakeView *)sillySnakeView {
    return self.snake;
}

- (NSValue *)sillySnakeViewOfFruit:(SillySnakeView *)sillySnakeView {
    return self.fruitPoint;
}

@end
