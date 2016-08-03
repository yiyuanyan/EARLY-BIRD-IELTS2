//
//  Part1ContentViewController.m
//  EARLY-BIRD-IELTS2
//
//  Created by 何建新 on 16/8/2.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "Part1ContentViewController.h"
#define kFont [UIFont systemFontOfSize:16]
#define kWidth self.view.bounds.size.width
@interface Part1ContentViewController ()
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIView *questionView;
@property(nonatomic, strong)UIView *p1_englishView;
@property(nonatomic, strong)UIView *p1_chinesView;

@property(nonatomic, strong) UIButton *anBtn;
@property(nonatomic, strong) UIButton *chBtn;

@end

@implementation Part1ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"daohang_fanhui_tubia@2x(4)"] style:UIBarButtonItemStylePlain target: self action:@selector(goBack)];
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, self.view.bounds.size.height)];
    [self.view addSubview:self.scrollView];
    [self createQuestionView];
    //默认questionView在屏幕垂直居中显示
    CGFloat y = ([UIScreen mainScreen].bounds.size.height/2 - self.questionView.frame.size.height/2) - self.questionView.frame.size.height/2;
    [self.questionView setFrame:CGRectMake(0, y, self.questionView.frame.size.width, self.questionView.frame.size.height)];
    [self createP1_englishView];
    //默认p1_englishView不显示
    self.p1_englishView.hidden = true;
    [self createP1_chinesView];
    //默认p1_chinesView不显示
    self.p1_chinesView.hidden = true;
    [self answersBtn];
    [self chineseBtn];
    // Do any additional setup after loading the view.
    NSLog(@"content----%@",self.contentDic);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 自定义方法
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
//问题View
-(void)createQuestionView{
    self.questionView = [[UIView alloc] initWithFrame:CGRectZero];
    CGSize strSize = [self boundingRectWithSize:CGSizeMake(kWidth, 0) string:self.contentDic[@"question"] font:[UIFont systemFontOfSize:18]];
    //view.backgroundColor = [UIColor lightGrayColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kWidth-10, strSize.height)];
    label.text = [NSString stringWithFormat:@"%@",self.contentDic[@"question"]];
    label.numberOfLines = 0;
    //label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:18];
    [self.questionView addSubview:label];
    
    UIView *luyinView = [[UIView alloc] initWithFrame:CGRectMake(0, label.frame.origin.y+label.frame.size.height+10, kWidth, 34)];
    //luyinView.backgroundColor = [UIColor blueColor];
    UIButton *luyinBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 86, 0, 34, 34)];
    [luyinBtn setImage:[UIImage imageNamed:@"luyin_press"] forState:UIControlStateNormal];
    [luyinBtn setImage:[UIImage imageNamed:@"luyin"] forState:UIControlStateHighlighted];
    
//    UIImageView *luyinImage = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth - 86, 0, 33, 33)];
//    luyinImage.image = [UIImage imageNamed:@"luyin_press"];
    UIButton *bofangBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 43, 0, 34, 34)];
    
    [bofangBtn setImage:[UIImage imageNamed:@"play_press"] forState:UIControlStateNormal];
    [bofangBtn setImage:[UIImage imageNamed:@"play-1"] forState:UIControlStateHighlighted];
    [bofangBtn addTarget:self action:@selector(bofang) forControlEvents:UIControlEventTouchUpInside];
