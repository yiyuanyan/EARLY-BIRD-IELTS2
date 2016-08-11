//
//  Part2ContentTableViewController.m
//  EARLY-BIRD-IELTS2
//
//  Created by 何建新 on 16/8/3.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "Part2ContentTableViewController.h"
#import "Part2ContentTableViewCell.h"
#import "AFNetworking.h"


#define kWidth [UIScreen mainScreen].bounds.size.width
@interface Part2ContentTableViewController () <Part2ContentTableViewCellDelegate>
@property(nonatomic, strong)NSMutableArray *infoArray;
@property(nonatomic, assign)CGFloat height;
@property(nonatomic, strong)Part2ContentTableViewCell *cell;
@property(nonatomic, assign)BOOL cellHidden;
@end

@implementation Part2ContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"daohang_fanhui_tubia@2x(4)"] style:UIBarButtonItemStylePlain target: self action:@selector(goBack)];
    [self getJSON:[NSString stringWithFormat:@"http://test.benniaoyasi.cn/api.php?m=api&c=content&a=contentinfo&appid=1&mobile=18600562546&version=4.5.0&devtype=ios&uuid=29AD423E-F715-4B80-9D14-3B537E219D33&id=%@",self.cid]];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 自定义方法
-(void)choseTerm:(UIButton *)button
{
    NSLog(@"开始播放啦%d",button.tag);
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
-(void)getJSON:(NSString *)url{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"ecode"] isEqualToString:@"0"]){
            NSMutableArray *mArray = [NSMutableArray array];
            for(NSDictionary *d in responseObject[@"edata"]){
                [mArray addObject:d];
            }
            self.infoArray = mArray;
            //NSLog(@"%@",self.infoArray);
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(section == 0){
        return 1;
    }
    if(section == 1){
        //NSLog(@"%@",self.infoArray[0][@"part2List"]);
        return [self.infoArray[0][@"part2List"] count];
    }
    if(section == 2){
        return [self.infoArray[0][@"part3List"] count];
    }
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        CGSize strSize = [self getStringSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0) string:self.infoArray[0][@"title"] font:[UIFont systemFontOfSize:14]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, [UIScreen mainScreen].bounds.size.width, strSize.height)];
        label.text = self.infoArray[0][@"title"];
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        
        CGFloat cellHeight = label.frame.origin.y+label.frame.size.height+50;
        return cellHeight;
    }else if(indexPath.section == 1){
        CGSize strSize = [self getStringSize:CGSizeMake(kWidth, 0) string:self.infoArray[0][@"part2List"][indexPath.row][@"p2_english"] font:[UIFont systemFontOfSize:14]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kWidth-10, strSize.height)];
        label.numberOfLines = 0;
        label.text = self.infoArray[0][@"part2List"][indexPath.row][@"p2_english"];
        label.font = [UIFont systemFontOfSize:14];
        CGSize chStrSize = [self getStringSize:CGSizeMake(kWidth, 0) string:self.infoArray[0][@"part2List"][indexPath.row][@"p2_chines"] font:[UIFont systemFontOfSize:14]];
        UILabel *chLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kWidth-10, chStrSize.height)];
        chLabel.text = self.infoArray[0][@"part2List"][indexPath.row][@"p2_chines"];
        chLabel.font = [UIFont systemFontOfSize:14];
        chLabel.numberOfLines = 0;
        
        UIView *chView = [[UIView alloc] initWithFrame:CGRectMake(0, label.frame.origin.y+label.frame.size.height+60, kWidth, chLabel.frame.size.height+5)];
        chView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        [chView addSubview:chLabel];
        
        //返回高度和indexPath给控制器
        CGFloat cellHeight = chView.frame.origin.y+chView.frame.size.height;
        return cellHeight;
    }
    return 0;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    self.cell = [[Part2ContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    if(self.infoArray != nil){
        self.cell.index = indexPath;
        
        self.cell.infoArray = self.infoArray;
        
    }
    
    self.cell.delegate = self;
    
    return self.cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 0;
    }
    return 44;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    header.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, 44)];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(105, 0, 100, 44)];
    if(section == 1){
        label.text = @"Part2 Answer";
        label2.text = @"参考答案";
    }else if(section == 2){
        label.text = @"Part3 Answers";
        label2.text = @"必备素材";
    }
    
    
    label.font = [UIFont systemFontOfSize:14];
    label2.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor redColor];
    //label.textAlignment = NSTextAlignmentCenter;
    [header addSubview:label];
    [header addSubview:label2];
    return header;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(self.cellHidden == YES){
        self.cellHidden = NO;
       
    }else{
        self.cellHidden = YES;
        
    }
    NSLog(@"%hhd",self.cellHidden);
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
