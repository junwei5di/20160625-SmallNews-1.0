//
//  FavouriteTableVC.m
//  今日头条
//
//  Created by qingyun on 16/6/23.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import "FavouriteTableVC.h"
#import "XHContentCell.h"
#import "SqlCreatTool.h"
#import "Header.h"
#import "XHModel.h"
#import "XHFooterView.h"
#import "MySwitchBlock.h"
@interface FavouriteTableVC ()
@property(nonatomic,strong)NSMutableArray *xhDatas;
@property(nonatomic,strong)SqlCreatTool *sqlTool;
@property(nonatomic,strong)UIColor *backColor;
@property(nonatomic,strong)UIColor *teColor;

@end

@implementation FavouriteTableVC
static NSString *indentifier=@"xhCell";

-(SqlCreatTool *)sqlTool{
    if (!_sqlTool) {
        _sqlTool=[SqlCreatTool shareSqlTool];
    }
    return _sqlTool;
}

-(NSMutableArray *)xhDatas{
    if (!_xhDatas) {
        _xhDatas=[NSMutableArray array];
      NSMutableArray *mulArr=[self.sqlTool selectTableWithSqlStr:SELECTSQLFAV andModel:@"XHModel"];
        NSEnumerator *entor=[mulArr reverseObjectEnumerator];
        XHModel *xhModle;
        while (xhModle=[entor nextObject]) {
            [_xhDatas addObject:xhModle];
        }
    }
    return _xhDatas;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight=200;
    _backColor=self.navigationController.navigationBar.barTintColor;
    if (_backColor==[UIColor blackColor]) {
        _teColor=[UIColor grayColor];
        self.tableView.backgroundColor=_backColor;
    }
    else{
        _teColor=[UIColor blackColor];
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XHContentCell class]) bundle:nil] forCellReuseIdentifier:indentifier];
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.xhDatas.count?:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XHContentCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    cell.xModel=self.xhDatas[indexPath.section];
    if (_teColor&&_backColor) {
        cell.contentView.backgroundColor=_backColor;
        cell.teColor=_teColor;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    XHFooterView *footView=[XHFooterView addFooterView];
    footView.contentView.backgroundColor=_backColor;
//    UIButton *btn=[footView viewWithTag:1001];
//    [btn setTitle:@"<删-除>" forState:UIControlStateNormal];
//    if (_teColor) {
//        [btn setTitleColor:_teColor forState:UIControlStateNormal];
//    }
//    [btn addTarget:self action:@selector(footerTouchAction:) forControlEvents:UIControlEventTouchUpInside];
    return footView;
}
- (IBAction)deleteFavouriteAction:(UIBarButtonItem *)sender {
    NSString *title=sender.title;
    if ([title isEqualToString:@"<删D除>"]) {
        sender.title=@"<完Y成>";
        [self setEditing:YES];
    }else if ([title isEqualToString:@"<完Y成>"]){
        sender.title=@"<删D除>";
        [self setEditing:NO];
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    XHModel *xModel=self.xhDatas[indexPath.section];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.sqlTool updateTableWithSqlStr:DELETESQLFAV andModel:xModel];
        
        [_xhDatas removeObjectAtIndex:indexPath.section];
        
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
   
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }   
}



/*
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
