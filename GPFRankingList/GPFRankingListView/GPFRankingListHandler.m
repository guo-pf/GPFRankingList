//
//  GPFRankingListHandler.m
//  GPFRankingList
//
//  Created by IAP-guo-pf on 17/4/24.
//  Copyright © 2017年 guo-pf. All rights reserved.
//

#import "GPFRankingListHandler.h"

@implementation GPFRankingListHandler


+(void) modelByDataSouceArray:(NSArray *)dataSouce adminNumber:(NSInteger)adminNumber adminName:(NSString *)adminName isRanking:(void (^)(BOOL isRanking , NSInteger rankNum))isRanking{
    BOOL isAdminRanking = NO;
    NSInteger adminNum = 0;
     NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:dataSouce];
    for (NSInteger i = 0; i<arr.count; i++) {
        GPFRankingListModel *rankModel = arr[i];
        if (adminNumber && adminName.length) {
            if (rankModel.number == adminNumber && [rankModel.name isEqualToString:adminName]) {
                isAdminRanking = YES;
                adminNum = i+1;
                break;
            }
        }else if(adminNumber && adminName.length <= 0){
            if (rankModel.number == adminNumber) {
                isAdminRanking = YES;
                adminNum = i+1;
                 break;
            }
        }else if (adminName.length && !adminNumber){
            if ([rankModel.name isEqualToString:adminName]) {
                isAdminRanking = YES;
                adminNum = i+1;
                 break;
            }
        }else{
            break;
        }
        
    }
    
    isRanking(isAdminRanking,adminNum);
    
}

//+(BOOL) isRepeatModelByDataSourceArray:(NSArray *)dataSource receiveNewDataSource:(NSArray *)newDataSource{
//    BOOL isRepeat = NO;
//    if (dataSource.count > newDataSource.count) {
//        GPFRankingListModel *rankModel = dataSource.lastObject;
//        GPFRankingListModel *newRankModel = newDataSource.lastObject;
//        if ([rankModel.name isEqualToString:newRankModel.name] && rankModel.number == newRankModel.number) {
//            
//            isRepeat = YES;
//        }
//        
//    }else{
//        return NO;
//    }
//    
//    
//    
//    return isRepeat;
//    
//}

@end
