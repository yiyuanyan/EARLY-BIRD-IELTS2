//
//  Part2ContentTableViewCell.m
//  EARLY-BIRD-IELTS2
//
//  Created by 何建新 on 16/8/3.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "Part2ContentTableViewCell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
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
    BOOL isH = NO;
    //问题cell
    if(self.index.section == 0){
        
            CGSize strSize = [self getStringSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0) string:infoArray[0][@"title"] font:[UIFont systemFontOfSize:14]];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, [UIScreen mainScreen].bounds.size.width, strSize.height)];
            label.text = infoArray[0][@"title"];
            label.font = [UIFont systemFontOfSize:14];
            label.numberOfLines = 0;
            UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, label.frame.origin.y+label.frame.size.height+6, [UIScreen mainScreen].bounds.size.width, 44)];
            
            UIButton *luyinBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 86, 0, 34, 34)];
            [luyinBtn setImage:[UIImage imageNamed:@"luyin_press"] forState:UIControlStateNormal];
            [luyinBtn setImage:[UIImage imageNamed:@"luyin"] forState:UIControlStateHighlighted];
            [luyinBtn addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
            luyinBtn.tag = 101;
            [btnView addSubview:luyinBtn];
            
            UIButton *bofangBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 43, 0, 34, 34)];
            [bofangBtn setImage:[UIImage imageNamed:@"play_press"] forState:UIControlStateNormal];
            [bofangBtn setImage:[UIImage imageNamed:@"play-1"] forState:UIControlStateHighlighted];
            [bofangBtn addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
            bofangBtn.tag = 102;
            [btnView addSubview:bofangBtn];
            //返回高度和indexPath给控制器
            [self.contentView addSubview:label];
            [self.contentView addSubview:btnView];
        
    }
    if(self.index.section == 1){
        CGSize strSize = [self getStringSize:CGSizeMake(kWidth, 0) string:infoArray[0][@"part2List"][self.index.row][@"p2_english"] font:[UIFont systemFontOfSize:14]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kWidth-10, strSize.height)];
        label.numberOfLines = 0;
        label.text = infoArray[0][@"part2List"][self.index.row][@"p2_english"];
        label.font = [UIFont systemFontOfSize:14];
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, label.frame.origin.y+label.frame.size.height+6, [UIScreen mainScreen].bounds.size.width, 44)];
        
        UIButton *luyinBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 86, 0, 34, 34)];
        [luyinBtn setImage:[UIImage imageNamed:@"luyin_press"] forState:UIControlStateNormal];
        [luyinBtn setImage:[UIImage imageNamed:@"luyin"] forState:UIControlStateHighlighted];
        [luyinBtn addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
        luyinBtn.tag = 101;
        [btnView addSubview:luyinBtn];
        
        UIButton *bofangBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 43, 0, 34, 34)];
        [bofangBtn setImage:[UIImage imageNamed:@"play_press"] forState:UIControlStateNormal];
        [bofangBtn setImage:[UIImage imageNamed:@"play-1"] forState:UIControlStateHighlighted];
        [bofangBtn addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
        bofangBtn.tag = 102;
        [btnView addSubview:bofangBtn];
        //中文答案
        //NSLog(@"%@",infoArray[0][@"part2List"][self.index.row]);
        CGSize chStrSize = [self getStringSize:CGSizeMake(kWidth, 0) string:infoArray[0][@"part2List"][self.index.row][@"p2_chines"] font:[UIFont systemFontOfSize:14]];
        UILabel *chLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kWidth-10, chStrSize.height)];
        chLabel.text = infoArray[0][@"part2List"][self.index.row][@"p2_chines"];
        chLabel.font = [UIFont systemFontOfSize:14];
        chLabel.numberOfLines = 0;
        UIView *chView = [[UIView alloc] initWithFrame:CGRectMake(0, btnView.frame.origin.y+btnView.frame.size.height+10, kWidth, chLabel.frame.size.height+5)];
        chView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        [chView addSubview:chLabel];
        
//        if(self.index.section == self.hiddenIndex.section && self.index.row == self.hiddenIndex.row){
//            if(chView.isHidden == YES){
//                chView.hidden = NO;
//            }else{
//                chView.hidden = YES;
//            }
//        }
//        if(isH == YES){
//            isH = NO;
//        }else{
//            isH = YES;
//        }
        NSLog(@"-----%hhd",isH);
        
        //chView.hidden = true;
        //NSLog(@"%@" ,self.index);
        [self.contentView addSubview:label];
        [self.contentView addSubview:btnView];
        [self.contentView addSubview:chView];
    }
    //NSLog(@"%@",infoArray);
}

-(void)checkAction:(UIButton *)sender{
    //NSLog(@"%@",sender);
    if([_delegate respondsToSelector:@selector(choseTerm:)]){
        sender.tag = self.tag;
        [_delegate choseTerm:sender];
    }
}
//获取字符串Size
-(CGSize)getStringSize:(CGSize)size string:(NSString *)string font:(UIFont *)font{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [string boundingRectWithSize:size
                                          options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    
    return retSize;
}
@end
