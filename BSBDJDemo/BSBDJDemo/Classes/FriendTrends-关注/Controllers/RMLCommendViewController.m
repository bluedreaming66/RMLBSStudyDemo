//
//  RMLCommendViewController.m
//  BSBDJDemo
//
//  Created by blue on 2017/9/25.
//  Copyright © 2017年 blue. All rights reserved.
//

#import "RMLCommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "RMLListModel.h"
#import <MJExtension.h>
#import "RMLListTableViewCell.h"
#import "RMLUsersTableViewCell.h"
#import "RMLUserModel.h"
#import <MJRefresh.h>

#define RMLSelectedList self.listArrs[self.listTableView.indexPathForSelectedRow.row]

static NSString *listCellId = @"list";
static NSString *userCellId = @"user";
@interface RMLCommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (nonatomic, strong) NSArray *listArrs;

@property (nonatomic, strong) NSMutableDictionary *para;//请求参数
/** AFN请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;


@end

@implementation RMLCommendViewController

- (AFHTTPSessionManager *)manager{
  
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    self.view.backgroundColor = RMLGlobalBg;
    
    [self setupTableView];
    
    [self setRefresh];
    
    [self loadListData];
    
}

#pragma mark - 左侧列表
- (void)loadListData{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"category";
    para[@"c"] = @"subscribe";
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.listArrs = [RMLListModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]] ;
        [SVProgressHUD dismiss];
        
        [self.listTableView reloadData];
        
        [self.listTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"信息加载失败！"];
    }];
}

- (void)setupTableView{
    
    [self.listTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RMLListTableViewCell class]) bundle:nil] forCellReuseIdentifier:listCellId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RMLUsersTableViewCell class]) bundle:nil] forCellReuseIdentifier:userCellId];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.listTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.listTableView.contentInset;

}

- (void)setRefresh{
  
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.userTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.userTableView.mj_footer.hidden = YES;
}

- (void)loadData{
    
    RMLListModel *listModel = self.listArrs[self.listTableView.indexPathForSelectedRow.row];
    //当前页码为1
    listModel.currentPage = 1;
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"list";
    para[@"c"] = @"subscribe";
    para[@"category_id"] = @(listModel.id);
    para[@"page"] = @(listModel.currentPage);
    self.para = para;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arr = [RMLUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //移除旧数据
        [listModel.users removeAllObjects];
        [listModel.users addObjectsFromArray:arr];
        
        //保存总数
        listModel.total = [responseObject[@"total"] integerValue];
        
        //不是最后一次请求
        if (self.para != para) return ;
        
        [self.userTableView reloadData];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.userTableView.mj_header endRefreshing];
    }];

}

- (void)loadMoreData{
    RMLListModel *listModel = self.listArrs[self.listTableView.indexPathForSelectedRow.row];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"list";
    para[@"c"] = @"subscribe";
    para[@"category_id"] = @(listModel.id);
    para[@"page"] = @(++listModel.currentPage);
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arr = [RMLUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
   
        [listModel.users addObjectsFromArray:arr];
        
        [self.userTableView reloadData];
        
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        [self.userTableView.mj_footer endRefreshing];
    }];

}

//时刻检测footer的状态
- (void)checkFooterState{

    RMLListModel *listModel = RMLSelectedList;
    
    //每次刷新右边数据时，都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (listModel.users.count == 0);
    
    //底部控件结束刷新
    if (listModel.users.count == listModel.total) {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   //左边列表
    if (tableView == self.listTableView) return self.listArrs.count;

    //检测footer的状态
    [self checkFooterState];
    
    return [[RMLSelectedList users] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == self.listTableView) {
        RMLListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listCellId];
        if (!cell) {
            cell = [[RMLListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCellId];
        }
        cell.listModel = self.listArrs[indexPath.row];
        
        return cell;
    }else{
      
        RMLUsersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userCellId];
        if (!cell) {
            cell = [[RMLUsersTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:userCellId];
        }
        cell.userModel = [RMLSelectedList users][indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    RMLListModel *listModel = self.listArrs[indexPath.row];
    if (listModel.users.count) {
//        //显示曾经的数据
        [self.userTableView reloadData];
    }else{
       //先刷新 避免是上一个cell点击的残留数据
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header beginRefreshing];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (tableView == self.listTableView) {
        return 44;
    }else{
        return 80;
    }
    
}

//控制器销毁，网络请求操作取消
- (void)dealloc{
    //停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}


@end
