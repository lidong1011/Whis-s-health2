//
//  MyTableViewCell.m
//  HomeViewCtr-0915
//
//  Created by apple on 14-9-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    CGFloat kBoundsWidth = self.frame.size.width;
    CGFloat kBoundsHeight = self.frame.size.height;
    CGFloat kong = 5.0;
    CGFloat width = kBoundsWidth/3;
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _imgView = [[UIImageView alloc]init];
//        _imgView.backgroundColor = [UIColor redColor];
//        _imgView.image = [UIImage imageNamed:@"login.jpg"];
        [self.contentView addSubview:_imgView];
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(kong+width,0, kBoundsWidth-width-10, kBoundsHeight/2)];
        _titleLab.font = [UIFont systemFontOfSize:24];
        [self.contentView addSubview:_titleLab];
        
        _detailLab = [[UILabel alloc]initWithFrame:CGRectMake(kong+width,kBoundsHeight/3, kBoundsWidth-width-10, kBoundsHeight/2)];
        _detailLab.font = [UIFont systemFontOfSize:15];
        _detailLab.numberOfLines = 2;
        _detailLab.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:_detailLab];
        
        _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(kong+width,kBoundsHeight/3*2, kBoundsWidth-width-10, kBoundsHeight/2)];
        _timeLab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_timeLab];
        self.textLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    CGFloat kBoundsWidth = self.frame.size.width;
    CGFloat kBoundsHeight = self.frame.size.height;
//    NSLog(@"%@",NSStringFromCGSize(self.frame.size));
    CGFloat kong = 5.0;
    CGFloat width = kBoundsWidth/3;
    _imgView.frame = CGRectMake(kong,kong, kBoundsWidth/3, kBoundsHeight-2*kong);
//    NSLog(@"%@",NSStringFromCGRect(_imgView.frame));
    _titleLab.frame = CGRectMake(kong+width+3,0, kBoundsWidth-width-10, kBoundsHeight/3);
    _detailLab.frame = CGRectMake(kong+width+3,kBoundsHeight/3, kBoundsWidth-width-10, kBoundsHeight/3);
    _timeLab.frame = CGRectMake(kong+width+3,kBoundsHeight/3*2, kBoundsWidth-width-10, kBoundsHeight/3);
}

@end
