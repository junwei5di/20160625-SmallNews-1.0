//
//  ContentTVC.m
//  今日头条
//
//  Created by qingyun on 16/6/20.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "ContentTVC.h"
#import "XHContentCell.h"
#import "XHTabelCell.h"
#import "XHModel.h"
#import "Header.h"
#import "NewsModel.h"
#import "WebCell.h"
#import "XHFooterView.h"
#import "SqlCreatTool.h"

@interface ContentTVC ()
@property(nonatomic,strong)NSArray *datasArr;
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)SqlCreatTool *sqlTool;
@end

@implementation ContentTVC

static NSString *indentifier=@"cell";
static NSString *webIndentifier=@"webCell";

-(SqlCreatTool *)sqlTool{
    if (!_sqlTool) {
        _sqlTool=[SqlCreatTool shareSqlTool];
    }
    return _sqlTool;
}

-(void)createAlertControllerWithTitle:(nonnull NSString *)title andMessage:(nonnull NSString *)message andActionOne:(nonnull NSString *)actionOne andActionTwo:(NSString *)actionTwo {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0=[UIAlertAction actionWithTitle:actionOne style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action0];
    if (actionTwo.length!=0) {
        UIAlertAction *action1=[UIAlertAction actionWithTitle:actionTwo style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:action1];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)getTheNetStatus:(AFNetworkReachabilityStatus)statu{
    switch (statu) {
        case AFNetworkReachabilityStatusUnknown:
            [self createAlertControllerWithTitle:@"警告" andMessage:@"未知网络" andActionOne:@"确定" andActionTwo:nil];
            break;
        case AFNetworkReachabilityStatusNotReachable:
            [self createAlertControllerWithTitle:@"警告" andMessage:@"网络不可用" andActionOne:@"确定" andActionTwo:nil];
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            [self createAlertControllerWithTitle:@"警告" andMessage:@"WIFI网络" andActionOne:@"确定" andActionTwo:nil];
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            [self createAlertControllerWithTitle:@"警告" andMessage:@"蜂窝网络" andActionOne:@"确定" andActionTwo:nil];
            break;
            
        default:
            break;
    }
}

-(AFHTTPSessionManager *)manager{
    if (_manager==nil) {
        _manager=[AFHTTPSessionManager manager];
        _manager.reachabilityManager=[AFNetworkReachabilityManager sharedManager];
        __weak typeof(self) weakSelf=self;
        [_manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            [weakSelf getTheNetStatus:status];
        }];
        [_manager.reachabilityManager startMonitoring];
    }
    return _manager;
}

#pragma mark 加载笑话网络数据
-(void)loadXHfromWeb{
    self.manager=[AFHTTPSessionManager manager];
    NSString *url=[NSString stringWithFormat:@"%@?xhid=%ld",DetailURL,(long)self.xModel.xhid];
    __weak typeof(self) weakSelf=self;
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [self.manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"obj===%@",responseObject);
        NSDictionary *dic=(NSDictionary *)responseObject;
        NSDictionary *arr=dic[@"detail"];
        NSMutableArray *mulArr=[NSMutableArray array];
        XHModel *xhModel=[XHModel modelWithDictionary:arr];
        [mulArr addObject:xhModel];
        _datasArr=mulArr;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error]];
        NSLog(@"error==%@",error);
    }];
    [SVProgressHUD dismiss];
}

#pragma mark 加载新闻网页
-(void)loadXWfromWeb:(NSString *)url{
    NSMutableArray *mulArr=[NSMutableArray array];
    [mulArr addObject:self.nModel];
    _datasArr=mulArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if (_backColor) {
        self.tableView.backgroundColor=_backColor;
    }
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.estimatedRowHeight=100;
    _datasArr=[NSArray array];
    if (self.nModel) {
        
        [self loadXWfromWeb:self.nModel.article_url];
        
    }else if (self.xModel){
        
        [self loadXHfromWeb];
    }
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XHContentCell class]) bundle:nil] forCellReuseIdentifier:indentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WebCell class]) bundle:nil] forCellReuseIdentifier:webIndentifier];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [SVProgressHUD dismiss];
}

-(void)changeColor:(NSNotification *)notification{
    _backColor=notification.userInfo[@"backColor"];
    _teColor=notification.userInfo[@"textColor"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _datasArr.count?1:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.nModel) {
        self.tableView.rowHeight=500;
        WebCell *cell=[tableView dequeueReusableCellWithIdentifier:webIndentifier forIndexPath:indexPath];
        if (_backColor&&_teColor) {
            cell.contentView.backgroundColor=_backColor;
            cell.teColor=_teColor;
        }
        
        cell.url=self.nModel.article_url;
        return cell;
    }else{
        XHContentCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
        if (_backColor&&_teColor) {
            cell.contentView.backgroundColor=_backColor;
            cell.teColor=_teColor;
        }
        cell.xModel=_datasArr[indexPath.row];
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.xModel) {
        return 30.0;
    }
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    XHFooterView *footerView=[XHFooterView addFooterView];
    UIButton *btn=[footerView viewWithTag:1001];
    [btn addTarget:self action:@selector(favouriteTouch:) forControlEvents:UIControlEventTouchUpInside];
    if (_teColor) {
        [btn setTitleColor:_teColor forState:UIControlStateNormal];
        btn.titleLabel.enabled=NO;
    }
    [btn setTitle:@"<收C藏>" forState:UIControlStateNormal];
    return self.xModel?footerView:nil;
}
-(void)favouriteTouch:(UIButton *)btn{
    if (self.xModel) {
        if ([self.sqlTool updateTableWithSqlStr:CREATSQLFAV andModel:nil]) {
            if ([self.sqlTool updateTableWithSqlStr:INSERTSQLFAV andModel:self.xModel]) {
                NSLog(@"插入成功");
                [self createAlertControllerWithTitle:@"提示" andMessage:@"收藏成功" andActionOne:@"确定" andActionTwo:nil];
            }else{
                [self createAlertControllerWithTitle:@"提示" andMessage:@"当前信息已经收藏了" andActionOne:@"取消" andActionTwo:nil];
            }
        }
    }
}

-(void)favouriteAction{
    
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
