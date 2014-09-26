//
//  HealthViewController.m
//  What's health
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HealthViewController.h"
#import "NewsTableViewCell.h"
#import "MyScrollView.h"
#import "NewsletterDataManager.h"
#import "SportItem.h"
#import "LunBoItem.h"

#import "Configuration.h"

#import "UIImageView+WebCache.h"

@interface HealthViewController ()<UITableViewDataSource,UITableViewDelegate,MyScrollViewDataSource,MyScrollViewDelegate>
{
    UITableView *_tableView;
    MyScrollView *_myScrollView;
    UIPageControl *_pageCtr;
    NSString *_string;
    NSMutableArray *_dataArray;
    NSMutableArray *_lunBoArray;
    NSArray *_listArray;
}
@end

@implementation HealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listArray = [NSArray arrayWithObjects:@8,@28,@8,@28,@32, nil];
    _string = [NSString stringWithFormat:@"http://phone.manle.com/yaodian.php?mod=info_channel_info_list&channel_id=%d&relevance=0&start=0&rows=&os=android&ver=4.2.3",[_listArray[_index] integerValue]];
//    _string = @"http://phone.manle.com/healthnews.php?mod=channel_lunbo&channel_id=8&os=android&ver=4.2.3";
    [self createTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRefresh:) name:kRefreshNewsletterData object:nil];

    [self getLunBoDataWithString:_string];
//    [self getData];
}

- (void)getLunBoDataWithString:(NSString *)string
{
    [[NewsletterDataManager shareManager] newsletterData:_string index:_index];
//    [[NewsletterDataManager shareManager] lunBoDataWithString:_string index:_index];
}

- (void)getData {
    
    [[NewsletterDataManager shareManager] newsletterData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRefresh:) name:kRefreshNewsletterData object:nil];
}

- (void)didRefresh:(NSNotification *)notification {
    _dataArray = [[NewsletterDataManager shareManager] newsletterData:_string index:_index];
//    _lunBoArray = [[NewsletterDataManager shareManager] lunBoDataWithString:_string index:_index];
    NSLog(@"%@", _dataArray);
    [_myScrollView reloadData];
    [_tableView reloadData];
}

- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kWidth, kHeight-49-44-40) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [self createTableViewHeader];
    [_tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}

- (UIView *)createTableViewHeader
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth,140)];
    
    _myScrollView = [[MyScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth,140)];
    _myScrollView.delegate = self;
    _myScrollView.dataSource = self;
    [headView addSubview:_myScrollView];
    
    _pageCtr = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 120, kWidth, 20)];
    
#ifdef DEBUG
    _pageCtr.numberOfPages = 3;
#endif
    [headView addSubview:_pageCtr];
    return headView;
}

#pragma mark-myscrollDelegate
- (NSInteger)numberOfPageInScrollView:(MyScrollView *)scrollView
{
    return _lunBoArray.count;
}

- (UIView *)scrollView:(MyScrollView *)scrollView viewAtIndex:(NSInteger)index
{
    LunBoItem *item = (LunBoItem *)_lunBoArray[index];
    UIImageView *imgView = [[UIImageView alloc]init];
    [imgView sd_setImageWithURL:[NSURL URLWithString:item.img]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 140 - 45, self.view.frame.size.width, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    label.text = item.title;
    [imgView addSubview:label];
    return imgView;
}

- (void)scrollView:(MyScrollView *)scrollView didSelectAtIndex:(NSInteger)index
{
    NSLog(@"%d",index);
}

- (void)scrollViewDidEndScroll:(MyScrollView *)scrollView
{
    _pageCtr.currentPage = scrollView.currentPage;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    SportItem *spor = [[SportItem alloc]init];
    spor = (SportItem *)_dataArray[indexPath.row];
    cell.lable1.text = spor.title;
    if (spor.like_count) {
        cell.lable3.text = [NSString stringWithFormat:@"%d赞",spor.like_count];
    }
    
    cell.lable2.text = spor.contents;
    [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:spor.img]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
