//
//  CitysViewController.m
//  SchoolApp
//
//  Created by 黄嘉沙 on 15/10/26.
//  Copyright (c) 2015年 张齐朴. All rights reserved.
//

#import "CitysViewController.h"
#import "HZAreaPickerView.h"

@interface CitysViewController ()<HZAreaPickerDelegate>

@property (strong, nonatomic) NSString *areaValue, *cityValue;
@property (strong, nonatomic) HZAreaPickerView *locatePicker;
@end

@implementation CitysViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.areaText = [[UILabel alloc] initWithFrame:CGRectMake(14, 100, SCREEN_WIDTH - 28, 30)];
        self.areaText.font = [UIFont systemFontOfSize:15];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, 1)];
        line.backgroundColor = UIColorFromRGB(0xc1c1c1);
        [self.view addSubview:line];
        [self.view addSubview:self.areaText];
    }
    return self;
}
-(void)setAreaValue:(NSString *)areaValue
{
    if (![_areaValue isEqualToString:areaValue]) {
        self.areaText.text = areaValue;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市";
    self.view.backgroundColor = [UIColor whiteColor];
    self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
    [self.locatePicker showInView:self.view];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(request)];
    self.navigationItem.rightBarButtonItem = item;

    // Do any additional setup after loading the view from its nib.
}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    self.areaText.text = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    self.citys = @{@"Province":picker.locate.state,@"City":[NSString stringWithFormat:@"%@",picker.locate.city], @"district":picker.locate.district};
    
    _province = picker.locate.state;
    _city = picker.locate.city;
    _area = picker.locate.district;
}

- (void)request
{
    _cityBlock(_areaText.text, _province, _city, _area);
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
