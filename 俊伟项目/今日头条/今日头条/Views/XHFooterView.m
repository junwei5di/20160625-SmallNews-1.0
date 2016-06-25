//
//  XHFooterView.m
//  今日头条
//
//  Created by qingyun on 16/6/23.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import <Masonry.h>
#import "XHFooterView.h"

@interface XHFooterView ()
@property(nonatomic,strong)UIButton *favourite;
@end

@implementation XHFooterView


-(UIButton *)favourite{
    if (!_favourite) {
        _favourite=[UIButton buttonWithType:UIButtonTypeCustom];
        NSString *path=[[NSBundle mainBundle] pathForResource:@"MoreMyFavorites" ofType:@"png"];
        [_favourite setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        UIImage *backImage=[UIImage imageWithContentsOfFile:path];
        [_favourite setImage:backImage forState:UIControlStateNormal];
        _favourite.tag=1001;
    }
    return _favourite;
}

+(XHFooterView *)addFooterView{
    XHFooterView *footer=[[XHFooterView alloc] init];
    [footer addSubview:footer.favourite];
    [footer.favourite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    return footer;
}


@end
