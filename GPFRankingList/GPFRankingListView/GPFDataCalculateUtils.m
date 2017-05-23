//
//  GPFDataCalculateUtils.m
//  GPFRankingList
//
//  Created by guo-pf on 2017/5/1.
//  Copyright © 2017年 guo-pf. All rights reserved.
//

#import "GPFDataCalculateUtils.h"

@implementation GPFDataCalculateUtils

//计算文字高度
+(CGSize)calculateSize:(CGFloat)fontSize sizeStr:(NSString*)sizeStr strWidth:(CGFloat)strWidth strHight:(CGFloat)strHight{
    CGSize  size = [sizeStr boundingRectWithSize:CGSizeMake(strWidth, strHight) options:NSStringDrawingTruncatesLastVisibleLine attributes: @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],} context:nil].size;
    return size;
}

//计算弧度坐标
+(CGPoint) calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x2, center.y-y2);
}


@end
