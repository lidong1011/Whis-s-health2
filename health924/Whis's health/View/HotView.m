//
//  HotView.m
//  MyMangoTV
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "HotView.h"

@implementation HotView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
//        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 2;
        _label.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_label];
        
        _pingFenLabel = [[UILabel alloc] init];
        _pingFenLabel.numberOfLines = 2;
        _pingFenLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_pingFenLabel];
        
        _xing=[[TQStarRatingView alloc]initWithFrame:CGRectMake(8,22,60,15) numberOfStar:5];
        _xing.delegate=self;
//        _xing.backgroundColor=[];
        [self addSubview:_xing];
    }
    return self;
}

-(void)starRatingView:(TQStarRatingView *)view score:(float)score
{
    _pingFenLabel.text = [NSString stringWithFormat:@"%0.1f",score * 10 ];
}


//- (void)insertXingFlog:(int)flog mangXing:(int)mXShu banXing:(int)bXShu pingFen:(float)pingFen
//{
//    if (flog) {
//        UIImageView *xing1=[UIImageView alloc]ini
//    }
//    else
//    {
//        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width-8, 20)];
//        label.text=@"暂无评分";
//        [_xing addSubview:label];
//    }
//    
//}

//0. 不能手动调用！！！
//1. 改变它的frame/bounds的时候
//2. 调用它的setNeedsLayout
//3. addSubview:将它添加到父视图上时
//4. 父视图的frame/bounds改变的时候
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = CGRectMake(4, 4, self.frame.size.width-8, self.frame.size.height - 50);
    _label.frame = CGRectMake(4, self.frame.size.height -48, self.frame.size.width-8, 28);
    _xing.frame= CGRectMake(4, self.frame.size.height - 23, self.frame.size.width-28, 10);
    _pingFenLabel.frame=CGRectMake(self.frame.size.width-30, self.frame.size.height - 24, 28, 20);
//    [_xing setScore:0.5 withAnimation:NO];
}
@end
