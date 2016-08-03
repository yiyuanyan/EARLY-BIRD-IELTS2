//
//  Part2TableViewController.m
//  EARLY-BIRD-IELTS2
//
//  Created by 何建新 on 16/8/1.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "Part2TableViewController.h"
#import "Part2ContentTableViewController.h"
#import "AFNetworking.h"
@interface Part2TableViewController ()
@property(nonatomic, strong)NSArray *infoArray;
@end

@implementation Part2TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入了Part2");
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"daohang_fanhui_tubia@2x(4)"] style:UIBarButtonItemStylePlain target: self action:@selector(goBack)];
    NSString *url = [NSString stringWithFormat:@"http://test.benniaoyasi.cn/api.php?c=content&a=listcontent_part2_3&mobile=18600562546&version=4.5.0&devtype=ios&uuid=29AD423E-F715-4B80-9D14-3B537E219D33&leval=%@&appid=1&pageindex=0&pagenum=10",self.leval];
    [self getJSON:url];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 自定义方法
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getJSON:(NSString *)url{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.infoArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d.%@",indexPath.row+1,self.infoArray[indexPath.row][@"question"]];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Part2ContentTableViewController *part2View = [[Part2ContentTableViewController alloc] init];
    part2View.cid = self.infoArray[indexPath.row][@"id"];
    part2View.title = self.infoArray[indexPath.row][@"question"];
    [self.navigationController pushViewController:part2View animated:YES];
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
