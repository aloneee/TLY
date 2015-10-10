

//
//  DDHomeECViewController.m
//  特洛伊
//
//  Created by liurihua on 15/10/10.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import "DDHomeECViewController.h"

@interface DDHomeECViewController ()

@end

@implementation DDHomeECViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"保养店铺";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ECTableViewDataSource


- (ExtensiveCell *)extensiveCellForRowIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"demoCell";
    ExtensiveCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = @"lalall";
    
    return cell;
}

- (CGFloat)heightForExtensiveCellAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (NSInteger)numberOfSections
{
    return 2;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 5;
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
            // Will instantiate the View on every opening/closing
            // The frame origin set to (10, 10) will create a margin-top and margin-left effect of 10 pixels.
            // Width 300 will do the rest (the full width of the screen is 320 = 300 + 10 + 10).
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
