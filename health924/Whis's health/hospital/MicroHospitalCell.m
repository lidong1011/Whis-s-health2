//
//  MicroHospitalCell.m
//  MicroHospital
//
//  Created by apple on 14-9-17.
//  Copyright (c) 2014年 Divein. All rights reserved.
//

#import "MicroHospitalCell.h"

@implementation MicroHospitalCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        _label = [[UILabel alloc] init];
        [self addSubview:_label];
    
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
