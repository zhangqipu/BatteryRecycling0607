//
//  RegTwoViewController.m
//  BatteryRecycling
//
//  Created by manyu on 16/4/30.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "RegTwoViewController.h"
#import "FinishViewController.h"
#import "CitysViewController.h"
#import "SFHFKeychainUtils.h"
#import "RequestImageObj.h"

@interface RegTwoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableDictionary *postData;

@end

@implementation RegTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self initSuberView];
}

- (void)initSuberView
{
    _postData = [NSMutableDictionary dictionary];
    [_postData setValue:_userName forKey:@"phone"];
    [_postData setValue:_passWord forKey:@"pwd"];
    
    [SFHFKeychainUtils getPasswordForUsername:_userName andServiceName:@"Account" error:nil];
    
    UITapGestureRecognizer *headerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPicture:)];
    [_headerImageView addGestureRecognizer:headerTap];
}

/*
 * 地区
 */
- (IBAction)cityAction:(UIButton *)sender {
    
    CitysViewController *vc =[CitysViewController new];
    vc.cityBlock = ^(NSString *citys, NSString *province, NSString *city, NSString *area){
        
        [_cityBtn setTitle:citys forState:UIControlStateNormal];
        [_postData setValue:province forKey:@"province"];
        [_postData setValue:city forKey:@"city"];
        [_postData setValue:area forKey:@"area"];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}

/*
 *  完成注册
 */
- (IBAction)finishAction:(UIButton *)sender {
    
    [self setPostData];
}

- (void)setPostData
{
    [_postData setValue:_nickNameText.text forKey:@"name"];
    [_postData setValue:_adrText.text forKey:@"address"];
    [self request];
}

- (void)request
{
//    [self showIndicatorView];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
   [manager POST:kUseradd parameters:_postData success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//       [self hideIndicatorView];
       if ([responseObject[@"success"] boolValue] == true) {
           StandardUserDefautsSet([ToolsObj enumerateKeysAndObjectsUsing:responseObject[@"result"]], @"user");
           [SFHFKeychainUtils storeUsername:responseObject[@"result"][@"phone"] andPassword:responseObject[@"result"][@"pwd"] forServiceName:@"Account" updateExisting:YES error:nil];
           FinishViewController *vc = [[FinishViewController alloc] init];
           vc.navTitle = @"注册";
           vc.str1 = @"注册成功！";
           vc.str2 = @"赶紧去登陆吧";
           [self.navigationController pushViewController:vc animated:YES];
       } else {
           FinishViewController *vc = [[FinishViewController alloc] init];
           vc.navTitle = @"注册";
           vc.str1 = responseObject[@"result"];
           vc.str2 = @"";
           [self.navigationController pushViewController:vc animated:YES];
       }
      
       
   } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
       FinishViewController *vc = [[FinishViewController alloc] init];
       vc.navTitle = @"注册";
       vc.str1 = @"注册失败";
       [self.navigationController pushViewController:vc animated:YES];
   }];

}

- (void)addPicture:(UITapGestureRecognizer *)sender
{
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
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    _headerImageView.image = image;
    
    [self requestForUpLoadImages];
}

/**
 *  上传图片
 */

- (void)requestForUpLoadImages
{
    RequestImageObj *requestImageObj = [[RequestImageObj alloc] init];
    requestImageObj.upLoadImagesFinish = ^(NSArray *imgUrls) {
        
        [_postData setValue:imgUrls[0] forKey:@"picurl"];
    };
    
    [requestImageObj postImageToQiNiu:@[_headerImageView.image]];
}

@end
