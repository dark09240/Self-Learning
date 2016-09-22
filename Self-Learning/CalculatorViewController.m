#import "CalculatorViewController.h"

@interface CalculatorViewController (){
    NSDecimalNumber *numberOne,*numberTwo;
    SEL savedSelector;
}
@end

@implementation CalculatorViewController

- (IBAction)buttonMC:(UIButton *)sender {
    self.myResultLabel.text = @"0";
    savedSelector = nil;
    numberOne = numberTwo = nil;
}

- (IBAction)buttonAction:(UIButton *)sender {
    NSString *action = sender.titleLabel.text;
    if (numberOne) {
        if (numberTwo) {
            [self getResult];
        }
        if ([action isEqualToString:@"+"]) {
            savedSelector = @selector(decimalNumberByAdding:);
        }else if ([action isEqualToString:@"-"]) {
            savedSelector = @selector(decimalNumberBySubtracting:);
        }else if ([action isEqualToString:@"*"]) {
            savedSelector = @selector(decimalNumberByMultiplyingBy:);
        }else if ([action isEqualToString:@"/"]) {
            savedSelector = @selector(decimalNumberByDividingBy:);
        }
    }
}

- (IBAction)buttonResult:(UIButton *)sender {
    if (numberOne && numberTwo && savedSelector) {
        [self getResult];
    }
}

- (IBAction)buttonNumber:(UIButton *)sender {
    NSString *buttontext = sender.titleLabel.text;
    NSString *result = self.myResultLabel.text;
    if (!numberTwo && savedSelector)
        result = @"0";
    if ([result isEqualToString:@"0"]) {
        if (![buttontext isEqualToString:@"0"])
            result = buttontext;
    }else {
        result = [result stringByAppendingString:buttontext];
    }
    [self saveNumber:result];
}

- (IBAction)buttonPoint:(UIButton *)sender {
    NSString *result = self.myResultLabel.text;
    if (savedSelector && !numberTwo) {
        result = @"0.";
    }else {
        if ([result containsString:@"."])
            return;
        result = [result stringByAppendingString:@"."];
    }
    [self saveNumber:result];
}

- (void)getResult {
    SuppressPerformSelectorLeakWarning(
        numberOne = [numberOne performSelector:savedSelector
                                    withObject:numberTwo];
    );
    self.myResultLabel.text = [numberOne stringValue];
    savedSelector = nil;
    numberTwo = nil;
}

- (void)saveNumber:(NSString *)number {
    if (!savedSelector) {
        numberOne = [NSDecimalNumber decimalNumberWithString:number];
    }else {
        numberTwo = [NSDecimalNumber decimalNumberWithString:number];
    }
    self.myResultLabel.text = number;
}

@end
