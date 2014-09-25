//
//  HomeViewController.m
//  HomeViewCtr-0915
//
//  Created by apple on 14-9-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailViewController.h"
#import "MyTableViewCell.h"
#import "DataManager.h"
#import "Configuration.h"
#import "UIImageView+WebCache.h"
#import "SVPullToRefresh.h"
#import "FMDatabase.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIButton *btn;
    NSArray *_tmpDataArr;
    NSMutableArray *_dataArr;
    
    
    NSMutableArray *_h2Arr;
    NSMutableArray *_pArr;
    NSMutableArray *_spanArr;
    NSMutableArray *_imgArr;
    NSMutableArray *_hrefArr;
    
    UIActivityIndicatorView *_activity;
    
    NSString *_dbPath;
    NSInteger _sectionNum;
    
//    CGFloat kWidth;
//    CGFloat kHeight;
    
}
@end

//static  int count = 1;

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    kWidth = self.view.bounds.size.width;
//    kHeight = self.view.bounds.size.height;
//    self.navigationItem.title = @"从饮食到健康";
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, 100, 50)];
    titleLab.font = [UIFont systemFontOfSize:26];
    titleLab.text = @"健康小常识";
//    titleLab.backgroundColor = [UIColor redColor];
    titleLab.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLab;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activity.center = self.view.center;
    [_activity startAnimating];
    _activity.color=[UIColor colorWithWhite:0.4 alpha:1];
//    _dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/healthData.db"];
    [self initArray];
    [self makeTableView];
    [self getData];
}

- (void)initArray {
    _h2Arr = [NSMutableArray array];
    _pArr = [NSMutableArray array];
    _spanArr = [NSMutableArray array];
    _imgArr = [NSMutableArray array];
    _hrefArr = [NSMutableArray array];
}

- (void)makeTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kWidth, kHeight-49) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:@"cell"];
    __weak typeof(self) mySelf = self;
    [_tableView addPullToRefreshWithActionHandler:^{

        [mySelf getMoreData];
        
    } position:SVPullToRefreshPositionBottom];
//    _tableView.tableFooterView = [self makeFoot];
    [self.view addSubview:_tableView];
    [self.view addSubview:_activity];
}

- (void)getData
{
//    [[DataManager sharedManager] commendSenceData];
    
    [self didRefresh:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRefresh:) name:kRefreshData object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
//    [_tableView triggerPullToRefresh];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:kRefreshData];
}

- (void)getMoreData
{
    [self didRefresh:nil];
}

- (void)didRefresh:(NSNotification *)notification {
    _tmpDataArr = [[DataManager sharedManager] commendSenceData];
    _dataArr = (NSMutableArray *)_tmpDataArr;
//    NSLog(@"---%@", _dataArr);

//    [_h2Arr addObject:[_dataArr[0] valueForKey:@"h2"]];
//    [_pArr addObject:[_dataArr[1] valueForKey:@"p"]];
//    [_spanArr addObject:[_dataArr[2] valueForKey:@"span"]];
//    [_imgArr addObject:[_dataArr[3] valueForKey:@"img"]];
//    [_hrefArr addObject:[_dataArr[4] valueForKey:@"href"]];
    [_h2Arr addObjectsFromArray:[_dataArr[0] valueForKey:@"h2"]];
    [_pArr addObjectsFromArray:[_dataArr[1] valueForKey:@"p"]];
    [_spanArr addObjectsFromArray:[_dataArr[2] valueForKey:@"span"]];
    [_imgArr addObjectsFromArray:[_dataArr[3] valueForKey:@"img"]];
    [_hrefArr addObjectsFromArray:[_dataArr[4] valueForKey:@"href"]];

    static int n=0;
    n++;
    if (n<70) {
        [_tableView reloadData];
    }
    [_activity stopAnimating];
    
    [_tableView.pullToRefreshView stopAnimating];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _h2Arr.count;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    static int i = 0;
//    i++;
//    if (i/4) {
//        count++;
//    }
//    return count;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier=@"cell";
    MyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (![_h2Arr isEqualToArray:@[]]) {
//        _sectionNum = count;
//        if (count > 0) {
//        _sectionNum-=1;
//        }
//        static int row = 0;
//        if (row == 100) {
//            row = 0;
//        }
        NSLog(@"section = %ld, row = %d", (long)indexPath.section, indexPath.row);
        NSLog(@"%@",_h2Arr[indexPath.row]);
//        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:_imgArr[_sectionNum][row]]];
//        cell.titleLab.text = _h2Arr[_sectionNum][row];
//        cell.detailLab.text = _pArr[_sectionNum][row];
//        cell.timeLab.text = _spanArr[_sectionNum][row];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:_imgArr[indexPath.row]]];
        cell.titleLab.text = _h2Arr[indexPath.row];
        cell.detailLab.text = _pArr[indexPath.row];
        cell.timeLab.text = _spanArr[indexPath.row];
//        row++;
}

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height / 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVCtr = [[DetailViewController alloc]init];
    detailVCtr.urlStr = _hrefArr[indexPath.row];
//    [self presentViewController:detailVCtr animated:YES completion:nil];
    detailVCtr.titleStr = _h2Arr[indexPath.row];
    [self.navigationController pushViewController:detailVCtr animated:YES];
}

- (UIView *)makeFoot
{
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0,self.view.bounds.size.width,44);
    [btn setTitle:@"加载更多..." forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getMoreData) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}



@end
