//
//  DirectTabbarC.m
//  今日头条
//
//  Created by qingyun on 16/6/24.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import "DirectTabbarC.h"
#import "Header.h"
@interface DirectTabbarC ()
@property(nonatomic,strong)UIColor *backColor;
@property(nonatomic,strong)UIColor *teColor;

@end

@implementation DirectTabbarC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:NOTIFICATIONNAME object:nil];
}

-(void)changeColor:(NSNotification *)notifition{
    _backColor=notifition.userInfo[@"backColor"];
    _teColor=notifition.userInfo[@"textColor"];
    self.tabBar.barTintColor=_backColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
