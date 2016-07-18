//
//  BCQQUserInfo.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import "BCQQUserInfo.h"

@implementation BCQQUserInfo

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"nickname": @"nickName", @"figureurl_qq_2": @"avatar"}];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end
