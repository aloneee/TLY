//
//  ECViewController.m
//  ExtensiveCell
//
//  Created by Tanguy Hélesbeux on 02/11/2013.
//  Copyright (c) 2013 Tanguy Hélesbeux. All rights reserved.
//

#import "ECViewController.h"
#import "ExtensiveCellContainer.h"
#import "DDMaintanceDetailModel.h"

@interface ECViewController () <UITableViewDataSource, ExtensiveCellDelegate>

@property (strong, nonatomic) NSIndexPath *selectedRowIndexPath;

@end

@implementation ECViewController



-(NSMutableArray *)maintainanceModels{
    if (!_maintainanceModels) {
        _maintainanceModels = [NSMutableArray array];
        
        DDMaintanceDetailModel *model = [[DDMaintanceDetailModel alloc] init];
        model.titleStr = @"北京保时捷";
        model.price = @"300";
        model.originalPrice = @"500";
        model.distance = @"25.88";
        model.storeName = @"十八里店";
        
        [_maintainanceModels addObject:model];
        
        DDMaintanceDetailModel *model1 = [[DDMaintanceDetailModel alloc] init];
        model1.titleStr = @"北京保时捷";
        model1.price = @"400";
        model1.originalPrice = @"500";
        model1.distance = @"25.88";
        model1.storeName = @"十八里店";
        [_maintainanceModels addObject:model1];
        
        DDMaintanceDetailModel *model2 = [[DDMaintanceDetailModel alloc] init];
        model2.titleStr = @"北京保时捷";
        model2.price = @"500";
        model2.originalPrice = @"500";
        model2.distance = @"25.88";
        model2.storeName = @"十八里店";
        [_maintainanceModels addObject:model2];
        
        DDMaintanceDetailModel *model3 = [[DDMaintanceDetailModel alloc] init];
        model3.titleStr = @"北京保时捷";
        model3.price = @"600";
        model3.originalPrice = @"500";
        model3.distance = @"25.88";
        model3.storeName = @"十八里店";
        [_maintainanceModels addObject:model3];
        DDMaintanceDetailModel *model4 = [[DDMaintanceDetailModel alloc] init];
        model4.titleStr = @"北京保时捷";
        model4.price = @"700";
        model4.originalPrice = @"500";
        model4.distance = @"25.88";
        model4.storeName = @"十八里店";
        [_maintainanceModels addObject:model4];
        
        DDMaintanceDetailModel *model5 = [[DDMaintanceDetailModel alloc] init];
        model5.titleStr = @"北京保时捷";
        model5.price = @"800";
        model5.originalPrice = @"500";
        model5.distance = @"25.88";
        model5.storeName = @"十八里店";
        [_maintainanceModels addObject:model5];
        
    }
    return _maintainanceModels;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [ExtensiveCellContainer registerNibToTableView:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark Selection mecanism

- (void)setSelectedRowIndexPath:(NSIndexPath *)selectedRowIndexPath
{
    _selectedRowIndexPath = selectedRowIndexPath;
}

- (BOOL)isSelectedIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath && self.selectedRowIndexPath)
    {
        if (indexPath.row == self.selectedRowIndexPath.row && indexPath.section == self.selectedRowIndexPath.section)
        {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isExtendedCellIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath && self.selectedRowIndexPath)
    {
        if (indexPath.row == self.selectedRowIndexPath.row+1 && indexPath.section == self.selectedRowIndexPath.section)
        {
            return YES;
        }
    }
    return NO;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.selectedRowIndexPath && self.selectedRowIndexPath.section == section)
    {
        return [self numberOfRowsInSection:section] + 1;
    }
    return [self numberOfRowsInSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self numberOfSections];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *contentView = [self viewForContainerAtIndexPath:indexPath];
    if ([self isExtendedCellIndexPath:indexPath] && contentView) {
        return 2*contentView.frame.origin.y + contentView.frame.size.height;
    } else {
        return [self heightForExtensiveCellAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self isExtendedCellIndexPath:indexPath])
    {
        NSString *identifier = [ExtensiveCellContainer reusableIdentifier];
        ExtensiveCellContainer *cell = [tableView dequeueReusableCellWithIdentifier:identifier
                                                                       forIndexPath:indexPath];
        [cell addContentView:[self viewForContainerAtIndexPath:indexPath]];
        return cell;
    } else {
        ExtensiveCell *cell = [self extensiveCellForRowIndexPath:indexPath];
        if ([cell respondsToSelector:@selector(initializeWithTableViewController:)])
        {
            [cell initializeWithTableViewController:(UITableViewController *)self];
        }
        return cell;
    }
}

#pragma mark ExtensiveCellDelegate

- (void)shouldExtendCellAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (self.selectedRowIndexPath)
    {
        if ([self isSelectedIndexPath:indexPath])
        {
            NSIndexPath *tempIndexPath = self.selectedRowIndexPath;
            self.selectedRowIndexPath = nil;
            [self removeCellBelowIndexPath:tempIndexPath];
            
        } else {

            if (indexPath.row > self.selectedRowIndexPath.row) {
                indexPath = [NSIndexPath indexPathForRow:(indexPath.row-1)
                                               inSection:indexPath.section];
            }
            NSIndexPath *tempIndexPath = self.selectedRowIndexPath;
            self.selectedRowIndexPath = nil;
            [self removeCellBelowIndexPath:tempIndexPath];
        
            [self.tableView reloadRowsAtIndexPaths:@[tempIndexPath]
                                  withRowAnimation:UITableViewRowAnimationNone];
            
            self.selectedRowIndexPath = indexPath;;
            [self insertCellBelowIndexPath:indexPath];
            
        }
    } else {
        self.selectedRowIndexPath = indexPath;
        [self insertCellBelowIndexPath:indexPath];

    }

}

- (void)insertCellBelowIndexPath:(NSIndexPath *)indexPath
{
    indexPath = [NSIndexPath indexPathForRow:(indexPath.row+1)
                                   inSection:indexPath.section];
    
    NSArray *pathsArray = @[indexPath];
    
    DDMaintanceDetailModel *model = self.maintainanceModels[indexPath.row - 1];
    
    model.extend = YES;
    
    [self.tableView insertRowsAtIndexPaths:pathsArray
                          withRowAnimation:UITableViewRowAnimationFade];
    
    [self.maintainanceModels insertObject:[[DDMaintanceDetailModel alloc]init]
                                  atIndex:indexPath.row];
}

- (void)removeCellBelowIndexPath:(NSIndexPath *)indexPath
{
    indexPath = [NSIndexPath indexPathForRow:(indexPath.row+1)
                                   inSection:indexPath.section];
    
    NSArray *pathsArray = @[indexPath];
    DDMaintanceDetailModel *model = self.maintainanceModels[indexPath.row - 1];
    model.extend = NO;
    [self.maintainanceModels removeObjectAtIndex:indexPath.row];
    
    [self.tableView deleteRowsAtIndexPaths:pathsArray
                          withRowAnimation:UITableViewRowAnimationFade];

}

#pragma mark ECTableViewDataSource default

- (ExtensiveCell *)extensiveCellForRowIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (CGFloat)heightForExtensiveCellAtIndexPath:(NSIndexPath *)indexPath
{
    return MAIN_CELLS_HEIGHT;
}

- (NSInteger)numberOfSections
{
    return 0;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)viewForContainerAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}



@end
