//
//  BCQQUserInfo.h
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <JSONModel/JSONModel.h>

/**
    is_lost,
    figureurl,
    vip,
    is_yellow_year_vip,
    province,
    ret,
    is_yellow_vip,
    figureurl_qq_1,
    yellow_vip_level,
    level,
    figureurl_1,
    city,
    figureurl_2,
    nickname,
    msg,
    gender,
    figureurl_qq_2
*/

@interface BCQQUserInfo : JSONModel

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;

@end
