//
//  BCQQLoginProvider.h
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <Foundation/Foundation.h>

@interface BCQQLoginProvider : NSObject

+ (void)loginWithCompleteBlock:(void(^)(BOOL suc, NSString *accessToken, NSString *openId, NSString *errMsg))complete;

+ (void)getUserInfoWithCompleteBlock:(void (^)(BOOL suc, id userInfo))complete;

@end
