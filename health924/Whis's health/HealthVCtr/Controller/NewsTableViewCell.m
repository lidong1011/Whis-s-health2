//
//  NewsTableViewCell.m
//  房贷计算机
//
//  Created by apple on 14-8-9.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "Configuration.h"

@implementation NewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _lable1=[[UILabel alloc]initWithFrame:CGRectMake(5, 2, 150,20)];
        [self.contentView addSubview:_lable1];
        
        _lable2=[[UILabel alloc]initWithFrame:CGRectMake(155, 2, 100,20)];
        _lable2.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_lable2];
        
        _lable3=[[UILabel alloc]initWithFrame:CGRectMake(5, 22, 240,40)];
        _lable3.numberOfLines=2;
        _lable3.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_lable3];

        _imageView1=[[UIImageView alloc]init];
        _imageView1.frame=CGRectMake(250, 3, 65, 62);
        [self.contentView addSubview:_imageView1];
        self.textLabel.backgroundColor=[UIColor clearColor];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    CGSize cellSize = self.bounds.size;
    _lable1.frame = CGRectMake(5, 0, cellSize.width/3*2-50, cellSize.height/3);
    _lable3.frame = CGRectMake(cellSize.width/3*2-30,0,70,cellSize.height/3);
    
    _lable2.frame = CGRectMake(5,cellSize.height/3, cellSize.width/3*2+10, cellSize.height/3*2);
    _lable2.numberOfLines = 2;
    _imageView1.frame=CGRectMake(cellSize.width/3*2+20, 3,cellSize.width/3-30,cellSize.height-6);
}

@end
