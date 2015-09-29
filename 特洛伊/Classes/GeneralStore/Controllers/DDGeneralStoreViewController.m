


//
//  DDGeneralStoreViewController.m
//  特洛伊
//
//  Created by liurihua on 15/9/21.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDGeneralStoreViewController.h"
#import "DDHomeMaintenanceDetailViewController.h"

//轮播图
#import "HMNewsCell.h"
#import "HMNews.h"
#import <MJExtension.h>
#import "DDFlowLayout.h"


#define HMCellIdentifier @"news"
#define HMMaxSections 100

#define kBtnMargin  10
#define kBtnW  (kScreen_Width - 5 * kBtnMargin) / 4
#define kBtnH  kScreen_Height * 0.25 * 0.5

@interface DDGeneralStoreViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic)   UICollectionView       *collectionView;
@property (weak, nonatomic)   UIPageControl          *pageControl;
@property (nonatomic, strong) NSArray                *newses;
@property (nonatomic, strong) NSTimer                *timer;

@end

@implementation DDGeneralStoreViewController

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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.contentInset = UIEdgeInsetsMake(kNavgationBarHeight + kScreen_Height * 0.25 + 2 * kBtnH, 0, kTabBarHeight, 0);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, - kScreen_Height * 0.25 - 2 * kBtnH, kScreenWidth, kScreenHeight * 0.25)
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
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenWidth - 120, CGRectGetMaxY(self.collectionView.frame) - 30, 100, 30)];
    [self.view addSubview:pageControl];
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor blueColor];
    self.pageControl = pageControl;
    [self.view bringSubviewToFront:self.pageControl];
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, -kScreen_Height * 0.25, kScreen_Width, kScreen_Height * 0.25)];
    container.backgroundColor = [UIColor clearColor];
    [self.view addSubview:container];
    
    for (int i = 0; i< 2; i++) {
        for (int j = 0; j < 4; j++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(kBtnMargin + j * (kBtnW + kBtnMargin), kScreen_Height * 0.25 * 0.5 * i, kBtnW, kBtnH);
            btn.layer.cornerRadius = 5;
            btn.backgroundColor = kRandomColor;
            
            [btn setTitle:@"换轮胎"
                 forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor whiteColor]
                      forState:UIControlStateNormal];

            [btn handleControlEvents:UIControlEventTouchUpInside
                           withBlock:^(id weakSender) {
                               
                NSLog(@"lalalal");
                
                DDHomeMaintenanceDetailViewController *md = [[DDHomeMaintenanceDetailViewController alloc] init];
                
                [self.navigationController pushViewController:md
                                                     animated:YES];
            }];
            [container addSubview:btn];
        }
    }
    
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
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        [self removeTimer];
    }
}

#pragma mark --- scrollViewDelegate
/**
 *  当用户停止拖拽的时候就调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        [self addTimer];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.newses.count;
        self.pageControl.currentPage = page;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"测试小酱油呀...00000";
    }else{
        cell.textLabel.text = @"测试小酱油呀...11111";
    }
    
    return cell;
}

#pragma mark -- helper
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
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
