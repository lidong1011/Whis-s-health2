//
//  Detail1ViewController.h
//  Whis's health
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Detail1ViewController : UIViewController
//@property(nonatomic,strong)void (^getDataHander)(Detail1ViewController *deVCtr,NSData *data);
@property(nonatomic,strong)void (^didHTMLHander)(Detail1ViewController *deVCtr,NSData *data);
@end
