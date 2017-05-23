//
//  GPFRankingListModel.h
//  GPFRankingList
//
//  Created by IAP-guo-pf on 17/4/24.
//  Copyright © 2017年 guo-pf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPFRankingListModel : NSObject

///// @brief 头像名字
@property (nonatomic, strong)   NSString    *heartIamgeURL;
///// @brief 名字
@property (nonatomic, assign)   NSString    *name;
///// @brief 数据
@property (nonatomic, assign)   NSInteger   number;

@end
