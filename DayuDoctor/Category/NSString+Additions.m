//
// NSString+Additions



#import "NSString+Additions.h"

@implementation NSString (Additions)

- (BOOL)containsOfString:(NSString *)string {
    
    if (![string isKindOfClass:[NSString class]]) return NO;
    
    if (string == nil) return NO;
    
    return [self rangeOfString:string].location != NSNotFound;
}

@end
