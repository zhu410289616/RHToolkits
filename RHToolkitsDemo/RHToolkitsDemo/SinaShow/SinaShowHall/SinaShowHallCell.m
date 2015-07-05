//
//  SinaShowHallCell.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "SinaShowHallCell.h"
#import "HallRoomInfo.h"

@interface SinaShowHallCell ()
{
    HallRoomInfo *_hallInfo;
}

@end

@implementation SinaShowHallCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(kSizeFrom750(30));
            make.size.mas_equalTo(CGSizeMake(kSizeFrom750(170), kSizeFrom750(127)));
        }];
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.iconImageView.mas_right).offset(kSizeFrom750(30));
            make.right.equalTo(self).offset(-kSizeFrom750(30));
        }];
    }
    return self;
}

- (void)updateViewWithData:(id)cellData
{
    _hallInfo = cellData;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_hallInfo.p] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor] size:self.iconImageView.frame.size]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@ (%@)", _hallInfo.e, _hallInfo.roomidx];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
