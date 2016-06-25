//
//  ViewController.m
//  今日头条
//
//  Created by qingyun on 16/5/18.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <Masonry.h>
#import "HomeTabelVC.h"
#import "NewsModel.h"
#import "MenuView.h"
#import "XHModel.h"
#import "XHTabelCell.h"
#import "NewsCells.h"
#import "ContentTVC.h"
#import "Header.h"
#import "SqlCreatTool.h"
#import "MySwitchBlock.h"

@interface HomeTabelVC ()
@property(nonatomic,strong)SqlCreatTool *sqlTool;
@property(nonatomic,strong)NSMutableArray *titles;
@property(nonatomic,strong)UISegmentedControl *seg;
@property(nonatomic,strong)UIColor *oneColor;
@property(nonatomic,strong)UIColor *teColor;
@end
@implementation HomeTabelVC
static NSString *identifier=@"newcell";
static NSString *xhIdentifier=@"xhcell";

#pragma mark 懒加载titles数组

-(SqlCreatTool *)sqlTool{
    if (_sqlTool==nil) {
        _sqlTool=[SqlCreatTool shareSqlTool];
    }
    return _sqlTool;
}

-(NSArray *)titles{
    if (_titles==nil) {
        _titles=[NSMutableArray array];
    }
    return _titles;
}

#pragma mark 懒加载segmentedContol
-(UISegmentedControl *)seg{
    if (_seg==nil) {
        _seg=[[UISegmentedControl alloc] initWithItems:@[@"笑话",@"新闻"]];
        _seg.selectedSegmentIndex=0;
        [_seg addTarget:self action:@selector(touchTheSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    }
    return _seg;
}

#pragma mark seg的点击事件
-(void)touchTheSegmentedControl:(UISegmentedControl *)segment{
    if (!self.refreshControl.refreshing) {
        [SVProgressHUD show];
    }
    NSString *urlXw=[NSString stringWithFormat:@"%@?size=40",XWBASEURL];
    NSString *urlXh=[NSString stringWithFormat:@"%@?size:40&page:0",BASEURL];
    if (segment.selectedSegmentIndex==0) {
        [self loadDataWithAFNetworkingWithURl:urlXh andModel:@"XHModel"];
    }else if (segment.selectedSegmentIndex==1){
        [self loadDataWithAFNetworkingWithURl:urlXw andModel:@"NewsModel"];
    }
}

#pragma mark 请求网络数据
-(void)loadDataWithAFNetworkingWithURl:(NSString *)url andModel:(NSString *)modelName{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    __weak typeof(self) weakSelf=self;
    [manager GET:url parameters:self progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"obj==%@",responseObject);
        NSDictionary *dic=(NSDictionary *)responseObject;
        NSArray *arr=dic[@"detail"];
        NSMutableArray *mularr=[NSMutableArray array];
        if ([modelName isEqualToString:NSStringFromClass([XHModel class])]) {
            for (NSDictionary *dict in arr) {
                XHModel *model=[XHModel modelWithDictionary:dict];
                [mularr addObject:model];
                if ([self.sqlTool updateTableWithSqlStr:CREATSQLXH andModel:nil]) {
                    if ([self.sqlTool updateTableWithSqlStr:INSERTSQLXH andModel:model]) {
                        //                        NSLog(@"插入成功");
                    }
                }
            }
        }else if ([modelName isEqualToString:NSStringFromClass([NewsModel class])]){
            for (NSDictionary *dict in arr) {
                NewsModel *nModel=[NewsModel modelWithDictionary:dict];
                //                NSLog(@"arr==%@",arr);
                //                NSLog(@"nmodel===%@",nModel);
                [mularr addObject:nModel];
                if ([self.sqlTool updateTableWithSqlStr:CREATESQLNEWS andModel:nil]) {
                    if ([self.sqlTool updateTableWithSqlStr:INSERTSQLNEWS andModel:nModel]) {
                        //                        NSLog(@"插入成功");
                    }
                }
            }
        }
        weakSelf.titles=mularr;
        [weakSelf.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==%@",error);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [SVProgressHUD dismissWithDelay:2];
        [self.refreshControl endRefreshing];
    }];
    
    [self.refreshControl endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.estimatedRowHeight=200;
    [self addSubViews];
    self.seg.selectedSegmentIndex=0;
    NSString *urlXh=[NSString stringWithFormat:@"%@?size:20&page:0",BASEURL];
    [self loadDataWithAFNetworkingWithURl:urlXh andModel:@"XHModel"];
    NSString *nibName=NSStringFromClass([NewsCells class]);
    UINib *nib=[UINib nibWithNibName:nibName bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XHTabelCell class]) bundle:nil] forCellReuseIdentifier:xhIdentifier];
    
    self.navigationItem.titleView=self.seg;
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:NOTIFICATIONNAME object:nil];
}


-(void)changeColor:(NSNotification *)notification{
    
    _oneColor=notification.userInfo[@"backColor"];
    _teColor=notification.userInfo[@"textColor"];
    self.tableView.backgroundColor=_oneColor;
    [self.tableView reloadData];
}


#pragma mark 添加子视图
-(void)addSubViews{
    self.refreshControl=[[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 0)];
    [self.refreshControl addTarget:self action:@selector(refreshTheView) forControlEvents:UIControlEventValueChanged];
    //    MenuView *menu=[MenuView addMenuViewWithTitles:self.titles];
    //    self.navigationItem.titleView=menu;
    //
    //    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.mas_equalTo(0);
    //    }];
}

#pragma mark 下拉刷新
-(void)refreshTheView{
    [self touchTheSegmentedControl:self.seg];
}

#pragma mark tableViewController的datasource方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titles.count?1:0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count?:0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.seg.selectedSegmentIndex==0) {
        XHModel *xModel=self.titles[indexPath.row];
        XHTabelCell *cell=[tableView dequeueReusableCellWithIdentifier:xhIdentifier forIndexPath:indexPath];
        if (_oneColor&&_teColor) {
            cell.contentView.backgroundColor=_oneColor;
            cell.xhColor=_teColor;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.xhModel=xModel;
        return cell;
    }else if(self.seg.selectedSegmentIndex==1){
        NewsCells *cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        if (_oneColor&&_teColor) {
            cell.contentView.backgroundColor=_oneColor;
            cell.nColor=_teColor;
        }
        NewsModel *model=self.titles[indexPath.row];
        cell.nModel=model;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

#pragma mark 选中事件tableView的delegete方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
    ContentTVC *vc=[[ContentTVC alloc] initWithStyle:UITableViewStylePlain];
    vc.backColor=_oneColor;
    vc.teColor=_teColor;
    vc.hidesBottomBarWhenPushed=YES;
    if (self.seg.selectedSegmentIndex==0) {
        XHModel *xModel=self.titles[indexPath.row];
        vc.xModel=xModel;
    }else if (self.seg.selectedSegmentIndex==1){
        NewsModel *nModel=self.titles[indexPath.row];
        vc.nModel=nModel;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark tableView编辑模式
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    //编辑模式:删除/添加/移动
    return UITableViewCellEditingStyleDelete;
}
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewRowActionStyleDestructive;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //提交编辑
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        if (self.seg.selectedSegmentIndex==0) {
            XHModel *xhModel=self.titles[indexPath.row];
            [self.sqlTool updateTableWithSqlStr:DELETESQLXH andModel:xhModel];
        }else if (self.seg.selectedSegmentIndex==1){
            NewsModel *nModel=self.titles[indexPath.row];
            [self.sqlTool updateTableWithSqlStr:DELETESQLNEWS andModel:nModel];
        }
    }
    [self.titles removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
