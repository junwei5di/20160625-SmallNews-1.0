//
//  XHContentCell.m
//  今日头条
//
//  Created by qingyun on 16/6/20.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "XHContentCell.h"
#import "XHModel.h"

@interface XHContentCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@end

@implementation XHContentCell


-(void)setXModel:(XHModel *)xModel{
    _xModel=xModel;
    _nameLabel.text=xModel.author;
    _contentLabel.text=xModel.content;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:xModel.picUrl]];
    _iconView.userInteractionEnabled=YES;
    UILongPressGestureRecognizer *longGes=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTouchAction:)];
    [_iconView addGestureRecognizer:longGes];
}

-(void)setTeColor:(UIColor *)teColor{
    _teColor=teColor;
//    if (teColor!=nil) {
        _nameLabel.textColor=_contentLabel.textColor=teColor;
//    }
}

-(void)longTouchAction:(UILongPressGestureRecognizer *)longges{
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
