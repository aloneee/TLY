//
//  DDHomeIndividualMaintenanceViewCell.m
//  特洛伊
//
//  Created by liurihua on 15/9/18.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDHomeIndividualMaintenanceViewCell.h"


@interface DDHomeIndividualMaintenanceViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;


@end

@implementation DDHomeIndividualMaintenanceViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.selectedImage.image = [UIImage imageNamed:@"icon_chose_arrow_sel"];
    }else{
        self.selectedImage.image = [UIImage imageNamed:@"icon_chose_arrow_nor"];
    }
}

+(DDHomeIndividualMaintenanceViewCell *)cellForTabelView:(UITableView *)tableView{
    
    static NSString *identifier  = @"cell";
    DDHomeIndividualMaintenanceViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DDHomeIndividualMaintenanceViewCell"
                                              owner:self
                                            options:nil]
                lastObject];
        
    }
    
    return cell;
}

@end
