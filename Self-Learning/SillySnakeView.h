#import "SillySnakeData.h"

@class SillySnakeView;

@protocol SillySnakeViewDelegate <NSObject>

- (SillySnakeData *)sillySnakeViewOfSnake:(SillySnakeView *)sillySnakeView;
- (NSValue *)sillySnakeViewOfFruit:(SillySnakeView *)sillySnakeView;

@end

@interface SillySnakeView : UIView

@property (weak, nonatomic) id<SillySnakeViewDelegate> delegate;

@end
