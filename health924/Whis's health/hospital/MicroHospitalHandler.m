//
//  MicroHospitalHandler.m
//  MicroHospital
//
//  Created by apple on 14-9-17.
//  Copyright (c) 2014年 Divein. All rights reserved.
//

#import "MicroHospitalHandler.h"

@interface MicroHospitalHandler ()
{
    UIScrollView *_scrollView;
    NSMutableArray *_cellArray;
}

@end

@implementation MicroHospitalHandler

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_scrollView];
        
        _numberOfColumns = 2;
        _cellArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)reloadData {
    
    for (UIView *v in _cellArray) {
        [v removeFromSuperview];
    }
    // 获取小视图的个数
    NSInteger count = [_dataSource numberOFViewInMicroHospital:self];
    
    CGFloat width = self.bounds.size.width / _numberOfColumns;
    CGFloat helgth = 60.0f;
    if (_dataSource && [_dataSource respondsToSelector:@selector(microHospital:cellHeigthAtIndex:)]) {
        helgth = [_dataSource microHospital:self cellHeigthAtIndex:0];
    }
    
    // 计算滚动视图的大小
    if (count % _numberOfColumns) {
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, (count/_numberOfColumns + 1)*helgth);
    } else {
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, count/_numberOfColumns  * helgth);
    }
    
    for (NSInteger i = 0; i<count; i++) {
        MicroHospitalCell *cell = [_dataSource microHospital:self cellAtIndex:i];
        [cell addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell.tag = i;
        
        CGFloat y = helgth * (i/_numberOfColumns);
        cell.frame = CGRectMake(width*(i%_numberOfColumns), y, width, helgth);
        [_scrollView addSubview:cell];
    }
}

- (void)setEdgeInset:(UIEdgeInsets)edgeInset {
    _edgeInset = edgeInset;
    self.frame = CGRectMake(self.frame.origin.x + edgeInset.left, self.frame.origin.y + edgeInset.top, self.frame.size.width - (edgeInset.right+edgeInset.left), self.frame.size.height - (edgeInset.bottom+edgeInset.top));
    // 让scrollView重新布局适应视图大小
    [self layoutIfNeeded];
}

- (void)didClicked:(MicroHospitalCell *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(microHospital:didSelectedIndex:)]) {
        [_delegate microHospital:self didSelectedIndex:sender.tag];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _scrollView.frame = self.bounds;
}

@end
