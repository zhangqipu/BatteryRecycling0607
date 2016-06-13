//
//  SFZSCViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 5/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "SFZSCViewController.h"
#import "RequestImageObj.h"

@interface SFZSCViewController ()<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, assign) NSInteger seletedIndex;

@end

@implementation SFZSCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"身份证上传";
    
    [self initSuberView];
}


- (void)initSuberView
{
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPicture:)];
    [_iamgeView1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPicture:)];
    [_imageView2 addGestureRecognizer:tap2];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishPost)];
    self.navigationItem.rightBarButtonItem = item;
}


- (void)finishPost
{
    if ([self cheak]) {
        [self requestForUpLoadImages];
    }
}

// 检查图片是否为空
- (BOOL)cheak
{
    if (_iamgeView1.image == nil) {
        [self showInfoView:@"证件正面未上传" infoType:InfoTypeSucceed];
        return NO;
    } else if (_imageView2.image == nil){
        [self showInfoView:@"证件反面未上传" infoType:InfoTypeSucceed];
        return NO;
    }
    return YES;
}


- (void)addPicture:(UITapGestureRecognizer *)sender
{
    _seletedIndex = sender.view.tag;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照上传", @"相册上传", nil];
    [alert show];
    
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
        {
            [self addPickerFormCamera];
        }
            break;
        case 2:
        {
            [self addPickerFormAlbum];
        }
            break;
        default:
            break;
    }
}

/*
 * 相机获取图片
 */
- (void)addPickerFormCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *camera = [[UIImagePickerController alloc] init];
        camera.delegate = self;
        camera.allowsEditing = YES;
        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:camera animated:YES completion:nil];
    }
}

/*
 *   相册获取图片
 */
- (void)addPickerFormAlbum
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *album = [[UIImagePickerController alloc] init];
        album.delegate = self;
        album.allowsEditing = YES;
        album.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:album animated:YES completion:nil];
    }
}


/*
 * 获取图片返回代理
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    switch (_seletedIndex) {
        case 1:
            _iamgeView1.image = image;
            break;
            
        default:
            _imageView2.image = image;
            break;
    }
}

/**
 *  上传图片
 */

- (void)requestForUpLoadImages
{
    RequestImageObj *requestImageObj = [[RequestImageObj alloc] init];
    requestImageObj.upLoadImagesFinish = ^(NSArray *imgUrls) {
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    [requestImageObj postImageToQiNiu:@[_iamgeView1.image, _imageView2.image]];
}

@end
