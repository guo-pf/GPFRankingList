//
//  GPFRankingListView.h
//  GPFRankingList
//
//  Created by guo-pf on 2017/5/1.
//  Copyright © 2017年 guo-pf. All rights reserved.
//


#import <UIKit/UIKit.h>

/**
 *  旋转式排行榜  （需要提供头像（若没有不显示），昵称，数据（通过数据adminNumber和昵称:adminName 来判断哪个是当前用户，至少二选一））
 *
 **/


@class GPFRankingListView;
@protocol RankingListDelegate <NSObject>

@optional

/**
 *  代理
 *
 *  @param rankingListView 对象
 *  @param pageCount       每页多少个
 *  @param pageIndex       页数
 */
-(void) rankingListDidScroll:(GPFRankingListView *)rankingListView
                   pageCount:(NSInteger)pageCount
                   pageIndex:(NSInteger)pageIndex;

@end



@interface GPFRankingListView : UIView
///// @brief 圆边颜色设置
@property (nonatomic, strong) UIColor * circleColor;
///// @brief 当前页面从第几排到第几
@property (nonatomic, strong) UIColor * fromToColor;
///// @brief 上榜颜色设置
@property (nonatomic, strong) UIColor *signRankingColor;
///// @brief 没上榜颜色设置
@property (nonatomic, strong) UIColor *outRankingColor;
///// @brief 上榜消息颜色设置
@property (nonatomic, strong) UIColor *signMessageColor;
///// @brief 没上榜消息颜色设置
@property (nonatomic, strong) UIColor *outMessageColor;
///// @brief 排行分数颜色设置
@property (nonatomic, strong) UIColor *rankScoreColor;
///// @brief 用户排行分数颜色设置
@property (nonatomic, strong) UIColor *adminScoreColor;
///// @brief 头像边框颜色设置
@property (nonatomic, strong) UIColor *heartLineColor;
///// @brief 用户头像边框颜色设置
@property (nonatomic, strong) UIColor *adminHeartLineColor;


///// @brief 一页显示多少个
@property (nonatomic, assign) NSInteger pageNumber;   //一页显示多少个
///// @brief 标题名字
@property (nonatomic, strong) NSString *titleName; //标题图片名字
///// @brief 默认头像照片 （无数据的显示该头像）
@property (nonatomic, strong) NSString *defaultHeartImageName; //默认头像照片
///// @brief 无数据时候显示（无数据的显示该头像）
@property (nonatomic, strong) NSString *imageNULLName;  //无数据的显示该头像

#pragma mark - 以下两个必须至少有一个 否则则显示用户未进入排行榜 (数据必须准确，如果不准确会显示不准确，几个数据准就添加几个数据，多添或误填都会出现判断错误)
///// @brief 当前用户名字 已经知道用户排名情况，这里只需显示出来
@property (nonatomic, strong) NSString *adminName; //用户名字
///// @brief 当前用户分数（或者名次） 数据没有重复，知道用户的数据
@property (nonatomic, assign) NSInteger adminNumber;//用户数据

#pragma mark - 数据

@property (nonatomic, assign) id <RankingListDelegate> delegate; //用户名字

/**
 * 开始绘制排行榜
 *
 **/
-(void)startRanking;


/**
 *  开始加载数据
 *
 *  @param dataSourceArr 数据数组
 *  @param pageIndex     页数
 */
-(void)startDrawRankingListWithDataSourceArr:(NSArray *)dataSourceArr pageIndex:(NSInteger)pageIndex;
/**
 *  当无数据或者加载数据失败时候，反弹会原始状态
 *
 *  @param Message nil 为后期扩展预留接口 暂无意义
 */
-(void)recoveryDrawRankingListWithMessage:(NSString *)Message;
@end
