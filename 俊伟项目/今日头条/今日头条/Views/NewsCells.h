//
//  NewsCells.h
//  今日头条
//
//  Created by qingyun on 16/6/20.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;

@interface NewsCells : UITableViewCell
@property(nonatomic,strong)NewsModel *nModel;
@property(nonatomic,strong)UIColor *nColor;
@end
