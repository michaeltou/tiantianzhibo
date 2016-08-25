//
//  MakeOrderViewController.m
//  tiantianzhibo
//
//  Created by michael on 25/8/2016.
//  Copyright © 2016 michael. All rights reserved.
//

#import "MakeOrderViewController.h"

#import "MakeOrderTableViewCell.h"

@interface MakeOrderViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MakeOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (void)setupTableView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenW, ScreenH) style:UITableViewStylePlain];
    
    
    // self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //_tableView.delegate = self;
   // _tableView.dataSource = self;
    //_tableView.rowHeight = 500;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //[self.view addSubview:_tableView];
    
    
}
- (IBAction)goBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"MakeOrder";
    
    MakeOrderTableViewCell *cell =  (MakeOrderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // WatchSelectOfferTableViewCell *cell =  (WatchSelectOfferTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell==nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MakeOrder" owner:self options:nil];
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
    return 750;
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
