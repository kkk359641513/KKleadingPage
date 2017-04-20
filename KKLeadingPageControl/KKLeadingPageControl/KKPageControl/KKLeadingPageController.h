//
//  KKLeadingPageController.h
//  KKLoadingPageControl
//
//  Created by kkk on 2017/4/20.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^finishHandle)();
typedef void(^finishBtnName)(UIButton *btn);

@interface KKLeadingPageController : UIViewController
@property (nonatomic, strong) UIColor *pageNomalColor; // default is whiteColor
@property (nonatomic, strong) UIColor *pageHightColor; // defualt is darkGrayColor
@property (nonatomic, assign) CGFloat pageBottomHeight; // value to bottom. default is 50.f


-(instancetype)initWithImages:(NSArray*)images       //[name of image]
                finishBtnName:(finishBtnName)finishBtnName
                  finishHanle:(finishHandle)finishHandle;


-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
+(instancetype)new NS_UNAVAILABLE;


@end
