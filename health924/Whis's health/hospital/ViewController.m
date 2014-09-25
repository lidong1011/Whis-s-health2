//
//  ViewController.m
//  MicroHospital
//
//  Created by apple on 14-9-17.
//  Copyright (c) 2014年 Divein. All rights reserved.
//

#import "ViewController.h"
#import "MicroHospitalHandler.h"
#import "MicroHospitalCell.h"
#import "DataManager.h"
#import "Configuration.h"
#import "UIImageView+WebCache.h"
#import "HospitalViewController.h"



@interface ViewController () <MicroHospitalHandlerDataSource, MicroHospitalHandlerDelegate>{
    NSArray *_tmpDataArr;
    NSMutableArray *_hrefArr;
    NSMutableArray *_srcArr;
    NSMutableArray *_name;
    
}
            

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIImage *image = [UIImage imageNamed:@"小草.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    [self.view addSubview:imageView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, 100, 50)];
    titleLab.font = [UIFont systemFontOfSize:26];
    titleLab.text = @"微医院";
    titleLab.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLab;
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:239/255.0 green:188/255.0 blue:209/255.0 alpha:1];
    self.navigationController.navigationBar.alpha = 0.5;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"绿色.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self initArray];
    [self getData];
    [self createMicroHospitalView];

}

- (void)initArray {
    _hrefArr = [NSMutableArray array];
    _srcArr = [NSMutableArray array];
    _name = [NSMutableArray array];
}

- (void)getData {
    [[DataManager sharedManager] mircoHospital];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRefresh:) name:kRefreshData2 object:nil];
    
}

- (void)didRefresh:(NSNotification *)notification {
    _tmpDataArr = [[DataManager sharedManager] mircoHospital];
//    NSLog(@"array : %@", _tmpDataArr);
    
    [_hrefArr addObjectsFromArray:[_tmpDataArr[0] valueForKey:@"href"]];
    NSLog(@"hrefArr : %@", _hrefArr);
    [_srcArr addObjectsFromArray:[_tmpDataArr[1] valueForKey:@"src"]];
    [_name addObjectsFromArray:[_tmpDataArr[2] valueForKey:@"name"]];
    [self createMicroHospitalView];
}

- (void)createMicroHospitalView {
    MicroHospitalHandler *microHospital = [[MicroHospitalHandler alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-108)];
    microHospital.dataSource = self;
    microHospital.delegate = self;
//    microHospital.edgeInset = UIEdgeInsetsMake(20, 10, 10, 10);
    microHospital.spacing = 0;
    microHospital.numberOfColumns = 4;
    [self.view addSubview:microHospital];
    [microHospital reloadData];
}

- (NSInteger)numberOFViewInMicroHospital:(MicroHospitalHandler *)MicroHospital {
    return 28;
}

- (MicroHospitalCell *)microHospital:(MicroHospitalHandler *)microHospital cellAtIndex:(NSInteger)index {
    MicroHospitalCell *cell = [[MicroHospitalCell alloc] initWithFrame:self.view.bounds];

    if (_tmpDataArr) {
        cell.imageView.frame = CGRectMake(20, 0, 60, 60);
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_srcArr[index]]];
        cell.label.frame = CGRectMake(10, 40, 80, 60);
        cell.label.textAlignment = NSTextAlignmentCenter;
        cell.label.text = _name[index];

    }
    
    return cell;
}

- (CGFloat)microHospital:(MicroHospitalHandler *)microHospital cellHeigthAtIndex:(NSInteger)index {
    return 100;
}

- (void)microHospital:(MicroHospitalHandler *)microHospital didSelectedIndex:(NSInteger)index  {
    HospitalViewController *HVC = [[HospitalViewController alloc] init];
    

    
    NSString *str = [NSString stringWithFormat:@"http://yy.15.cc%@", _hrefArr[index]];
    HVC.urlStr = str;

    [self.navigationController pushViewController:HVC animated:YES];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
