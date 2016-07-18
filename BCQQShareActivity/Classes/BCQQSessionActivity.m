//
//  BCQQSessionActivity.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import "BCQQSessionActivity.h"

@implementation BCQQSessionActivity

#if TARGET_IPHONE_SIMULATOR
#else

- (id)init
{
    if (self = [super init])
    {
        self.type = BCQQ_SESSION;
    }
    return self;
}

- (UIImage *)activityImage
{
    UIImage *image = [UIImage imageNamed:@"qq_icon"];
    
    CGSize size = image.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    UIBezierPath* roundedRect = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    
    [[UIColor whiteColor] setFill];
    [roundedRect fill];
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (NSString *)activityTitle
{
    return NSLocalizedString(@"QQ好友", nil);
}

#endif

@end
