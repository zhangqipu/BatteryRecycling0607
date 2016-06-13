//
//  RequestImageObj.h
//  BaoluoGamePlatform
//
//  Created by jiasha.huang on 12/3/16.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^UpLoadImagesFinish)(NSArray *);
@interface RequestImageObj : NSObject

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSOperationQueue *parseQueue;
@property (nonatomic, copy) NSMutableArray *imagesUrl;
@property (nonatomic, copy) UpLoadImagesFinish upLoadImagesFinish;
@property (assign, nonatomic) NSInteger uploadedCount;

- (void)postImageToQiNiu:(NSArray *)images;

@end
