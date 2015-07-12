//
//  RHMessageTipCell.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMessageTipCell.h"
#import "RHTipMessage.h"

@implementation RHMessageTipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //
        _bgImageView = [[UIImageView alloc] init];
        [self addSubview:_bgImageView];
        [_bgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.lessThanOrEqualTo(@(232.0f));
        }];
        
        //
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont fontForAppWithSize:13.0f];
        _tipLabel.numberOfLines = 0;
        [_bgImageView addSubview:_tipLabel];
        [_tipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_bgImageView);
            make.top.equalTo(_bgImageView).offset(6);
            make.left.equalTo(_bgImageView).offset(6);
            make.right.equalTo(_bgImageView).offset(-6);
            make.bottom.equalTo(_bgImageView).offset(-6);
        }];
        
    }
    return self;
}

- (void)updateViewForMiddleWithData:(RHMessageData *)cellData
{
    [super updateViewForMiddleWithData:cellData];
    
    RHTipMessage *tipMessage = (RHTipMessage *)cellData;
    
    _bgImageView.image = [RHMessageTipCell tipBgImage];
    _tipLabel.text = tipMessage.text;
}

+ (UIImage *)tipBgImage
{
    return [[UIImage imageNamed:@"tip_bg"] stretchImageWithInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
}

@end
