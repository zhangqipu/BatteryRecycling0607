//
//  InterfaceDefines.h
//  BatteryRecycling
//
//  Created by 健库 on 16/3/31.
//  Copyright © 2016年 wong. All rights reserved.
//

#ifndef InterfaceDefines_h
#define InterfaceDefines_h

#define kHost @"http://120.24.0.197:8333/api/"

#define Contact(path) \
[NSString stringWithFormat:@"%@%@", kHost, path]
// 登录
#define kLogin Contact(@"User/login")
// 登出
#define kLoginOut Contact(@"User/logout")
#define kLoginOutParam(_id) @{@"_id":_id}

// 首页统计数据
#define kLoveData Contact(@"User/getLoveData")

// 注册
#define kUseradd Contact(@"User/add")

// 重置密码
#define kResetPwd Contact(@"User/resetPwd")

// 修改资料
#define kUpdateUserInfo Contact(@"User/updateUserInfo")

// 获取验证码
#define kSmsget Contact(@"sms/get")
#define kSmsgetParam(phoneNum) @{@"phone":phoneNum}
// 校验验证码
#define kSmscheck Contact(@"sms/get")
#define kSmscheckParam(phoneNum, checkCode) @{@"phone":phoneNum,@"checkCode":checkCode}
// 地址信息维护
#define kUpdateUserAddrInfo Contact(@"User/updateUserAddrInfo")

// 商品分类查询
#define kGoodsCategory Contact(@"GoodsCategory")

// 限时折扣
#define kGoodsDiscount Contact(@"GoodsDiscount")

// 商品
#define kGoods Contact(@"Goods")

// 横幅
#define kBanner Contact(@"Banner")

// 电池
#define kBatteryType Contact(@"BatteryType")
// 电池新增订单
#define kBatteryTypeOrderAdd Contact(@"BatteryRecyclingOrder/add")
// 订单
#define kOrder Contact(@"Order")

// 商品收藏 Favorites
#define kFavorites Contact(@"Favorites")

// 回收商申请 MerchantReq/add?
#define kMerchantReqAdd Contact(@"MerchantReq/add")

// 七牛Token api/qiniu/token
#define kQiniuToken Contact(@"qiniu/token")

// 商品评论
#define kComment Contact(@"Comment")

// 账户查询
#define kAccount Contact(@"User/account")

// 购物车
#define kCart Contact(@"Cart")

// 购物车新增
#define kCartAdd Contact(@"Cart/add")

// 购物车增加或减少
#define kCartUpdateQty Contact(@"Cart/updateQty")

// 购物车删除
#define kCartDelete Contact(@"Cart/delete")

// 消息
#define kMessageGetAll Contact(@"Message/getAll")

// 电池回收订单
#define kBatteryRecyclingOrder Contact(@"BatteryRecyclingOrder")

// 设置电池回收价格 User/updateUserInfo
#define kUserUpdateUserInfo Contact(@"User/updateUserInfo")


////个人信息
//#define USER_LOGIN_DEFAULTS @"loginID"
//
////归档路径
//#define docPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"userInfo.cd"]

////通知
//#define Noti_Log_Message @"Noti_Log_Message"
//#define Noti_CartIsChoose_Message @"Noti_CartIsChoose_Message"

#endif /* InterfaceDefines_h */
