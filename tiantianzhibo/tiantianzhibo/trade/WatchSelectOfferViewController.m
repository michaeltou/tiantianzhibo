//
//  WatchSelectOfferViewController.m
//  tiantianzhibo
//
//  Created by michael on 13/8/2016.
//  Copyright © 2016 michael. All rights reserved.
//

#import "WatchSelectOfferViewController.h"
#import "WatchSelectOfferTableViewCell.h"

@interface WatchSelectOfferViewController () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong)UITableView * tableView;


@end

@implementation WatchSelectOfferViewController

/*
- (IBAction)showOfferDetail:(id)sender {
    
    OfferDetailMainViewController  *offerDetailMainVc = [[OfferDetailMainViewController alloc] init];
    // [self presentViewController:offerVc animated:YES completion:nil];
    
       //这个很关键，增加子控制器，才能保证子页面的tableview在滑动时，不消失内容。这里是个坑。
     [self addChildViewController:offerDetailMainVc];
     
     
     _myOfferDetailView =   [offerDetailMainVc view];
     _myOfferDetailView.frame = CGRectMake(0,0, ScreenW, ScreenH);
     //[_mySelectOfferView setBackgroundColor:[UIColor clearColor]];
     [self.view addSubview:_myOfferDetailView];
     
    
    
    
}*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    
 
    
    // Do any additional setup after loading the view.
}


- (void)setupTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 140;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"WatchSelectOfferCell";
    
    WatchSelectOfferTableViewCell *cell =  (WatchSelectOfferTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // WatchSelectOfferTableViewCell *cell =  (WatchSelectOfferTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell==nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WatchSelectOfferCell" owner:self options:nil];
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
