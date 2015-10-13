//
//  ExtensiveCell.m
//  ExtensiveCell
//
//  Created by Tanguy Hélesbeux on 02/11/2013.
//  Copyright (c) 2013 Tanguy Hélesbeux. All rights reserved.
//

#import "ExtensiveCell.h"
#import "DDMaintanceDetailModel.h"


#pragma mark --- DDExtendView

@interface DDExtendView : UIView

@property(nonatomic, weak)    UILabel       *leftView;
@property(nonatomic, weak)    CAShapeLayer  *indicator;
@property(nonatomic, assign)  BOOL           extend;

@end

@implementation DDExtendView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)awakeFromNib{
    
    [self setupUI];
}

-(void)setupUI{
    
    UILabel *leftView = [[UILabel alloc] init];
    leftView.textAlignment = NSTextAlignmentRight;
    leftView.textColor = [UIColor lightGrayColor];
    leftView.font = [UIFont systemFontOfSize:12];
    leftView.text = @"查看详细方案";
    [self addSubview:leftView];
    self.leftView = leftView;

    CAShapeLayer *indicator = [[CAShapeLayer alloc] init];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(5, 5)];
    [path addLineToPoint:CGPointMake(10, 0)];
    [path closePath];
    indicator.path = path.CGPath;
    indicator.lineWidth = 0.8;
    indicator.fillColor = [UIColor lightGrayColor].CGColor;
    indicator.affineTransform = CGAffineTransformMakeRotation(M_PI);
    CGPathRef bound = CGPathCreateCopyByStrokingPath(indicator.path, nil, indicator.lineWidth, kCGLineCapButt, kCGLineJoinMiter, indicator.miterLimit);
    indicator.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    [self.layer addSublayer:indicator];
    self.indicator = indicator;
}

-(void)setExtend:(BOOL)extend{
    _extend = extend;
    if (!extend) {
        self.leftView.text = @"查看详细方案";
        self.indicator.affineTransform = CGAffineTransformMakeRotation(M_PI);
    }else{
        self.leftView.text = @"收起";
        self.indicator.affineTransform = CGAffineTransformIdentity;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.leftView.x = 0;
    self.leftView.y = 0;
    self.leftView.width = kScreen_Width * 0.5;
    self.leftView.height = self.height;

    
    self.indicator.position = CGPointMake(kScreen_Width * 0.52, self.height * 0.5);
}

@end


#pragma mark --- ExtensiveCell


@interface ExtensiveCell()
@property (weak, nonatomic) IBOutlet UILabel      *titleView;
@property (weak, nonatomic) IBOutlet UILabel      *priceView;
@property (weak, nonatomic) IBOutlet UILabel      *originalPriceView;
@property (weak, nonatomic) IBOutlet UILabel      *distanceView;
@property (weak, nonatomic) IBOutlet UILabel      *storeNameView;
@property (weak, nonatomic) IBOutlet DDExtendView *extendView;


@end

@implementation ExtensiveCell

-(void)awakeFromNib{
    
    [self.extendView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionHandler:^(UIGestureRecognizer *ges) {

        NSIndexPath *indexPath = [self.tableViewDelegate.tableView indexPathForCell:self];
        [self.tableViewDelegate shouldExtendCellAtIndexPath:indexPath];
        self.extendView.extend = !self.extendView.extend;

    }]];
}


- (void)initializeWithTableViewController:(UITableViewController *)tableViewController
{
    if ([tableViewController conformsToProtocol:@protocol(ExtensiveCellDelegate)])
    {
        self.tableViewDelegate = (UITableViewController<ExtensiveCellDelegate> *)tableViewController;
    }
}

-(void)setMatainanceDetailModel:(DDMaintanceDetailModel *)matainanceDetailModel{
    
    _matainanceDetailModel = matainanceDetailModel;
    self.titleView.text = matainanceDetailModel.titleStr;
    self.priceView.text = [NSString stringWithFormat:@"¥%@",matainanceDetailModel.price];
    self.originalPriceView.text = [NSString stringWithFormat:@"¥%@",matainanceDetailModel.originalPrice];
    self.distanceView.text = [NSString stringWithFormat:@"%@ km",matainanceDetailModel.distance];
    self.storeNameView.text = matainanceDetailModel.storeName;
    self.extendView.extend = matainanceDetailModel.extend;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
