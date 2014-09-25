//
//  CategoryView.m
//  MyMangoTV
//
//  Created by apple on 14-8-22.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "CategoryView.h"

@implementation CategoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _imageView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [self addSubview:_imageView];
    }
    return self;
}

- (void)layoutSubviews
{
    CGSize kSize = self.frame.size;
    _imageView.frame = CGRectMake(5,5,kSize.width-10, kSize.height-10);
}

@end
