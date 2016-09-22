#import "SillySnakeView.h"

@interface SillySnakeViewController : UIViewController<SillySnakeViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *myStartButton;
@property (weak, nonatomic) IBOutlet UIButton *myBackButton;
@property (strong, nonatomic) IBOutlet SillySnakeView *mySillySnakeView;

@end
