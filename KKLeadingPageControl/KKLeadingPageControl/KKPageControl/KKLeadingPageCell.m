//
//  KKLeadingPageCell.m
//  KKLoadingPageControl
//
//  Created by kkk on 2017/4/20.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import "KKLeadingPageCell.h"

@implementation KKLeadingPageCell



-(instancetype)init{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}


-(void)initialize
{
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.finishBtn];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
    //根据字数自动调整宽高
    [self.finishBtn sizeToFit];
    
    CGFloat margin = 10.f;
    CGFloat btnHeight = self.finishBtn.bounds.size.height+2*margin;
    CGFloat btnWidth = self.finishBtn.bounds.size.width+2*margin;
    CGFloat btnX = (self.bounds.size.width - btnWidth)/2;
    // 距离屏幕下方的距离为 100
    CGFloat btnY = self.bounds.size.height - 100.f - btnHeight;
    self.finishBtn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
    
}

#pragma mark - Getter
-(UIImageView*)imageView
{
    if (!_imageView) {
        UIImageView *imgView = [UIImageView new];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView = imgView;
    }
    return _imageView;
}

-(UIButton*)finishBtn
{
    if (!_finishBtn) {
        UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor yellowColor];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 10.f;
        _finishBtn = btn;
    }
    return _finishBtn;
}

@end
