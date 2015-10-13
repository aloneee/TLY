

//
//  DDHomeECViewController.m
//  特洛伊
//
//  Created by liurihua on 15/10/10.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import "DDHomeECViewController.h"
#import "DDMaintanceDetailModel.h"

#define normalFont [UIFont systemFontOfSize:15]
#define lightFont  [UIFont systemFontOfSize:12]

@interface DDDetailView : UIView

@property(nonatomic, weak) UILabel    *preferentialHint;
@property(nonatomic, weak) UITextView *preferentialTextView;

@property(nonatomic, weak) UILabel    *deadlineHint;
@property(nonatomic, weak) UILabel    *deadlineLabel;
@property(nonatomic, weak) UILabel    *restDaysLabel;

@property(nonatomic, weak) UILabel    *contactHint;
@property(nonatomic, weak) UILabel    *addressLabel;

@property(nonatomic, strong) DDMaintanceDetailModel *detailModel;

@end

@implementation DDDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        UILabel *preferentialHint = [[UILabel alloc] init];
        preferentialHint.text = @"优惠说明";
        preferentialHint.font = normalFont;
        [self addSubview:preferentialHint];
        self.preferentialHint = preferentialHint;
        
        UITextView *preferentialTextView = [[UITextView alloc] init];
        preferentialTextView.textColor = [UIColor lightGrayColor];
        preferentialTextView.font = lightFont;
        [self addSubview:preferentialTextView];
        self.preferentialTextView = preferentialTextView;
        
        UILabel *deadlineHint = [[UILabel alloc] init];
        deadlineHint.text = @"有效期至";
        deadlineHint.font = normalFont;
        [self addSubview:deadlineHint];
        self.deadlineHint = deadlineHint;
        
        UILabel *deadlineLabel = [[UILabel alloc] init];
        deadlineLabel.font = lightFont;
        deadlineLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:deadlineLabel];
        self.deadlineLabel = deadlineLabel;
        
        UILabel *restDaysLabel = [[UILabel alloc] init];
        restDaysLabel.textColor = [UIColor orangeColor];
        restDaysLabel.font = lightFont;
        [self addSubview:restDaysLabel];
        self.restDaysLabel = restDaysLabel;
        
    }
    
    return self;
}

@end


@interface DDHomeECViewController ()


@end

@implementation DDHomeECViewController

#pragma mark --- lazyload


#pragma mark --- lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"保养店铺";
    self.automaticallyAdjustsScrollViewInsets = NO;

}


#pragma mark ECTableViewDataSource

- (ExtensiveCell *)extensiveCellForRowIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"demoCell";
    ExtensiveCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.matainanceDetailModel = self.maintainanceModels[indexPath.row];
    
    return cell;
}

- (CGFloat)heightForExtensiveCellAtIndexPath:(NSIndexPath *)indexPath
{
    return 129;
}


- (NSInteger)numberOfSections
{
    return 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.maintainanceModels.count;
}





- (UIView *)viewForContainerAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 1:
        {
            // Will instantiate the DatePickerView on every opening/closing
            UIView *dropDownView = [[UIDatePicker alloc] init];
            return dropDownView;
        }
        case 2:
        {
            // Will instantiate the MapView once. Best way for better performances.
            return nil;
        }
        case 3:
        {
    
            UIView *dropDownView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreen_Width, 88)];
            dropDownView.backgroundColor = [UIColor redColor];
            return dropDownView;
        }
        case 4:
        {
            // Will instantiate the View on every opening/closing
            UIView *dropDownView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 88)];
            dropDownView.backgroundColor = [UIColor blueColor];
            return dropDownView;
        }
            
        default:
            return nil;
    }
}


@end
