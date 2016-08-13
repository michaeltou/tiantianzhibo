//
//  BigHallViewController.m
//  tiantianzhibo
//
//  Created by michael on 4/8/2016.
//  Copyright © 2016 michael. All rights reserved.
//

#import "BigHallViewController.h"

 #import "PlayerTableViewCell.h"
#import "ODRefreshControl.h"
#import "NetWorkEngine.h"
#import "PlayerModel.h"

#import "PlayerViewController.h"


#define Ratio 618/480

// 映客接口
#define MainData [NSString stringWithFormat:@"http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=5&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=5&multiaddr=1"]



@interface BigHallViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UINavigationItem *myNavigationItem;


@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;



@end

@implementation BigHallViewController



- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"DaTing view is loaeded");
    
    [self setupTableView];

    // 添加下拉刷新
    [self addRefresh];
    
    
    // 加载数据
    [self loadData];
    
}


#pragma mark ---- <加载数据>
- (void)loadData {
    [self.dataArray removeAllObjects];
    __weak __typeof(self)vc = self;
    NetWorkEngine * netWork = [[NetWorkEngine alloc] init];
    [netWork AfJSONGetRequest:MainData];
    netWork.successfulBlock = ^(id object){
        NSArray *listArray = [object objectForKey:@"lives"];
        
        for (NSDictionary *dic in listArray) {
            
            PlayerModel *playerModel = [[PlayerModel alloc] initWithDictionary:dic];
            playerModel.city = dic[@"city"];
            playerModel.portrait = dic[@"creator"][@"portrait"];
            playerModel.name = dic[@"creator"][@"nick"];
            playerModel.online_users = [dic[@"online_users"] intValue];
            playerModel.url = dic[@"stream_addr"];
            [vc.dataArray addObject:playerModel];
            
        }
        [self.tableView reloadData];
    };
}


#pragma mark ---- <添加下拉刷新>
- (void)addRefresh {
    
    ODRefreshControl *refreshController = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [refreshController addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
}

- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshController {
    NSLog(@"refreshing");
    double delayInSecinds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSecinds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        NSLog(@"begin refresh");
        [refreshController endRefreshing];
        [self loadData];
        NSLog(@"end refresh");
    });
}


#pragma mark ---- <setupTableView>
- (void)setupTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = [UIScreen mainScreen].bounds.size.width * Ratio + 1;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
}

#pragma mark ---- <数据源方法>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cell";
    PlayerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        
        cell = [[PlayerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PlayerModel * playerModel = [self.dataArray objectAtIndex:indexPath.row];
    cell.playerModel = playerModel;
    
    return cell;
    
    
}


#pragma mark ---- <点击跳转直播>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerViewController * playerVc = [[PlayerViewController alloc] init];
    PlayerModel * PlayerModel = self.dataArray[indexPath.row];
    // 直播url
    playerVc.liveUrl = PlayerModel.url;
    // 直播图片
    playerVc.imageUrl = PlayerModel.portrait;
    
    NSLog(PlayerModel.url);
    [self.navigationController pushViewController:playerVc animated:true];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

 


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
