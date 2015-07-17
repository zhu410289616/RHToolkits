//
//  RHToolView.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/15.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHToolView.h"
#import "RHToolItemView.h"

@interface RHToolView () <UIScrollViewDelegate>
{
    UIScrollView *_itemsScrollView;
    UIPageControl *_itemsPageControl;
}

@end

@implementation RHToolView

- (instancetype)initWithItems:(NSArray *)items
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor colorWithHex:0xf8f8f8];
        
        NSUInteger itemCount = items.count;
        int row = 2;
        int col = 4;
        int countInOnePage = row * col;
        NSInteger pages = (itemCount + countInOnePage - 1) / countInOnePage;
        
        CGFloat margin = 8;
        CGFloat itemWidth = (kScreenWidth - 5 * margin) / 4;
        CGFloat itemHeight = 90;
        
        //
        _itemsScrollView = [[UIScrollView alloc] init];
        _itemsScrollView.delegate = self;
        _itemsScrollView.showsHorizontalScrollIndicator = NO;
        _itemsScrollView.showsVerticalScrollIndicator = NO;
        _itemsScrollView.pagingEnabled = YES;
        _itemsScrollView.contentSize = CGSizeMake(kScreenWidth * pages, 196);
        [self addSubview:_itemsScrollView];
        [_itemsScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self);
            make.width.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
        //
        for (NSInteger i=0; i<itemCount; i++) {
            RHToolItem *item = items[i];
            
            RHToolItemView *itemView = [[RHToolItemView alloc] initWithItem:item];
            [itemView.itemButtom addTarget:self action:@selector(doItemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [_itemsScrollView addSubview:itemView];
            [itemView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_itemsScrollView).offset(((i / 8) + 1) * margin + ((i / 2) * (margin + itemWidth)));
                make.top.equalTo(_itemsScrollView).offset(margin + ((i % 2) * (margin + itemHeight)));
                make.size.mas_offset(CGSizeMake(itemWidth, itemHeight));
            }];
        }
        
        //
        _itemsPageControl = [[UIPageControl alloc] init];
        _itemsPageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _itemsPageControl.currentPageIndicatorTintColor = [UIColor brownColor];
        _itemsPageControl.numberOfPages = pages;
        _itemsPageControl.currentPage = 0;
        [_itemsPageControl addTarget:self action:@selector(doPageControlChanged:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_itemsPageControl];
        [_itemsPageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.equalTo(self);
            make.height.equalTo(@(20));
            make.bottom.equalTo(self);
        }];
        
    }
    return self;
}

- (void)doItemButtonAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didItemButtonAction:)]) {
        [_delegate didItemButtonAction:sender];
    }
}

- (void)doPageControlChanged:(id)sender
{
    UIPageControl *pageControl = sender;
    RHLogLog(@"doPageControlChanged...%ld", (long)pageControl.currentPage);
    
    CGFloat pageWidth = CGRectGetWidth(_itemsScrollView.frame);
    CGPoint offset = _itemsScrollView.contentOffset;
    offset.x = pageWidth * pageControl.currentPage;
    [_itemsScrollView setContentOffset:offset animated:YES];
}

#pragma mark -
#pragma mark UIScrollViewDelegate method

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(scrollView.frame);
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger page = floor((offset - pageWidth / 2) / pageWidth) + 1;
    _itemsPageControl.currentPage = page;
}

@end
