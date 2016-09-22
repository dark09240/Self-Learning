#import "NSString+ReversedString.h"

@implementation NSString(ReversedString)

- (NSString *)reversedString {
    NSString *string = [[NSString alloc]init];
    for (NSUInteger i = self.length; i > 0; i --) {
        string = [string stringByAppendingString:[self substringWithRange:NSMakeRange(i - 1, 1)]];
    }
    return string;
}

@end
