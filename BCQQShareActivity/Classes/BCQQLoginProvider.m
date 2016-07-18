//
//  BCQQLoginProvider.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import "BCQQLoginProvider.h"
#import "BCQQSocialHandler.h"

@implementation BCQQLoginProvider

#if TARGET_IPHONE_SIMULATOR
#else

+ (void)loginWithCompleteBlock:(void(^)(BOOL suc, NSString *accessToken, NSString *openId, NSString *errMsg))complete
{
    NSParameterAssert(complete);
    
    if (![BCQQSocialHandler sharedInstance].appId)
    {
        complete(NO, nil, nil, @"ConfigurationError");
        return;
    }
    
    if (![BCQQSocialHandler sharedInstance].reAuthorize)
    {
        complete(YES, [BCQQSocialHandler sharedInstance].accessToken, [BCQQSocialHandler sharedInstance].openId, nil);
    }
    else
    {
        NSArray *permissions = @[kOPEN_PERMISSION_GET_INFO,
                                 kOPEN_PERMISSION_GET_USER_INFO,
                                 kOPEN_PERMISSION_GET_SIMPLE_USER_INFO];
        [[BCQQSocialHandler sharedInstance].oAth authorize:permissions];
        
        [BCQQSocialHandler sharedInstance].loginComplete = complete;
    }
}

+ (void)getUserInfoWithCompleteBlock:(void (^)(BOOL, BCQQUserInfo *))complete
{
    NSParameterAssert(complete);
    
    [BCQQSocialHandler sharedInstance].getUserInfoComplete = complete;
    
    if(! [[BCQQSocialHandler sharedInstance].oAth getUserInfo])
    {
        //重新登录
        NSArray *permissions = @[kOPEN_PERMISSION_GET_INFO,
                                 kOPEN_PERMISSION_GET_USER_INFO,
                                 kOPEN_PERMISSION_GET_SIMPLE_USER_INFO];
        [[BCQQSocialHandler sharedInstance].oAth authorize:permissions];
    }
}

#endif

@end
