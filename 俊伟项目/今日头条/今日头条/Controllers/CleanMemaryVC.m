//
//  CleanMemaryVC.m
//  今日头条
//
//  Created by qingyun on 16/6/24.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import "CleanMemaryVC.h"
#import "Header.h"
#import "SqlCreatTool.h"

@interface CleanMemaryVC ()
@property(nonatomic,strong)UIColor *backColor;
@property(nonatomic,strong)UIColor *teColor;
@end

@implementation CleanMemaryVC


- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController.navigationBar.barTintColor==[UIColor blackColor]) {
        self.view.backgroundColor=[UIColor grayColor];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cleanAllAction:(UIButton *)sender {
    switch (sender.tag) {
        case 101://清空
            [self cleanSQLWithsql:DROPSQLFAV];
            [self cleanSQLWithsql:DROPSQLNEWS];
            [self cleanSQLWithsql:DROPSQLXH];
            break;
        case 102://保留收藏
            [self cleanSQLWithsql:DROPSQLXH];
            [self cleanSQLWithsql:DROPSQLNEWS];
            break;
            
        default:
            break;
    }
}

-(void)cleanSQLWithsql:(NSString *)sql{
    if ([[SqlCreatTool shareSqlTool] updateTableWithSqlStr:sql andModel:nil]) {
        NSLog(@"YES");
    }
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
