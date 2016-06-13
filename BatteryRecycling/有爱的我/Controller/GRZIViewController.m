//
//  GRZIViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 9/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "GRZIViewController.h"
#import "SFHFKeychainUtils.h"
#import "DZGLViewController.h"
#import "XGNCViewController.h"
#import "ZHAQViewController.h"

@interface GRZIViewController ()<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@end

@implementation GRZIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    
    [self initSuberView];
}

- (void)initSuberView
{
    NSDictionary *user = StandardUserDefautsGet(@"user");
    _userIDLab.text = user[@"phone"];
    _nickNameLab.text = user[@"name"];
    
}

/*
 *  点击头像事件
 */
- (IBAction)HeaderImageAction:(UIButton *)sender {
    [self addPicture:nil];
}
/*
 * 修改昵称事件
 */
- (IBAction)nickNameAction:(UIButton *)sender {
    XGNCViewController *vc = [[XGNCViewController alloc] init];
    vc.finishEdit = ^(NSString *name){
        _nickNameLab.text = name;
    };
    
    
    [self.navigationController pushViewController:vc animated:YES];
}

/*
 * 地址管理事件
 */
- (IBAction)adrAction:(UIButton *)sender {
    DZGLViewController *vc = [[DZGLViewController alloc] initWithUrl:nil andParams:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
 * 账户管理事件
 */
- (IBAction)userAction:(UIButton *)sender {
    ZHAQViewController *vc = [ZHAQViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
 * 退出登录
 */
- (IBAction)logOutAction:(UIButton *)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager POST:[NSString stringWithFormat:@"%@?token=%@", kLoginOut, StandardUserDefautsGet(@"token")] parameters:kLoginOutParam(StandardUserDefautsGet(@"user")[@"_id"]) success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        if ([responseObject[@"success"] boolValue] == true) {
            StandardUserDefautsSet(@"no", @"isLogin");
            [[NSNotificationCenter defaultCenter] postNotificationName:UserLogOutStatusNotification object:nil];
            
            [SFHFKeychainUtils deleteItemForUsername:StandardUserDefautsGet(@"user")[@"phone"] andServiceName:@"Account"  error:nil];
            
//            StandardUserDefautsRemove(@"user");
            
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self showInfoView:@"退出失败" infoType:InfoTypeSucceed];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showInfoView:@"退出失败" infoType:InfoTypeSucceed];
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
    
}


@end
