//
//  KKLeadingPageController.m
//  KKLoadingPageControl
//
//  Created by kkk on 2017/4/20.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import "KKLeadingPageController.h"
#import "KKLeadingPageCell.h"


@interface KKLeadingPageController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UIScrollViewDelegate
>

@property (nonatomic, copy) finishHandle finishHandle;
@property (nonatomic, copy) finishBtnName finishBtnName;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *images;
@end


static NSString *const KKLeadingPageCellID = @"KKLeadingPageCellID";
@implementation KKLeadingPageController

-(instancetype)initWithImages:(NSArray*)images
                finishBtnName:(finishBtnName)finishBtnName
                  finishHanle:(finishHandle)finishHandle

{
    self = [super init];
    if (self) {
        _pageNomalColor = [UIColor whiteColor];
        _pageHightColor = [UIColor darkGrayColor];
        _pageBottomHeight = 50.f;
        _images = images;
        
        _finishBtnName = finishBtnName;
        _finishHandle = finishHandle;
        [self initialize];
    }
    return self;
}

-(void)initialize
{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.pageControl];
    [self.collectionView registerClass:[KKLeadingPageCell class] forCellWithReuseIdentifier:KKLeadingPageCellID];
}

-(void)viewWillLayoutSubviews
{
    CGSize pageControlSize = [self.pageControl sizeForNumberOfPages:self.images.count];
    CGFloat pageControlX = (self.view.bounds.size.width - pageControlSize.width)/2;
    // 距离屏幕下方为 50 请根据具体情况修改吧
    CGFloat pageControlY = (self.view.bounds.size.height - pageControlSize.height - _pageBottomHeight);
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlSize.width, pageControlSize.height);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KKLeadingPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KKLeadingPageCellID forIndexPath:indexPath];
    
     cell.imageView.image = [UIImage imageNamed:self.images[indexPath.row]] ;
    
    //设置按钮
    if (self.finishBtnName) {
        self.finishBtnName(cell.finishBtn);
    }
    
    if (indexPath.row != self.images.count-1) {
        cell.finishBtn.hidden = YES;
    }
    else {
        // 最后一页 显示按钮, 并且添加响应方法
        cell.finishBtn.hidden = NO;
        [cell.finishBtn addTarget:self action:@selector(finishBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
       
       
    }
    
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x/scrollView.bounds.size.width + 0.5;
    if (self.pageControl.currentPage != currentPage) {
        self.pageControl.currentPage = currentPage;
    }
}



#pragma mark - TapHandle
-(void)finishBtnOnClick
{
    if (self.finishHandle) {
        self.finishHandle();
    }
}


#pragma mark - Setter
-(void)setPageNomalColor:(UIColor *)pageNomalColor
{
    _pageNomalColor = pageNomalColor;
    self.pageControl.pageIndicatorTintColor = _pageNomalColor;
}

-(void)setPageHightColor:(UIColor *)pageHightColor
{
    _pageHightColor = pageHightColor;
    self.pageControl.currentPageIndicatorTintColor = _pageHightColor;
}

-(void)setPageBottomHeight:(CGFloat)pageBottomHeight
{
    _pageBottomHeight = pageBottomHeight;
    [self.view setNeedsLayout];
}
#pragma mark - Getter
-(UICollectionView*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = self.view.bounds.size;
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        collectionView.pagingEnabled = YES;
        collectionView.bounces = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = self.images.count;
        pageControl.currentPage = 0;
        pageControl.pageIndicatorTintColor = _pageNomalColor;
        pageControl.currentPageIndicatorTintColor = _pageHightColor;
        
        _pageControl = pageControl;
    }
    return _pageControl;
}



@end
