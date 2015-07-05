//
//  RHTableViewAdapter.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHTableViewAdapter.h"
#import "RHTableViewCell.h"

@implementation RHTableViewAdapter

- (instancetype)init
{
    if (self = [super init]) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addCellData:(id)cellData
{
    if (nil == cellData) {
        return;
    }
    [_dataArray addObject:cellData];
}

- (void)removeAllCellData
{
    [_dataArray removeAllObjects];
}

- (RHTableViewCell *)tableView:(UITableView *)tableView reusedCellOfClass:(Class)cellClass
{
    NSString *cellIdentifier = NSStringFromClass(cellClass);
    id cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (Class)classOfCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [RHTableViewCell class];
}

#pragma mark -
#pragma mark UITableViewDataSource method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class cellClass = [self classOfCellForRowAtIndexPath:indexPath];
    RHTableViewCell *cell = [self tableView:tableView reusedCellOfClass:cellClass];
    if (indexPath.row >= 0 && indexPath.row < _dataArray.count) {
        id cellData = _dataArray[indexPath.row];
        [cell updateViewWithData:cellData];
    }
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row >= _dataArray.count) {
        return;
    }
    
    id cellData = _dataArray[indexPath.row];
    if ([_delegate respondsToSelector:@selector(didTableViewCellSelect:)]) {
        [_delegate didTableViewCellSelect:cellData];
    }
}

@end
