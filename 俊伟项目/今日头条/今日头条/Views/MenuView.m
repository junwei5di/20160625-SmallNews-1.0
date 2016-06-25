//
//  MenuView.m
//  今日头条
//
//  Created by qingyun on 16/6/13.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import "MenuView.h"
#import "Masonry.h"

static NSInteger num=1000;

@implementation MenuView
+(MenuView *)addMenuViewWithTitles:(NSArray *)titles{
    MenuView *menu=[MenuView new];
    menu.showsHorizontalScrollIndicator=NO;
    for (int i=0; i<titles.count; i++) {
        UIButton *menuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [menu addSubview:menuBtn];
        [menuBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [menuBtn setTitle:titles[i] forState:UIControlStateNormal];
        menuBtn.titleLabel.font=[UIFont systemFontOfSize:17.0];
        menuBtn.tag=1000+i;
        [menuBtn addTarget:menu action:@selector(selectTheBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(8);
                make.centerY.mas_equalTo(0);
            }];
        }else if (i==titles.count-1){
            [menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                UIButton *aheadBtn=(UIButton *)[menu viewWithTag:menuBtn.tag-1];
                make.right.mas_equalTo(-8);
                make.centerY.mas_equalTo(0);
                make.left.equalTo(aheadBtn.mas_right).with.offset(5);
            }];
        }else{
            [menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                UIButton *aheadBtn=(UIButton *)[menu viewWithTag:menuBtn.tag-1];
                make.centerY.mas_equalTo(0);
                make.left.equalTo(aheadBtn.mas_right).with.offset(5);
            }];
        }
    }
    return menu;
}

-(void)selectTheBtn:(UIButton *)btn{
    if (num==btn.tag) {
        return;
    }
    NSLog(@"btn:%@",btn);
    UIButton *firstBtn=(UIButton *)[self viewWithTag:num];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:20.0];
    [firstBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    firstBtn.titleLabel.font=[UIFont systemFontOfSize:17.0];
    num=btn.tag;
    
}


@end
