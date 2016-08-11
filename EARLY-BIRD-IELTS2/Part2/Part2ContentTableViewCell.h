//
//  Part2ContentTableViewCell.h
//  EARLY-BIRD-IELTS2
//
//  Created by 何建新 on 16/8/3.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Part2ContentTableViewCellDelegate<NSObject>
- (void)choseTerm:(UIButton *)button;

@end
@interface Part2ContentTableViewCell : UITableViewCell
@property(assign, nonatomic)id<Part2ContentTableViewCellDelegate> delegate;


@property(nonatomic, strong) NSArray *infoArray;
@property(nonatomic, assign) NSIndexPath *index;
@property(nonatomic, assign) BOOL cellHidden;

@end
