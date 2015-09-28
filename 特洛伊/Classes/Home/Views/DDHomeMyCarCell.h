//
//  DDHomeMyCarCell.h
//  特洛伊
//
//  Created by liurihua on 15/9/15.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class DDHomeMyCar;

@interface DDHomeMyCarCell : UITableViewCell

@property (nonatomic, strong) DDHomeCar *myCar;

+(DDHomeMyCarCell *)cellForTabelView:(UITableView *)tableView;

@end
