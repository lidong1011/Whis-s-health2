//
//  HealthNews.m
//  HealthNews-0923
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HealthNews.h"
#import "HealthViewController.h"
@interface HealthNews()<ViewPagerDelegate,ViewPagerDataSource>

@end

@implementation HealthNews
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = self;
    self.delegate = self;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, 100, 50)];
    titleLab.font = [UIFont systemFontOfSize:26];
    titleLab.text = @"健康资讯";
    //    titleLab.backgroundColor = [UIColor redColor];
    titleLab.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLab;
//    self.navigationItem.title = @"健康资讯"
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return 4;
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.0];
    label.text = [NSString stringWithFormat:@"Tab #%i", index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}

#pragma mark - ViewPagerDataSource
- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    HealthViewController *cvc = [[HealthViewController alloc]init];
    cvc.index = index;
    NSLog(@"%d",index);
    cvc.view.backgroundColor = [UIColor whiteColor];
    return cvc;
}

- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index {
    
    // Do something useful
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
        case ViewPagerOptionTabLocation:
            return 1.0;
        case ViewPagerOptionTabHeight:
            return 40.0;
        case ViewPagerOptionTabOffset:
            return 0.0;
//        case ViewPagerOptionTabWidth:
//            return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ?  : 100.0;
        case ViewPagerOptionFixFormerTabsPositions:
            return 0.0;
        case ViewPagerOptionFixLatterTabsPositions://自动修正在后
            return 0.0;
        default:
            return value;
    }
}

- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
        case ViewPagerTabsView:
            return [[UIColor lightGrayColor] colorWithAlphaComponent:0.32];
        case ViewPagerContent:
            return [[UIColor darkGrayColor] colorWithAlphaComponent:0.32];
        default:
            return color;
    }
}


@end
