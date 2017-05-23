//
//  GPFRankingListView.h
//  GPFRankingList
//
//  Created by IAP-guo-pf on 17/4/24.
//  Copyright © 2017年 guo-pf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPFRankingListHandler.h"


@class GPFRankingListRouletteView;

@protocol RankingListRouletteDelegate <NSObject>

@optional

-(void) adminByRankingList:(GPFRankingListRouletteView *)rankinglistView ranking:(NSInteger)ranking score:(NSInteger)score;

@end

@interface GPFRankingListRouletteView : UIView

///// @brief 当前页面从第几排到第几
@property (nonatomic, strong) UIColor * fromToColor;
///// @brief 排行分数颜色设置
@property (nonatomic, strong) UIColor *rankScoreColor;
///// @brief 用户排行分数颜色设置
@property (nonatomic, strong) UIColor *adminScoreColor;
///// @brief 头像边框颜色设置
@property (nonatomic, strong) UIColor *heartLineColor;
///// @brief 用户头像边框颜色设置
@property (nonatomic, strong) UIColor *adminHeartLineColor;

///// @brief 一页显示多少个
@property (nonatomic, assign) NSInteger pageNumber;   //一页显示多少个 默认 = 15

///// @brief 标题名字
@property (nonatomic, strong) NSString *titleName; //标题名字
///// @brief 默认头像照片
@property (nonatomic, strong) NSString *defaultHeartImageName; //默认头像照片   无数据的显示该头像
///// @brief 无数据时候显示（无数据的显示该头像）
@property (nonatomic, strong) NSString *imageNULLName;

#pragma mark - 以下两个必须至少有一个 否则则显示用户未进入排行榜 (数据必须准确，如果不准确会显示不准确，几个数据准就添加几个数据，多添或误填都会出现判断错误)
///// @brief 当前用户名字
@property (nonatomic, strong) NSString *adminName; //用户名字
///// @brief 当前用户分数（或者名次）
@property (nonatomic, assign) NSInteger adminNumber;//用户数据
///// @brief 代理
@property (nonatomic, assign) id <RankingListRouletteDelegate> delegate;

/**
 *  开始绘制
 *
 *  @param dataSourceArr 数据数组
 */
-(void)startDrawRankingListWithDataSourceArr:(NSArray *)dataSourceArr;


/**
 *  向上翻页  页数减
 */
-(void)handleSwipeUpperLevel;
/**
 *  向下翻页  页数加
 */
-(void)handleSwipeLowerLevel;
/**
 *  头像依次出现
 */
-(void)heartImagedisplay;

@end




