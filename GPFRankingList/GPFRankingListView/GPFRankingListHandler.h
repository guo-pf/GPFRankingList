//
//  GPFRankingListHandler.h
//  GPFRankingList
//
//  Created by IAP-guo-pf on 17/4/24.
//  Copyright © 2017年 guo-pf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPFRankingListModel.h"
/**
 *  数据处理
 *
 **/

@interface GPFRankingListHandler : NSObject

/**
 *  计算是否进入排行榜
 *
 *  @param dataSouce   数组数据
 *  @param adminNumber 用户数据
 *  @param adminName   用户名字
 *  @param isRanking   isRanking：是否进去名次 rankNum：名次
 */
+(void) modelByDataSouceArray:(NSArray *)dataSouce adminNumber:(NSInteger)adminNumber adminName:(NSString *)adminName isRanking:(void (^)(BOOL isRanking , NSInteger rankNum))isRanking;


//+(BOOL) isRepeatModelByDataSourceArray:(NSArray *)dataSource receiveNewDataSource:(NSArray *)newDataSource;

@end
