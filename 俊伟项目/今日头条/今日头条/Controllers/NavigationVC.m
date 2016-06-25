//
//  NavigationVC.m
//  今日头条
//
//  Created by qingyun on 16/6/24.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import "NavigationVC.h"
#import "Header.h"
@interface NavigationVC ()

@end

@implementation NavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:NOTIFICATIONNAME object:nil];
    // Do any additional setup after loading the view.
}

-(void)changeColor:(NSNotification *)notifition{
    _backColor=notifition.userInfo[@"backColor"];
    _teColor=notifition.userInfo[@"textColor"];
    [self.navigationBar setBarTintColor:_backColor];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_teColor,NSForegroundColorAttributeName, nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
