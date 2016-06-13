//
//  RequestImageObj.m
//  BaoluoGamePlatform
//
//  Created by jiasha.huang on 12/3/16.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "RequestImageObj.h"
#import <QiniuSDK.h>
#import "UtilsHeader.h"

@implementation RequestImageObj

- (void)postImageToQiNiu:(NSArray *)images
{
    _images = images;
    _imagesUrl = [NSMutableArray array];
    _parseQueue = [[NSOperationQueue alloc] init];
    
    for (UIImage *image in images) {
        NSInvocationOperation *vo = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(upLoadImageToQiNiu:) object:image];
        [_parseQueue addOperation:vo];
    }
   
}

- (void)upLoadImageToQiNiu:(UIImage *)image
{
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    NSString *token = StandardUserDefautsGet(@"QNToken");
    [upManager putData:data key:nil token:token
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  NSLog(@"info=%@", info);
                  NSLog(@"resp=%@", resp);
                  
                  NSString *imageUrl = resp[@"hash"];
                  NSString *str = [NSString stringWithFormat:@"http://7xtt03.com2.z0.glb.clouddn.com/%@",resp[@"hash"]];
                  if (imageUrl != nil){
                     [_imagesUrl addObject:str];
                  }
                  
                  _uploadedCount++;
                  
                  if (_uploadedCount == _images.count) {
                      self.upLoadImagesFinish(_imagesUrl);
                  }
                  
              } option:nil];

}

@end
