//
//  ExtensiveCell.h
//  ExtensiveCell
//
//  Created by Tanguy Hélesbeux on 02/11/2013.
//  Copyright (c) 2013 Tanguy Hélesbeux. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DDMaintanceDetailModel;


@protocol ExtensiveCellDelegate;

@interface ExtensiveCell : UITableViewCell

@property (nonatomic, strong) DDMaintanceDetailModel *matainanceDetailModel;

@property (nonatomic, weak) IBOutlet UITableViewController<ExtensiveCellDelegate>  *tableViewDelegate;

- (void)initializeWithTableViewController:(UITableViewController *)tableViewController;

@end

@protocol ExtensiveCellDelegate <NSObject>

@optional
- (void)shouldExtendCellAtIndexPath:(NSIndexPath *)indexPath;

@end


