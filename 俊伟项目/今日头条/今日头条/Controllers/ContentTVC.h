//
//  ContentTVC.h
//  今日头条
//
//  Created by qingyun on 16/6/20.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHModel;
@class NewsModel;
@interface ContentTVC : UITableViewController
@property(nonatomic,strong)XHModel *xModel;
@property(nonatomic,strong)NewsModel *nModel;
@property(nonatomic,strong)UIColor *backColor;
@property(nonatomic,strong)UIColor *teColor;
@end
