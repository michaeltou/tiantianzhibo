//
//  MyCollectionViewViewController.m
//  tiantianzhibo
//
//  Created by michael on 22/8/2016.
//  Copyright © 2016 michael. All rights reserved.
//

#import "MyCollectionViewViewController.h"
#import "MyCollectionViewCell.h"


@interface MyCollectionViewViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@end

@implementation MyCollectionViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //_myCollectionView.delegate = self;
   // _myCollectionView.dataSource = self;
    
    
    [self.myCollectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionCell"];

    
    _myCollectionView.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view from its nib.
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(20*indexPath.row,20*indexPath.row);
}


//每个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"MyCollectionCell";
    
   
    
     MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //图片名称
    NSString *imageToLoad = [NSString stringWithFormat:@"porsche"];
    //加载图片
    cell.myImageView.image = [UIImage imageNamed:imageToLoad];
     
    return cell;
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
