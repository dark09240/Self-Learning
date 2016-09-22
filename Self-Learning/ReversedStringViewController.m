#import "ReversedStringViewController.h"
#import "NSString+ReversedString.h"

@implementation ReversedStringViewController

- (IBAction)reversedString:(UIButton *)sender {
    NSString *myString = self.myTtextField.text;
    self.myLabel.text = [myString reversedString];
}

@end
