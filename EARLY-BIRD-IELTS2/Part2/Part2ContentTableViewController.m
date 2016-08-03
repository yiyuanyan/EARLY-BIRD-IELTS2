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
@interface Part2ContentTableViewController ()
@property(nonatomic, strong)NSArray *infoArray;
@end

@implementation Part2ContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"daohang_fanhui_tubia@2x(4)"] style:UIBarButtonItemStylePlain target: self action:@selector(goBack)];
    [self getJSON:[NSString stringWithFormat:@"http://test.benniaoyasi.cn/api.php?m=api&c=content&a=contentinfo&appid=1&mobile=18600562546&version=4.5.0&devtype=ios&uuid=29AD423E-F715-4B80-9D14-3B537E219D33&id=%@",self.cid]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 自定义方法
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
            NSLog(@"%@",self.infoArray);
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
#warning Incomplete implementation, return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if(section == 0){
        return 1;
    }
    if(section == 1){
        //return [self.infoArray[@"part2List"] count]
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Part2ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil){
        cell = [[Part2ContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.infoArray = self.infoArray;
    // Configure the cell...
    
    return cell;
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
