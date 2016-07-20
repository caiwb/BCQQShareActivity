//
//  BCViewController.m
//  BCQQShareActivity
//
//  Created by caiwenbo on 07/18/2016.
//  Copyright (c) 2016 caiwenbo. All rights reserved.
//

#import "BCViewController.h"
#import "BCQQShareActivity.h"

@interface BCViewController ()

@end

@implementation BCViewController

- (void)loginAndGetUserInfo
{
    [BCQQLoginProvider loginWithCompleteBlock:^(BOOL suc, NSString *accessToken, NSString *openId, NSString *errMsg) {
        if (suc)
        {
            [BCQQLoginProvider getUserInfoWithCompleteBlock:^(BOOL suc, BCQQUserInfo *userInfo) {
                if (suc)
                {
                    //use userInfo
                }
            }];
        }
    }];
}

- (void)share
{
    [BCQQShareProvider shareWebPage:BCQQ_SESSION
                          withTitle:@"分享到QQ"
                               text:@"内容"
                         thumbImage:[UIImage imageNamed:@"thumbImage"]
                             webUrl:@"github.com"
                           complete:^(BOOL suc, NSString *errMsg) {
                               //to do after share
                           }];
}

- (void)shareOnActivityController
{
    BCQQSessionActivity *item = [[BCQQSessionActivity alloc] init];
    
    item.title = @"title";
    item.text = @"content";
    item.thumbImage = [UIImage new];
    item.webUrl = @"github.com";
    [item setCompleteBlock:^(BOOL suc, NSString *errMsg) {
        //to do after share
    }];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[item.title, item.webUrl, item.thumbImage] applicationActivities:@[item]];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loginAndGetUserInfo];
}

@end