//    UIImageView *bofangImage = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth - 43, 0, 33, 33)];
//    bofangImage.image = [UIImage imageNamed:@"luyin_press"];
    
    
    [luyinView addSubview:luyinBtn];
    [luyinView addSubview:bofangBtn];
    [self.questionView addSubview:luyinView];
    [self.questionView setFrame:CGRectMake(0, 0, kWidth, luyinView.frame.origin.y+luyinView.frame.size.height+10)];
    [self.scrollView addSubview:self.questionView];
    
}
//英文答案View
-(void)createP1_englishView{
    self.p1_englishView = [[UIView alloc] initWithFrame:CGRectZero];
    UIView *topBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
    topBorder.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [self.p1_englishView addSubview:topBorder];
    self.p1_englishView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    //文字Size
    CGSize strSize = [self boundingRectWithSize:CGSizeMake(kWidth, 0) string:self.contentDic[@"p1_english"] font:[UIFont systemFontOfSize:14]];
    //文字Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 6, kWidth-10, strSize.height)];
    label.text = self.contentDic[@"p1_english"];
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    
    [self.p1_englishView addSubview:label];
    
    UIView *luyinView = [[UIView alloc] initWithFrame:CGRectMake(0, label.frame.origin.y+label.frame.size.height+10, kWidth, 34)];
    
    UIButton *luyinBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 86, 0, 34, 34)];
    [luyinBtn setImage:[UIImage imageNamed:@"luyin_press"] forState:UIControlStateNormal];
    [luyinBtn setImage:[UIImage imageNamed:@"luyin"] forState:UIControlStateHighlighted];
    
    //    UIImageView *luyinImage = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth - 86, 0, 33, 33)];
    //    luyinImage.image = [UIImage imageNamed:@"luyin_press"];
    UIButton *bofangBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 43, 0, 34, 34)];
    
    [bofangBtn setImage:[UIImage imageNamed:@"play_press"] forState:UIControlStateNormal];
    [bofangBtn setImage:[UIImage imageNamed:@"play-1"] forState:UIControlStateHighlighted];
    [bofangBtn addTarget:self action:@selector(bofang) forControlEvents:UIControlEventTouchUpInside];
    //    UIImageView *bofangImage = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth - 43, 0, 33, 33)];
    //    bofangImage.image = [UIImage imageNamed:@"luyin_press"];
    
    
    [luyinView addSubview:luyinBtn];
    [luyinView addSubview:bofangBtn];
    
    [self.p1_englishView addSubview:luyinView];
    
    [self.p1_englishView setFrame:CGRectMake(0, self.questionView.frame.size.height, kWidth, luyinView.frame.origin.y+luyinView.frame.size.height+10)];
    
    [self.scrollView addSubview:self.p1_englishView];
}
//中文答案
-(void)createP1_chinesView{
    self.p1_chinesView = [[UIView alloc] initWithFrame:CGRectZero];
    self.p1_chinesView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    UIView *topBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
    topBorder.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [self.p1_chinesView addSubview:topBorder];
    //获取字符串size
    CGSize strSize = [self boundingRectWithSize:CGSizeMake(kWidth, 0) string:self.contentDic[@"p1_chines"] font:[UIFont systemFontOfSize:14]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 6, kWidth-10, strSize.height)];
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    label.text = self.contentDic[@"p1_chines"];
    [self.p1_chinesView addSubview:label];
    [self.p1_chinesView setFrame:CGRectMake(0, self.p1_englishView.frame.origin.y+self.p1_englishView.frame.size.height, kWidth, label.frame.size.height+10)];
    
    [self.scrollView addSubview:self.p1_chinesView];
    
}
//播放音频答案
-(void)bofang{
    NSLog(@"开始播放答案");
}
-(void)answersBtn{
    self.anBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height-112, kWidth/2 - 20, 30)];
    [self.anBtn setTitle:@"Answers" forState:UIControlStateNormal];
    [self.anBtn setTintColor:[UIColor whiteColor]];
    self.anBtn.backgroundColor = [UIColor redColor];
    [self.anBtn addTarget:self action:@selector(answersBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.anBtn];
}
-(void)answersBtnClick{
    if(self.chBtn.hidden){
        //旁边按钮隐藏了，则同时隐藏自己
        self.anBtn.hidden = true;
        [UIView animateWithDuration:0.3 animations:^{
            self.p1_englishView.hidden = false;
            [self.p1_englishView setFrame:CGRectMake(0, self.questionView.frame.origin.y+self.questionView.frame.size.height, self.p1_englishView.frame.size.width, self.p1_englishView.frame.size.height)];
            [self.p1_chinesView setFrame:CGRectMake(0, self.p1_englishView.frame.origin.y+self.p1_englishView.frame.size.height, self.p1_chinesView.frame.size.width, self.p1_chinesView.frame.size.height)];
        }];
        
        
        
    }else{
        self.anBtn.hidden = true;
        [UIView animateWithDuration:0.3 animations:^{
            [self.chBtn setFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height - 112, kWidth - 20, 30)];
        }];
        //questionView动画移动到顶部
        [UIView animateWithDuration:0.3 animations:^{
            [self.questionView setFrame:CGRectMake(0, 0, self.questionView.frame.size.width, self.questionView.frame.size.height)];
            [self.p1_englishView setFrame:CGRectMake(0, 0, self.p1_englishView.frame.size.width, self.p1_englishView.frame.size.height)];
            
        } completion:^(BOOL finished) {
            //显示英文答案
            sleep(0.3);
            [self.p1_englishView setFrame:CGRectMake(0, self.questionView.frame.origin.y+self.questionView.frame.size.height, self.p1_englishView.frame.size.width, self.p1_englishView.frame.size.height)];
            self.p1_englishView.hidden = false;
        }];
    }
}
-(void)chineseBtn{
    self.chBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth/2+10, self.view.frame.size.height-112, kWidth/2 - 20, 30)];
    
    [self.chBtn setTitle:@"Chinese" forState:UIControlStateNormal];
    [self.chBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //[chBtn.layer setMasksToBounds:YES];
    //[chBtn.layer setCornerRadius:10.0];
    [self.chBtn.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    [self.chBtn.layer setBorderColor:CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 })];
    [self.chBtn addTarget:self action:@selector(chineseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chBtn];
    
}
-(void)chineseBtnClick{
    if(self.anBtn.hidden){
        self.chBtn.hidden = true;
        //显示中文答案
        self.p1_chinesView.hidden = false;
    }else{
        self.chBtn.hidden = true;
        [UIView animateWithDuration:0.3 animations:^{
            [self.anBtn setFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height - 112, kWidth - 20, 30)];
            [self.questionView setFrame:CGRectMake(0, 0, self.questionView.frame.size.width, self.questionView.frame.size.height)];
        }];
        //显示中文答案
        CGFloat y = 0;
        if(self.p1_englishView.hidden == true){
            y = self.questionView.frame.origin.y + self.questionView.frame.size.height;
        }else{
            y = self.p1_englishView.frame.origin.y + self.p1_englishView.frame.size.height;
        }
        [UIView animateWithDuration:0.4 animations:^{
            [self.p1_chinesView setFrame:CGRectMake(0, y, self.p1_chinesView.frame.size.width, self.p1_chinesView.frame.size.height)];
            
            self.p1_chinesView.hidden = false;
        }];
        
    }
}
//计算文本高度
- (CGSize)boundingRectWithSize:(CGSize)size string:(NSString *)string font:(UIFont *)font
{
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
