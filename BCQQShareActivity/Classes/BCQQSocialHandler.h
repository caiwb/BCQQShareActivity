//
//  BCQQSocialHandler.h
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/QQApiInterface.h>

#define QQ_ACCESS_TOKEN     @"QQ_ACCESS_TOKEN"
#define QQ_OPEN_ID          @"QQ_OPEN_ID"
#define QQ_EXPIRATION_DATE  @"QQ_EXPIRATION_DATE"

@interface BCQQSocialHandler : NSObject <TencentSessionDelegate, QQApiInterfaceDelegate>

@property (nonatomic, strong) TencentOAuth *oAth;

@property (nonatomic, strong) NSString *appId;

@property (nonatomic, strong) NSString *accessToken;

@property (nonatomic, strong) NSString *openId;

@property (nonatomic, strong) NSDate *expirationDate;

@property (nonatomic, assign) BOOL reAuthorize;

@property (nonatomic, assign) BOOL isQQInstall;

@property (nonatomic, strong) void (^loginComplete)(BOOL suc, NSString *accessToken, NSString *openId, NSString *errMsg);

@property (nonatomic, strong) void (^getUserInfoComplete)(BOOL suc, id userInfo);

@property (nonatomic, strong) void (^shareComplete)(BOOL suc, NSString *errMsg);

+ (instancetype)sharedInstance;

- (void)setQQAppId:(NSString *)appId;

- (BOOL)handleOpenURL:(NSURL *)url;

@end
