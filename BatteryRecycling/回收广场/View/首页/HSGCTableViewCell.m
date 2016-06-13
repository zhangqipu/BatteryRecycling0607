//
//  HSGCTableViewCell.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 11/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "HSGCTableViewCell.h"

@implementation HSGCTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configCell:(id)model
{
    
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model[@"picUrl"]]
                        placeholderImage:kNoPicture];
    [_upLab setText:model[@"name"]];
    
    NSString *maxPrice = [model[@"maxPrice"] stringValue];
    NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithAttributedString:_donwLab.attributedText];
    [as replaceCharactersInRange:NSMakeRange(5, 3) withString:maxPrice];
    _donwLab.attributedText = as;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
