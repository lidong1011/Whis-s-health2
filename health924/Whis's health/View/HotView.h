//
//  HotView.h
//  MyMangoTV
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQStarRatingView.h"
@interface HotView : UIView<StarRatingViewDelegate>

@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong, readonly) UILabel *label;
@property (nonatomic, strong, readonly) UILabel *pingFenLabel;
@property (nonatomic,strong,readonly)TQStarRatingView *xing;
@end
