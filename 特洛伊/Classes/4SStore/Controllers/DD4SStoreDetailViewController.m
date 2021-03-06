//
//  DD4SStoreDetailViewController.m
//  特洛伊
//
//  Created by liurihua on 15/9/18.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DD4SStoreDetailViewController.h"
#import "DD4SStoreCommentViewController.h"
#import "DDCountView.h"


//轮播图
#import "HMNewsCell.h"
#import "HMNews.h"
#import <MJExtension.h>
#import "DDFlowLayout.h"

#define HMCellIdentifier @"news"
#define HMMaxSections 100

@interface DD4SStoreDetailViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic)   UICollectionView       *collectionView;
@property (weak, nonatomic)   UIPageControl          *pageControl;
@property (nonatomic, strong) NSArray                *newses;
@property (nonatomic, strong) NSTimer                *timer;

@end

@implementation DD4SStoreDetailViewController

#pragma mark -- lazy load
- (NSArray *)newses
{
    if (_newses == nil) {
        self.newses = [HMNews objectArrayWithFilename:@"newses.plist"];
        self.pageControl.numberOfPages = self.newses.count;
        NSLog(@"%@",self.newses);
    }
    return _newses;
}

#pragma mark --- life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavgationBarHeight, kScreen_Width, kScreen_Height * 0.25)
                                                          collectionViewLayout:[[DDFlowLayout alloc] init]];
    collectionView.backgroundColor = [UIColor redColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"HMNewsCell"
                                                    bundle:nil]
          forCellWithReuseIdentifier:HMCellIdentifier];
    // 默认显示最中间的那组
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0
                                                                     inSection:HMMaxSections/2]
                                atScrollPosition:UICollectionViewScrollPositionLeft
                                        animated:NO];
    
    
    // 添加定时器
    [self addTimer];
    
    //pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreen_Width - 120, kScreen_Height * 0.25 - 30 + kNavgationBarHeight, 100, 30)];
    [self.view addSubview:pageControl];
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor blueColor];
    self.pageControl = pageControl;
    [self.view bringSubviewToFront:self.pageControl];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 250, 100, 100);
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = [UIColor redColor];
    
    [btn setTitle:@"not so fast "
         forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor]
              forState:UIControlStateNormal];
    
    [btn handleControlEvents:UIControlEventTouchUpInside
                   withBlock:^(id weakSender) {
                       
         DD4SStoreCommentViewController *comment = [[UIStoryboard storyboardWithName:@"Main"
                                                                              bundle:nil] instantiateViewControllerWithIdentifier:@"commentVC"];
         [self.navigationController pushViewController:comment
                                              animated:YES];
    }];
    
    [self.view addSubview:btn];
    
    DDCountView *countView = [[DDCountView alloc]init];
    countView.frame = CGRectMake(100, CGRectGetMaxY(btn.frame) + 20, 100, 50);
    countView.count = 1;
    countView.minCount = -11;
    countView.maxCount = 11;
    countView.backgroundColor = [UIColor yellowColor];
    
    countView.block = ^(DDCountView *c){
        NSLog(@"%ld",c.count);
    };
    
    [self.view addSubview:countView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.newses.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return HMMaxSections;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HMNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HMCellIdentifier forIndexPath:indexPath];
    
    cell.news = self.newses[indexPath.item];
    
    return cell;
}

#pragma mark  - UICollectionViewDelegate
/**
 *  当用户即将开始拖拽的时候就调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

#pragma mark --- scrollViewDelegate
/**
 *  当用户停止拖拽的时候就调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    NSLog(@"scrollViewDidEndDragging--松开");
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.newses.count;
    self.pageControl.currentPage = page;
}

#pragma mark --- helper
/**
 *  添加定时器
 */
- (void)addTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                       block:^{
                                                           
        // 1.马上显示回最中间那组的数据
        NSIndexPath *currentIndexPathReset = [self resetIndexPath];
        
        // 2.计算出下一个需要展示的位置
        NSInteger nextItem = currentIndexPathReset.item + 1;
        NSInteger nextSection = currentIndexPathReset.section;
        if (nextItem == self.newses.count) {
            nextItem = 0;
            nextSection++;
        }
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem
                                                         inSection:nextSection];
        
        // 3.通过动画滚动到下一个位置
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath
                                    atScrollPosition:UICollectionViewScrollPositionLeft
                                            animated:YES];
    }
                                                     repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer
                              forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

/**
 *  移除定时器
 */
- (void)removeTimer
{
    // 停止定时器
    [self.timer invalidate];
    self.timer = nil;
}

- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item
                                                             inSection:HMMaxSections/2];
    
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset
                                atScrollPosition:UICollectionViewScrollPositionLeft
                                        animated:NO];
    return currentIndexPathReset;
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
