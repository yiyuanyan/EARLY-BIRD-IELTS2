//
//  Part2ContentTableViewCell.m
//  EARLY-BIRD-IELTS2
//
//  Created by 何建新 on 16/8/3.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "Part2ContentTableViewCell.h"

@implementation Part2ContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setInfoArray:(NSArray *)infoArray
{
    NSLog(@"%@",infoArray);
}
@end
