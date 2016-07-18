//
//  BCQQBaseActivity.h
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <UIKit/UIKit.h>
#import "BCQQShareProvider.h"

@interface BCQQBaseActivity : UIActivity

//text is required at least
@property (nonatomic, assign) BCQQShareType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *webUrl;
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, strong) NSString *musicUrl;
@property (nonatomic, strong) NSString *videoUrl;
@property (nonatomic, strong) NSData *shareImageData;

@property (nonatomic, strong) void (^completeBlock)(BOOL suc, NSString *errMsg);
@property (nonatomic, strong) void (^actionBlock)(Class activityClass);

@end
