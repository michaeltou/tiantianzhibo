//
//  ScrollImageViewController.m
//  Test_bala
//
//  Created by michael on 16/8/2016.
//  Copyright © 2016 michael. All rights reserved.
//

#import "ScrollImageViewController.h"


#define ImageHeight [UIScreen mainScreen].bounds.size.height-400
#define ScrollScreenH [UIScreen mainScreen].bounds.size.height
#define ScrollScreenW [UIScreen mainScreen].bounds.size.width

@interface ScrollImageViewController ()<UIScrollViewDelegate>



@property(nonatomic, strong)NSArray  *arrayImages;          //存放图片的数组
@property(nonatomic, strong)NSMutableArray *viewController; //存放UIViewController的可变数组

@property(nonatomic, strong)UIScrollView  *scrollView;      //声明一个UIScrollView
@property(nonatomic, strong)UIPageControl *pageControl;     //声明一个UIPageControl

@property(nonatomic, strong)NSTimer *timer;



@end

@implementation ScrollImageViewController

 BOOL isFromStart;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.arrayImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"offer_detail1"],[UIImage imageNamed:@"offer_detail2"],[UIImage imageNamed:@"offer_detail3"],[UIImage imageNamed:@"offer_detail4"], nil];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,ImageHeight)];
    [_scrollView setPagingEnabled:YES];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [_scrollView setDelegate:self];
    [_scrollView setBackgroundColor:[UIColor lightGrayColor]];
    
    //ContentSize 这个属性对于UIScrollView挺关键的，取决于是否滚动。
    [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.frame) * [self.arrayImages count], ImageHeight)];
    [self.view addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.scrollView.frame.size.height - 20, ScrollScreenW, 20)];
    [_pageControl setBackgroundColor:[UIColor clearColor]];
    
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = [self.arrayImages count];
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    
    _viewController = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < [self.arrayImages count]; i++) {
        [_viewController addObject:[NSNull null]];
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollPages) userInfo:nil repeats:YES];
    
    [self loadScrollViewPage:0];
    [self loadScrollViewPage:1];
    [self loadScrollViewPage:2];
    [self loadScrollViewPage:3];
}



-(void)loadScrollViewPage:(NSInteger)page
{
    if (page >= self.arrayImages.count) {
        return;
    }
    
    
    
    UIViewController *imageViewController = [self.viewController objectAtIndex:page];
    if ((NSNull *)imageViewController == [NSNull null])
    {
        imageViewController = [[UIViewController alloc] init];
        [self.viewController replaceObjectAtIndex:page withObject:imageViewController];
    }
    
    //if (imageViewController.view.superview == nil) {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;
        frame.origin.y = 0;
        imageViewController.view.frame = frame;
        
     //   [self addChildViewController:imageViewController];
        [self.scrollView addSubview:imageViewController.view];
        //[imageViewController didMoveToParentViewController:self];
        
        
       UIImage *myImage =  (UIImage *)[self.arrayImages objectAtIndex:page];
        
        NSLog(@"current page is:%ld",(long)page);
        UIImageView  *myImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,  ScrollScreenW,ImageHeight)];
        
        //需要设置图片 UIImage
        
        [myImageView setImage:myImage];
        
        
        
        
        [imageViewController.view addSubview:myImageView];
        
        
      //  [imageViewController.view setBackgroundColor:[UIColor colorWithPatternImage:(UIImage *)[self.arrayImages objectAtIndex:page]]];
 
        
 
   // }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSInteger page = floor((self.scrollView.contentOffset.x -pageWidth/2)/pageWidth) +1;
    self.pageControl.currentPage = page;
    
    [self loadScrollViewPage:page-1];
    [self loadScrollViewPage:page];
    [self loadScrollViewPage:page+1];
}

- (IBAction)changePage:(id)sender
{
    NSInteger page = self.pageControl.currentPage;
    
    [self loadScrollViewPage:page - 1];
    [self loadScrollViewPage:page];
    [self loadScrollViewPage:page + 1];
    
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = 0;
    [self.scrollView scrollRectToVisible:bounds animated:YES];
}


-(void)scrollPages{
    ++self.pageControl.currentPage;
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    if (isFromStart) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        self.pageControl.currentPage = 0;
    }
    else
    {
        [self.scrollView setContentOffset:CGPointMake(pageWidth*self.pageControl.currentPage, self.scrollView.bounds.origin.y)];
        
    }
    if (_pageControl.currentPage == _pageControl.numberOfPages - 1) {
        isFromStart = YES;
    }
    else
    {
        isFromStart = NO;
    }
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
