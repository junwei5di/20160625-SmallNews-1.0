//
//  MySwitchBlock.h
//  今日头条
//
//  Created by qingyun on 16/6/22.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySwitchBlock : UISwitch
@property(nonatomic,strong)void(^block)(UIColor *newColor);
@property(nonatomic,strong)UIColor *colorNum;
@end
