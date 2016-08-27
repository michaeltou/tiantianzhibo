//
//  OfferDetailEntryViewController.m
//  tiantianzhibo
//
//  Created by michael on 20/8/2016.
//  Copyright © 2016 michael. All rights reserved.
//

#import "OfferDetailEntryViewController.h"
#import "OfferDetailEntryTableViewCell.h"


#import "ODRefreshControl.h"
#import "NetWorkEngine.h"
#import "PlayerModel.h"

#import "UIImageView+WebCache.h"


// 映客接口
#define MainData [NSString stringWithFormat:@"http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=5&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=5&multiaddr=1"]

#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width


@interface OfferDetailEntryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, strong)NSMutableArray * dataArray;


@end

@implementation OfferDetailEntryViewController


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    // 添加下拉刷新
    [self addRefresh];
    
    // 加载数据
    [self loadData];
    
    [self addAdditionalButton];
 }


-(void)addAdditionalButton{
    
    //购买商品
    UIButton *showOfferDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    showOfferDetailBtn.frame = CGRectMake(10,10, 36, 36);
    [showOfferDetailBtn setImage:[UIImage imageNamed:@"NavBack"] forState:UIControlStateNormal];
    [showOfferDetailBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    showOfferDetailBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    showOfferDetailBtn.layer.shadowOffset = CGSizeMake(0, 0);
    showOfferDetailBtn.layer.shadowOpacity = 0.5;
    showOfferDetailBtn.layer.shadowRadius = 1;
    [self.view addSubview:showOfferDetailBtn];
    
    
}

-(void)goBack{
     [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)setupTableView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
     self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenW, ScreenH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 300;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
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
    
    double delayInSecinds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSecinds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [refreshController endRefreshing];
        [self loadData];
    });
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return 3;
    
    return _dataArray.count;

}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"OfferDetailEntryTableViewCell";
    
    OfferDetailEntryTableViewCell *cell =  (OfferDetailEntryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // WatchSelectOfferTableViewCell *cell =  (WatchSelectOfferTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell==nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OfferDetailEntryCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    PlayerModel * playerModel = [self.dataArray objectAtIndex:indexPath.row];
     
     [[cell myImageView] sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",playerModel.portrait]]];
    
    
    
    
    ///[cell viewWithTag:2]; set image
    // PlayerModel * playerModel = [self.dataArray objectAtIndex:indexPath.row];
    // cell.playerModel = playerModel;
    
    /*
     // Configure the cell…
     UILabel *textTarget;
     textTarget = (UILabel *)[cell viewWithTag:1]; //name
     textTarget.text = [[self.cellContent objectAtIndex:indexPath.row] objectAtIndex:0];
     textTarget = (UILabel *)[cell viewWithTag:2]; //addr1
     textTarget.text = [[self.cellContent objectAtIndex:indexPath.row] objectAtIndex:1];
     textTarget = (UILabel *)[cell viewWithTag:3]; //addr2
     textTarget.text = [[self.cellContent objectAtIndex:indexPath.row] objectAtIndex:2];
     textTarget = (UILabel *)[cell viewWithTag:4]; //phone
     textTarget.text = [[self.cellContent objectAtIndex:indexPath.row] objectAtIndex:3];
     textTarget = (UILabel *)[cell viewWithTag:5]; //cellPhone
     textTarget.text = [[self.cellContent objectAtIndex:indexPath.row] objectAtIndex:4];
     */
    
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
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
