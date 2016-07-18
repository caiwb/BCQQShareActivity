//
//  BCQQShareProvider.h
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>

typedef NS_OPTIONS(NSUInteger, BCQQShareType)
{
    BCQQ_SESSION,      //分享到聊天界面
    BCQQ_ZONE          //分享到空间
};

//QQ空间只支持网页、音乐、视频分享
@interface BCQQShareProvider : NSObject

+ (QQApiSendResultCode)shareWebPage:(BCQQShareType)type
                          withTitle:(NSString *)title
                               text:(NSString *)text
                         thumbImage:(UIImage *)thumbImage
                             webUrl:(NSString *)webUrl
                           complete:(void (^)(BOOL suc, NSString *errMsg))complete;


+ (QQApiSendResultCode)shareMusic:(BCQQShareType)type
                        withTitle:(NSString *)title
                             text:(NSString *)text
                       thumbImage:(UIImage *)thumbImage
                      musicWebUrl:(NSString *)musicWebUrl
                         musicUrl:(NSString *)musicUrl
                         complete:(void (^)(BOOL suc, NSString *errMsg))complete;


+ (QQApiSendResultCode)shareImage:(BCQQShareType)type
                        withTitle:(NSString *)title
                             text:(NSString *)text
                       thumbImage:(UIImage *)thumbImage
                   shareImageData:(NSData *)shareImageData
                         complete:(void (^)(BOOL suc, NSString *errMsg))complete;


+ (QQApiSendResultCode)shareVideo:(BCQQShareType)type
                        withTitle:(NSString *)title
                             text:(NSString *)text
                       thumbImage:(UIImage *)thumbImage
                      videoWebUrl:(NSString *)videoWebUrl
                         videoUrl:(NSString *)videoUrl
                         complete:(void (^)(BOOL suc, NSString *errMsg))complete;


+ (QQApiSendResultCode)shareText:(BCQQShareType)type text:(NSString *)text complete:(void (^)(BOOL suc, NSString *errMsg))complete;


+ (QQApiSendResultCode)share:(BCQQShareType)type withTitle:(NSString *)title
                        text:(NSString *)text
                  thumbImage:(UIImage *)thumbImage
                      webUrl:(NSString *)webUrl
                    musicUrl:(NSString *)musicUrl
                    videoUrl:(NSString *)videoUrl
              shareImageData:(NSData *)shareImageData
                    complete:(void (^)(BOOL suc, NSString *errMsg))complete;

@end
