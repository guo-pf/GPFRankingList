//
//  GPFDataCalculateUtils.h
//  GPFRankingList
//
//  Created by guo-pf on 2017/5/1.
//  Copyright © 2017年 guo-pf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GPFDataCalculateUtils : NSObject

//计算文字高度
+(CGSize)calculateSize:(CGFloat)fontSize sizeStr:(NSString*)sizeStr strWidth:(CGFloat)strWidth strHight:(CGFloat)strHight;
//计算弧度坐标
+(CGPoint) calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius;
@end
