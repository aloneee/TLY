//
//  DDHomeCityCell.m
//  特洛伊
//
//  Created by liurihua on 15/8/24.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDHomeCityCell.h"

@interface DDHomeCityCell ()

@property (weak, nonatomic) IBOutlet UILabel *cityNameView;
@property (weak, nonatomic) IBOutlet UIButton *donebtn;


@end

@implementation DDHomeCityCell

- (void)awakeFromNib {
    // Initialization code
    
    self.donebtn.alpha = 0.0f;
}

-(void)setCity:(NSString *)city{
    _city = city;
    self.cityNameView.text = city;
}

+(DDHomeCityCell *)cellForTabelView:(UITableView *)tableView{
    
    static NSString *identifier  = @"cityCell";
    DDHomeCityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DDHomeCityCell" owner:self options:nil] lastObject];
    }
    
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected == YES) {
        [UIView animateWithDuration:0.25f animations:^{
            self.donebtn.alpha = 0.9f;
        }];
    }else{
        self.donebtn.alpha = 0.0f;
    }
}

-(void)setReturnCityBlock:(HomeCityCellReturnCityBlock)returnCityBlock{
    _returnCityBlock = returnCityBlock;
}

- (IBAction)returnCity:(id)sender {
   
    _returnCityBlock(self);
}

@end
