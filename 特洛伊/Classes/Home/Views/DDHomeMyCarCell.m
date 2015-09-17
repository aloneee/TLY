//
//  DDHomeMyCarCell.m
//  特洛伊
//
//  Created by liurihua on 15/9/15.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import "DDHomeMyCarCell.h"
#import "DDHomeMyCar.h"
#import <UIImageView+WebCache.h>

@interface DDHomeMyCarCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *subTitleView;
@property (weak, nonatomic) IBOutlet UILabel *hint;


@end

@implementation DDHomeMyCarCell

- (void)awakeFromNib {
    // Initialization code
    
//    self.backgroundColor = [UIColor redColor];
    
}

-(void)setMyCar:(DDHomeMyCar *)myCar{
    _myCar = myCar;
    
//    self.iconImageView  sd_setImageWithURL:<#(NSURL *)#> placeholderImage:<#(UIImage *)#>  //setImage
    
    self.titleView.text = myCar.carTitle;
    self.subTitleView.text = myCar.carSubTitle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
    if (selected == YES) {
        [UIView animateWithDuration:0.25 animations:^{
            self.hint.alpha = 0.9;
        }];
    }else{
        self.hint.alpha = 0.0;
    }
}

+(DDHomeMyCarCell *)cellForTabelView:(UITableView *)tableView{
    
    static NSString *identifier  = @"myCarCell";
    DDHomeMyCarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DDHomeMyCarCell"
                                              owner:self
                                            options:nil]
                lastObject];
    }
    return cell;
}

@end
