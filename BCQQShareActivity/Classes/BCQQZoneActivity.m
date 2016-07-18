//
//  BCQQZoneActivity.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import "BCQQZoneActivity.h"

@implementation BCQQZoneActivity

#if TARGET_IPHONE_SIMULATOR
#else

- (id)init
{
    if (self = [super init])
    {
        self.type = BCQQ_ZONE;
    }
    return self;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    if ([super canPerformWithActivityItems:activityItems])
    {
        return !(self.shareImageData || !self.webUrl || [self.webUrl isEqualToString:@""]);
    }
    return NO;
}

- (UIImage *)activityImage
{
    UIImage *image = [UIImage imageNamed:@"qzone_icon"];
    
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
    return NSLocalizedString(@"QQ空间", nil);
}

#endif

@end
