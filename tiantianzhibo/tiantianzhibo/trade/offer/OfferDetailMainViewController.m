//
//  OfferDetailMainViewController.m
//  tiantianzhibo
//
//  Created by michael on 20/8/2016.
//  Copyright © 2016 michael. All rights reserved.
//

#import "OfferDetailMainViewController.h"

#import "OfferDetailMainTableViewCell.h"
#import "OfferDetailEntryViewController.h"

#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width


@interface OfferDetailMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;

@property (weak, nonatomic) UIView *myOfferDetaiEntrylView;


@end

@implementation OfferDetailMainViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self addAdditionalButton];

 }


- (void)setupTableView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenW, ScreenH) style:UITableViewStylePlain];
    
    
   // self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 500;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
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


- (IBAction)showOfferEntry:(id)sender {
    
    NSLog(@"xxxxxx");
    
    
    OfferDetailEntryViewController  *offerDetailEntryVc = [[OfferDetailEntryViewController alloc] init];
    [self presentViewController:offerDetailEntryVc animated:YES completion:nil];
    
    /*   //这个很关键，增加子控制器，才能保证子页面的tableview在滑动时，不消失内容。这里是个坑。
     [self addChildViewController:offerDetailEntryVc];
     
     
     _myOfferDetaiEntrylView =   [offerDetailEntryVc view];
     _myOfferDetaiEntrylView.frame = CGRectMake(0,0, ScreenW, ScreenH);
     //[_mySelectOfferView setBackgroundColor:[UIColor clearColor]];
     [self.view addSubview:_myOfferDetaiEntrylView];
     
     
     */
    
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"OfferDetailMainTableViewCell";
    
    OfferDetailMainTableViewCell *cell =  (OfferDetailMainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // WatchSelectOfferTableViewCell *cell =  (WatchSelectOfferTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell==nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OfferDetailMainCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    return 1000;
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
