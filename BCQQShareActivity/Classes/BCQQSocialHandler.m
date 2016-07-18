
//
//  BCQQSocialHandler.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import "BCQQSocialHandler.h"

@implementation BCQQSocialHandler

#if TARGET_IPHONE_SIMULATOR
#else

+ (instancetype)sharedInstance
{
    static BCQQSocialHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[BCQQSocialHandler alloc] init];
    });
    return handler;
}

- (void)setQQAppId:(NSString *)appId
{
    self.oAth = [[TencentOAuth alloc] initWithAppId:appId andDelegate:self];
    
    self.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:QQ_ACCESS_TOKEN];
    self.openId = [[NSUserDefaults standardUserDefaults] objectForKey:QQ_OPEN_ID];
    self.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:QQ_EXPIRATION_DATE];
    
    if (self.accessToken && 0 != [self.accessToken length])
    {
        self.oAth.accessToken = self.accessToken;
        self.oAth.openId = self.openId;
        self.oAth.expirationDate = self.expirationDate;
    }
    
    self.appId = appId;
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [TencentOAuth HandleOpenURL:url] || [QQApiInterface handleOpenURL:url delegate:self];
}

- (BOOL)reAuthorize
{
    return ([self.expirationDate compare:[NSDate date]] == NSOrderedAscending) || ![self.oAth isSessionValid] || !self.oAth.accessToken || _reAuthorize;
}

- (BOOL)isQQInstall
{
    return ([QQApiInterface isQQSupportApi] && [QQApiInterface isQQInstalled]);
}

- (void)getUserInfoWithCompleteBlock:(void (^)(BOOL, id))complete
{
    if (! complete)
    {
        return;
    }
    if(! [self.oAth getUserInfo])
    {
        //重新登录
        NSArray *permissions = @[kOPEN_PERMISSION_GET_INFO,
                                 kOPEN_PERMISSION_GET_USER_INFO,
                                 kOPEN_PERMISSION_GET_SIMPLE_USER_INFO];
        [self.oAth authorize:permissions];
    }
}

#pragma tencent login callback

- (void)tencentDidLogin
{
    if (self.oAth.accessToken && 0 != [self.oAth.accessToken length])
    {
        self.accessToken = self.oAth.accessToken;
        self.openId = self.oAth.openId;
        self.expirationDate = self.oAth.expirationDate;
        
        [[NSUserDefaults standardUserDefaults] setObject:self.accessToken forKey:QQ_ACCESS_TOKEN];
        [[NSUserDefaults standardUserDefaults] setObject:self.openId forKey:QQ_OPEN_ID];
        [[NSUserDefaults standardUserDefaults] setObject:self.expirationDate forKey:QQ_EXPIRATION_DATE];
        
        self.loginComplete(YES, self.accessToken, self.openId, nil);
    }
    else
    {
        self.loginComplete(NO, nil, nil, [TencentOAuth getLastErrorMsg] ?: @"Login failed");
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled)
    {
        self.loginComplete(NO, nil, nil, @"Cancelled authorization");
    }
    else
    {
        self.loginComplete(NO, nil, nil, [TencentOAuth getLastErrorMsg] ?: @"Login failed");
    }
}

- (void)tencentDidNotNetWork
{
    self.loginComplete(NO, nil, nil, [TencentOAuth getLastErrorMsg] ?: @"NetworkError");
}


#pragma incremental authorization

- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth
                   withPermissions:(NSArray *)permissions
{
    [tencentOAuth incrAuthWithPermissions:permissions];
    return NO;// 返回NO表明不需要再回传未授权API接口的原始请求结果；
    // 否则可以返回YES
}

- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth
{
    if (tencentOAuth.accessToken && 0 != [tencentOAuth.accessToken length])
    {
        if (self.openId != tencentOAuth.openId)
        {
            //用户在增量授权时更换账号
            self.oAth = tencentOAuth;
            self.accessToken = tencentOAuth.accessToken;
            self.openId = tencentOAuth.openId;
        }
    }
}

#pragma get userinfo

- (void)getUserInfoResponse:(APIResponse *)response
{
    if (URLREQUEST_SUCCEED == response.retCode && kOpenSDKErrorSuccess == response.detailRetCode)
    {
        self.getUserInfoComplete(YES, response.jsonResponse);
    }
}

#pragma recieve share response

- (void)onResp:(QQBaseResp *)resp
{
    if (!resp.errorDescription || !resp.errorDescription.length)
    {
        self.shareComplete(YES, nil);
    }
    else
    {
        self.shareComplete(NO, resp.errorDescription);
    }
}

- (void)onReq:(QQBaseReq *)req {}
- (void)isOnlineResponse:(NSDictionary *)response {}

#endif

@end
