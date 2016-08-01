//
//  HomeViewController.m
//  EARLY-BIRD-IELTS2
//
//  Created by 何建新 on 16/7/31.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "HomeViewController.h"
#import "Part1TableViewController.h"
#import "Part2TableViewController.h"
#import "AFNetworking.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property(nonatomic, retain) UIView *bgView;

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@property(nonatomic, strong) NSMutableArray *infoArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.infoArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    [self setupNavtaion];
    [self createToolBarItems];
    //红色条
    self.bottomView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2+4, 5)];
    self.bgView.backgroundColor = [UIColor redColor];
    [self.bottomView addSubview:self.bgView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    //获取数据
    //part1
    [self getJSON:@"http://test.benniaoyasi.cn/api.php?m=api&c=category&a=listcategory&appid=1&pid=1&mobile=&version=4.5.0&devtype=ios"];
    [self clearExtralIne:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 自定义方法
//取消空白cell
-(void)clearExtralIne:(UITableView *)tableView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}
//设置toolBar
-(void)createToolBarItems{
    UIBarButtonItem *part1Item = [[UIBarButtonItem alloc] initWithTitle:@"Part 1" style:UIBarButtonItemStylePlain target:self action:@selector(toolBarItemClick:)];
    [part1Item setWidth:self.view.frame.size.width/2-16];
    part1Item.tag = 101;
    UIBarButtonItem *part2Item = [[UIBarButtonItem alloc] initWithTitle:@"Part 2 & 3" style:UIBarButtonItemStylePlain target:self action:@selector(toolBarItemClick:)];
    [part2Item setWidth:self.view.frame.size.width/2-16];
    part2Item.tag = 102;
    [part1Item setTintColor:[UIColor blackColor]];
    [part2Item setTintColor:[UIColor blackColor]];
    NSArray *items = [[NSArray alloc] initWithObjects:part1Item,part2Item, nil];
    self.toolBar.items = items;
}
//设置导航栏
-(void)setupNavtaion{
    UILabel* navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    navTitleLabel.text = @"Part 1";
    navTitleLabel.font = [UIFont systemFontOfSize:16];
    navTitleLabel.textColor = [UIColor redColor];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = navTitleLabel;
    
    //self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    // [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"daohang_caidan_tubiao"] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftItemClick)];
}
//点击toolBarItem
-(void)toolBarItemClick:(UIBarButtonItem *)sender{
    if(sender.tag == 101){
        NSLog(@"part1");
        [self getJSON:@"http://test.benniaoyasi.cn/api.php?m=api&c=category&a=listcategory&appid=1&pid=1&mobile=&version=4.5.0&devtype=ios"];
        [UIView animateWithDuration:0.3 animations:^{
            [self.bgView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2+4, 5)];
        }];
    }else if(sender.tag == 102){
        NSLog(@"part2&3");
        
        [self getJSON:@"http://test.benniaoyasi.cn/api.php?m=api&c=category&a=listcategory&appid=1&pid=41&version=4.5.0&devtype=ios"];
        [UIView animateWithDuration:0.3 animations:^{
            [self.bgView setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2+4, 0, [UIScreen mainScreen].bounds.size.width/2+4, 5)];
        }];
    }
}
-(void)navLeftItemClick{
    
}
//获取网络数据
-(void)getJSON:(NSString *)urlString{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.infoArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.font = [UIFont systemFontOfSize:18];
    cell.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = self.infoArray[indexPath.row][@"ename"];
    
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.infoArray[indexPath.row][@"id"] == nil){
        Part1TableViewController *part1View = [[Part1TableViewController alloc] init];
        part1View.leval = self.infoArray[indexPath.row][@"evalue"];
        part1View.title = self.infoArray[indexPath.row][@"ename"];
        UIColor *color = [UIColor redColor];
        NSDictionary *dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
        self.navigationController.navigationBar.titleTextAttributes = dict;
        [self.navigationController pushViewController:part1View animated:YES];
    }else{
        Part2TableViewController *part2View = [[Part2TableViewController alloc] init];
        part2View.leval = self.infoArray[indexPath.row][@"evalue"];
        part2View.title = self.infoArray[indexPath.row][@"ename"];
        part2View.aid = self.infoArray[indexPath.row][@"id"];
        UIColor *color = [UIColor redColor];
        NSDictionary *dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
        self.navigationController.navigationBar.titleTextAttributes = dict;
        [self.navigationController pushViewController:part2View animated:YES];
    }
    
    
    
}
@end
