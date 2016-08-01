//
//  Part1TableViewController.m
//  EARLY-BIRD-IELTS2
//
//  Created by 何建新 on 16/8/1.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "Part1TableViewController.h"
#import "Part1ListTableViewController.h"
#import "AFNetworking.h"
@interface Part1TableViewController ()
@property(nonatomic, strong)NSArray *infoArray;
@end

@implementation Part1TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入了Part1");
    self.infoArray = [NSArray array];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"daohang_fanhui_tubia@2x(4)"] style:UIBarButtonItemStylePlain target: self action:@selector(goBack)];
    NSString *url = @"";
    if(self.aid != nil){
        url = [NSString stringWithFormat:@"http://test.benniaoyasi.cn/api.php?c=content&a=listcontent_part2_3&mobile=18600562546&version=4.5.0&devtype=ios&uuid=29AD423E-F715-4B80-9D14-3B537E219D33&leval=%@&appid=1&pageindex=0&pagenum=10",self.leval];
    }else{
        url = [NSString stringWithFormat:@"http://test.benniaoyasi.cn/api.php?m=api&c=category&a=listcategory&appid=1&version=4.5.0&devtype=ios&leval=%@",self.leval];
    }
    
    [self getJSON:url];
    [self clearExtraLine:self.tableView];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 自定义方法
-(void)clearExtraLine:(UITableView *)tableView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}
-(void)getJSON:(NSString *)string{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:string parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"ecode"] isEqualToString:@"0"]){
            NSMutableArray *mArray = [NSMutableArray array];
            for(NSDictionary *d in responseObject[@"edata"]){
                [mArray addObject:d];
            }
            self.infoArray = mArray;
            
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.infoArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.infoArray[indexPath.row][@"english"];
    cell.textAlignment = NSTextAlignmentCenter;
    // Configure the cell...
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Part1ListTableViewController *part1List = [[Part1ListTableViewController alloc] init];
    part1List.cid = self.infoArray[indexPath.row][@"id"];
    part1List.title = self.infoArray[indexPath.row][@"english"];
    [self.navigationController pushViewController:part1List animated:YES];
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
