//
//  CaiCaiViewController.m
//  CaiCai
//
//  Created by apple on 14-9-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CaiCaiViewController.h"
#import "CommonTableViewCell.h"
#import "CategoryView.h"
#import "DownDataManager.h"
#import "HTMLManager.h"
#import "UIImageView+WebCache.h"
#import "Configuration.h"
#import "DetailViewController.h"
@interface CaiCaiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIActivityIndicatorView *_activity;
    NSMutableArray *_mImgArray;
    NSDictionary *_dic;
    NSArray *_imgArray;
    
    CGSize kSize;
}
@end

@implementation CaiCaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initBackground];
    [self makeTable];
    
    [self getData];
//    _mImgArray  = [NSMutableArray arrayWithCapacity:10];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:kRefreshCData];
}

- (void)getData
{
    [[HTMLManager shareHtmlManager] getData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData:) name:kRefreshCData object:nil];
}

- (void)refreshData:(NSNotification *)not
{
    _dic = not.userInfo;
    _imgArray = [_dic objectForKey:@"imgData"];
    NSLog(@"%@",_dic);
    _tableView.dataSource = self;
    [_tableView reloadData];
    [_activity stopAnimating];
//    [_activity removeFromSuperview];
}

- (void)initBackground
{
//    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kSize.width, 50)];
//    titleLable.backgroundColor = [UIColor greenColor];
//    titleLable.text = @"从菜说健康";
//    titleLable.font = [UIFont systemFontOfSize:30];
//    titleLable.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:titleLable];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, 100, 50)];
    titleLab.font = [UIFont systemFontOfSize:26];
    titleLab.text = @"从饮食说健康";
    //    titleLab.backgroundColor = [UIColor redColor];
    titleLab.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLab;
    
    _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activity.center = self.view.center;
    [_activity startAnimating];
    _activity.color=[UIColor colorWithWhite:0.4 alpha:1];
    
}

- (void)initData
{
    kSize = self.view.bounds.size;
    _dic = [NSDictionary dictionary];
    _imgArray = [NSArray array];
}


#pragma mark
- (void)makeTable
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kSize.width, kSize.height-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
//    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    [self.view addSubview:_activity];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifier = @"cell";
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    int rowCount = (int)[self tableView:nil numberOfRowsInSection:0];
//    int count = (rowCount == (indexPath.row + 1))?(_mImgArray.count%3):3;
    
    //每个Cell里View的数目
    cell.numberOfViewInCell = ^NSInteger(CommonTableViewCell *sender){
        if(indexPath.row)
        {
            return 2;
        }
        else
        {
            return 3;
        }
    };
    //设置每个视图的宽度
    cell.widthForCell = ^CGFloat(CommonTableViewCell *sender, NSInteger index){
        return kSize.width/3;
    };
    //返回每个视图的对象
    cell.viewForCell = ^(CommonTableViewCell *sender, NSInteger index) {
        CategoryView *v = [[CategoryView alloc] initWithFrame:CGRectMake(0, 0,kSize.width/3, 100)];
        int imgIndex = _imgArray.count%3;
        [v.imageView sd_setImageWithURL:_imgArray[indexPath.section*5+indexPath.row*3+index]];
        
        
        return v;
    };
    //选取一个类别
    __weak typeof (self) weakSelf = self;
    __weak typeof(NSDictionary *) weakDic = _dic;
    cell.didSelectedView = ^(CommonTableViewCell *cell, NSInteger index){
        DetailViewController *detailViewCtr = [[DetailViewController alloc]init];
        detailViewCtr.urlStr = weakDic[@"detail"][indexPath.section*5+indexPath.row*3+index];
        detailViewCtr.titleStr = weakDic[@"title"][indexPath.section*5+indexPath.row*3+index];
        NSLog(@"%@--",detailViewCtr.urlStr);
        [weakSelf.navigationController pushViewController:detailViewCtr animated:YES];
//        [weakSelf presentViewController:detailViewCtr animated:NO completion:nil];
    };
    [cell reloadData];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, self.view.frame.size.width, 50)];
    label.font = [UIFont systemFontOfSize:20];
    label.backgroundColor = [UIColor orangeColor];
//    label.textColor = [UIColor colorWithRed:100.0/255 green:100.0/255 blue:100.0/255 alpha:1.0];
    
    switch (section) {
        case 0:
            label.text = @"食物相克";
            break;
        case 1:
            label.text = @"生活小窍门";
            break;
        case 2:
            label.text = @"办公室健康";
            break;
        default:
            break;
    }
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
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
