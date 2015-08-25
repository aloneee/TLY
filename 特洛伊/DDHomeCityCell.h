//
//  DDHomeCityCell.h
//  特洛伊
//
//  Created by liurihua on 15/8/24.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDHomeCityCell;

typedef void (^HomeCityCellReturnCityBlock)(DDHomeCityCell *);


@interface DDHomeCityCell : UITableViewCell

@property (nonatomic, copy) NSString                    *city;

@property (nonatomic, copy) HomeCityCellReturnCityBlock returnCityBlock;

+(DDHomeCityCell *)cellForTabelView:(UITableView *)tableView;

@end
