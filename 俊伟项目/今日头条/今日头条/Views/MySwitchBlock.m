//
//  MySwitchBlock.m
//  今日头条
//
//  Created by qingyun on 16/6/22.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import "MySwitchBlock.h"
#import "Header.h"

@implementation MySwitchBlock



-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        [self addTarget:self action:@selector(actionWithOn:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

-(void)actionWithOn:(MySwitchBlock *)swiBtn{
    if (swiBtn.on) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATIONNAME object:nil userInfo:@{@"backColor":[UIColor blackColor],@"textColor":[UIColor grayColor]}];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATIONNAME object:nil userInfo:@{@"backColor":[UIColor whiteColor],@"textColor":[UIColor blackColor]}];
        
    }
}

@end
