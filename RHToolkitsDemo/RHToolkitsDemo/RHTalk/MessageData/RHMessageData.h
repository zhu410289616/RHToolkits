//
//  RHMessageData.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Log.h"

typedef NS_ENUM(NSInteger, RHMessageType) {
    RHMessageTypeNone = 0,
    RHMessageTypeText = 1,
    RHMessageTypeImage = 2,
    RHMessageTypeAudio = 3,
    RHMessageTypeUnknown = 999
};

typedef NS_ENUM(NSInteger, RHMessageCellDirection) {
    RHMessageCellDirectionUnknown = 0,
    RHMessageCellDirectionLeft = 1,
    RHMessageCellDirectionMiddle = 2,
    RHMessageCellDirectionRight = 3
};

@protocol RHMessageDataProtocol <NSObject>

@required

- (RHMessageType)messageType;
- (Class)messageCellClass;
- (RHMessageCellDirection)cellDirection;
- (CGFloat)cellHeight;

@optional

- (BOOL)shouldShowNickname;

@end

@interface RHMessageData : NSObject <RHMessageDataProtocol>

@property (nonatomic, strong) NSData *blobdata;
@property (nonatomic, strong) NSNumber *fromUserId;
@property (nonatomic, strong) NSNumber *fromNickname;
@property (nonatomic, copy) NSString *fromAvatarUrl;
@property (nonatomic, strong) NSNumber *toUserId;
@property (nonatomic, strong) NSNumber *toNickname;
@property (nonatomic, copy) NSString *toAvatarUrl;

@property (nonatomic, assign) CGFloat marginTop;
@property (nonatomic, assign) CGFloat marginBotton;

@property (nonatomic, assign) CGFloat nicknameHeight;

@end
