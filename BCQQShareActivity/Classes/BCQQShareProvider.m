//
//  BCQQShareProvider.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import "BCQQShareProvider.h"
#import "BCQQSocialHandler.h"

@implementation BCQQShareProvider

#if TARGET_IPHONE_SIMULATOR
#else

+ (QQApiSendResultCode)shareImage:(BCQQShareType)type
                        withTitle:(NSString *)title
                             text:(NSString *)text
                       thumbImage:(UIImage *)thumbImage
                   shareImageData:(NSData *)shareImageData
                         complete:(void (^)(BOOL suc, NSString *errMsg))complete
{
    return [self share:type withTitle:title text:text thumbImage:thumbImage webUrl:nil musicUrl:nil videoUrl:nil shareImageData:shareImageData complete:complete];
}


+ (QQApiSendResultCode)shareWebPage:(BCQQShareType)type
                          withTitle:(NSString *)title
                               text:(NSString *)text
                         thumbImage:(UIImage *)thumbImage
                             webUrl:(NSString *)webUrl
                           complete:(void (^)(BOOL suc, NSString *errMsg))complete
{
    return [self share:type withTitle:title text:text thumbImage:thumbImage webUrl:webUrl musicUrl:nil videoUrl:nil shareImageData:nil complete:complete];
}


+ (QQApiSendResultCode)shareMusic:(BCQQShareType)type
                        withTitle:(NSString *)title
                             text:(NSString *)text
                       thumbImage:(UIImage *)thumbImage
                      musicWebUrl:(NSString *)musicWebUrl
                         musicUrl:(NSString *)musicUrl
                         complete:(void (^)(BOOL suc, NSString *errMsg))complete
{
    return [self share:type withTitle:title text:text thumbImage:thumbImage webUrl:musicWebUrl musicUrl:musicUrl videoUrl:nil shareImageData:nil complete:complete];
}


+ (QQApiSendResultCode)shareVideo:(BCQQShareType)type
                        withTitle:(NSString *)title
                             text:(NSString *)text
                       thumbImage:(UIImage *)thumbImage
                      videoWebUrl:(NSString *)videoWebUrl
                         videoUrl:(NSString *)videoUrl
                         complete:(void (^)(BOOL suc, NSString *errMsg))complete
{
    return [self share:type withTitle:title text:text thumbImage:thumbImage webUrl:videoWebUrl musicUrl:nil videoUrl:videoUrl shareImageData:nil complete:complete];
}


+ (QQApiSendResultCode)shareText:(BCQQShareType)type text:(NSString *)text complete:(void (^)(BOOL suc, NSString *errMsg))complete
{
    return [self share:type withTitle:nil text:text thumbImage:nil webUrl:nil musicUrl:nil videoUrl:nil shareImageData:nil complete:complete];
}

+ (QQApiSendResultCode)share:(BCQQShareType)type withTitle:(NSString *)title
                        text:(NSString *)text
                  thumbImage:(UIImage *)thumbImage
                      webUrl:(NSString *)webUrl
                    musicUrl:(NSString *)musicUrl
                    videoUrl:(NSString *)videoUrl
              shareImageData:(NSData *)shareImageData
                    complete:(void (^)(BOOL suc, NSString *errMsg))complete
{
    if (! complete)
    {
        complete = ^(BOOL suc, NSString *errMsg) {};
    }
    
    [BCQQSocialHandler sharedInstance].shareComplete = complete;
    
    if (!title && !text)
    {
        complete(NO, @"content is null");
        return EQQAPISENDFAILD;
    }
    text = text ?: title;
    title = title ?: text;
    
    SendMessageToQQReq *req = nil;
    
    if (thumbImage)
    {
        //        NSData *thumbImageData = [self compressImage: thumbImage downToSize:1 * 1024 * 1024];
        NSData *thumbImageData = [self resizeWithImage: thumbImage];
        
        if (shareImageData)//分享图片
        {
            if (shareImageData.length > 5 * 1024)
            {
                UIImage *shareImage = [UIImage imageWithData:shareImageData];
                shareImageData = [self compressImage:shareImage downToSize:5 * 1024 * 1024];
            }
            QQApiImageObject *imgObj = [QQApiImageObject objectWithData:shareImageData
                                                       previewImageData:thumbImageData
                                                                  title:title
                                                            description:text];
            req = [SendMessageToQQReq reqWithContent:imgObj];
        }
        else if (musicUrl && webUrl)//分享音乐
        {
            QQApiAudioObject *musicObj = [QQApiAudioObject objectWithURL:[NSURL URLWithString:webUrl]
                                                                   title:title
                                                             description:text
                                                        previewImageData:thumbImageData];
            musicObj.flashURL = [NSURL URLWithString:musicUrl];
            req = [SendMessageToQQReq reqWithContent:musicObj];
        }
        else if (videoUrl && webUrl)//分享视频
        {
            QQApiVideoObject *videoObj = [QQApiVideoObject objectWithURL:[NSURL URLWithString:webUrl]
                                                                   title:title
                                                             description:text
                                                        previewImageData:thumbImageData];
            videoObj.flashURL = [NSURL URLWithString:videoUrl];
            req = [SendMessageToQQReq reqWithContent:videoObj];
        }
        else if (webUrl)//分享网页
        {
            QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:webUrl] title:title description:text previewImageData:thumbImageData];
            req = [SendMessageToQQReq reqWithContent:newsObj];
        }
        else
        {
            complete(NO, @"share failed");
            return EQQAPISENDFAILD;
        }
    }
    else//分享文字
    {
        QQApiTextObject *txtObj = [QQApiTextObject objectWithText:text];
        req = [SendMessageToQQReq reqWithContent:txtObj];
    }
    
    QQApiSendResultCode result;
    if (BCQQ_SESSION == type)
    {
        result = [QQApiInterface sendReq:req];
    }
    else
    {
        result = [QQApiInterface SendReqToQZone:req];
    }
    if (EQQAPISENDSUCESS != result)
    {
        complete(NO, @"share requset failed");
    }
    return result;
}

+ (NSData *)compressImage:(UIImage *)image downToSize:(NSUInteger)size
{
    CGFloat compression = 1.0f;
    CGFloat scale = [UIScreen mainScreen].scale;
    NSData *imageData = [self resizeWithImage:image scale:scale compression:compression];
    
    while ([imageData length] > size && compression > 0.1)
    {
        compression -= 0.1;
        imageData = [self resizeWithImage:image scale:scale compression:compression];
    }
    while ([imageData length] > size && scale > 0.1)
    {
        scale -= 0.1;
        imageData = [self resizeWithImage:image scale:scale compression:compression];
    }
    return imageData;
}


+ (NSData *)resizeWithImage:(UIImage *)image scale:(CGFloat)scale compression:(CGFloat)compression
{
    CGSize newSize = CGSizeMake(image.size.width * scale, image.size.height * scale);
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImageJPEGRepresentation(newImage, compression);
}


+ (NSData *)resizeWithImage:(UIImage *)image
{
    CGFloat width = 100.0f;
    CGFloat height = image.size.height * 100.0f / image.size.width;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [image drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImageJPEGRepresentation(scaledImage, 1.0f);
}

#endif

@end
