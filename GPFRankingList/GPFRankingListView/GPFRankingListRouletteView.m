//
//  GPFRankingListView.m
//  GPFRankingList
//
//  Created by IAP-guo-pf on 17/4/24.
//  Copyright © 2017年 guo-pf. All rights reserved.
//

#import "GPFRankingListRouletteView.h"
#import "GPFDataCalculateUtils.h"
#import "UIImageView+WebCache.h"

@interface GPFRankingListRouletteView()
@property (nonatomic, strong) UIImageView *nameImageView;                   //
@property (nonatomic, strong) NSMutableDictionary *visibleListViewsItems;   //头像视图复用


@end
@implementation GPFRankingListRouletteView{
    
    NSInteger  _cameraSum;                          //本身的数据
    NSString *_titleNameStr;                        // 名字
    
    NSInteger _ranking;                             //判断是否进入排行榜，如果进入了 排第几
    NSMutableArray *_rankingListArray;              //当前页排行榜内所有的信息
    
    NSInteger _rankingListPage;                    //旋转第几页
    CAShapeLayer *_pathLayer;                      // 排名路径  例如：0－－－－－－－－20名
    CGFloat screenWidth;                          //宽度
    
    CGPoint centerPoint;                          //中心点
    
    CGPoint titlePoint;
   // BOOL _isRanking;                            //来标记用户是否入榜，如果没入榜，下次旋转载入新数据时候继续判断
    BOOL isStartInit;                           //是否为启动
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCongifig];
      
    }
    return self;
}


-(void)initCongifig{
    
    self.backgroundColor = [UIColor clearColor];
 
    if (self.frame.size.width <= self.frame.size.height) {
        screenWidth = self.frame.size.width;
    }else{
        screenWidth = self.frame.size.height;
    }

    
     _ranking = 0;
     _rankingListPage = 0;
     centerPoint = CGPointMake(screenWidth/2, screenWidth/2);
    isStartInit = YES;
    
}
#pragma mark - ui及配置

-(NSMutableDictionary *)visibleListViewsItems{
    if (!_visibleListViewsItems) {
        _visibleListViewsItems = [[NSMutableDictionary alloc]init];
    }
    return _visibleListViewsItems;
}

-(UIImageView *)nameImageView{
    if (!_nameImageView) {
        _nameImageView = [[UIImageView alloc]init];
        [self addSubview:_nameImageView];
      //  _nameImageView.backgroundColor = [UIColor orangeColor];
    }
    return _nameImageView;
}
#pragma mark - 赋值
 
-(void)setRankScoreColor:(UIColor *)rankScoreColor{
    _rankScoreColor = rankScoreColor;
}

-(void)setFromToColor:(UIColor *)fromToColor{
    _fromToColor = fromToColor;
}


-(void)setAdminScoreColor:(UIColor *)adminScoreColor{
    _adminScoreColor = adminScoreColor;
}

-(void)setHeartLineColor:(UIColor *)heartLineColor{
    _heartLineColor = heartLineColor;
}

-(void)setAdminHeartLineColor:(UIColor *)adminHeartLineColor{
    _adminHeartLineColor = adminHeartLineColor;
}


-(void)setDefaultHeartImageName:(NSString *)defaultHeartImageName{
    _defaultHeartImageName = defaultHeartImageName;
}

-(void)setImageNULLName:(NSString *)imageNULLName{
    _imageNULLName = imageNULLName;
}

-(void)setPageNumber:(NSInteger)pageNumber{
    _pageNumber = pageNumber;
}


-(void)setTitleName:(NSString *)titleName{
    _titleName = titleName;
}

-(void)setAdminName:(NSString *)adminName{
    _adminName = adminName;
}

-(void)setAdminNumber:(NSInteger)adminNumber{
    _adminNumber = adminNumber;
}

#pragma mark - 响应事件
-(void)startDrawRankingListWithDataSourceArr:(NSArray *)dataSourceArr {
   
        if (_ranking <=0) {
            _rankingListArray = [[NSMutableArray alloc]initWithArray:dataSourceArr];
            if (isStartInit) {
                [GPFRankingListHandler modelByDataSouceArray:dataSourceArr adminNumber:self.adminNumber adminName:self.adminName isRanking:^(BOOL isRanking, NSInteger rankNum) {
                    
                    if (isRanking) {
                        if (_rankingListArray.count) {
                            _ranking = rankNum + _rankingListPage*self.pageNumber ;
                            _cameraSum = self.adminNumber;

                            [self.delegate adminByRankingList:self ranking:_ranking score:_cameraSum];

                        }

                    }
                    
                    
                        [self dataAcquisitionRotateSpinningHeartView];
                        isStartInit = NO;
                    [self setNeedsDisplay];
                    
                }];
            }else{
                [self setNeedsDisplay];
            }
            
        }else{
            
            _rankingListArray = [[NSMutableArray alloc]initWithArray:dataSourceArr];
            [self setNeedsDisplay];

            
        }

}

-(UIImageView *)loadImageViewAtIndex:(NSInteger)index{
    NSString *keyStr = [NSString stringWithFormat:@"%ld",index];
    UIImageView *heartImageView ;
    heartImageView = self.visibleListViewsItems[keyStr];
    if (heartImageView == nil) {
        heartImageView = [[UIImageView  alloc]init];
        [self addSubview:heartImageView];
        heartImageView.alpha = 0;
        [self.visibleListViewsItems setObject:heartImageView forKey:keyStr];

    }
    
    return heartImageView;
}

#pragma mark - 绘图

-(void)drawRect:(CGRect)rect{
    if (_rankingListArray.count) {
        
        float radius = screenWidth/3;
        NSInteger cameraIcon;
       // cameraIcon = -1;
        
        float currentangel = 270.0;
        
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetLineWidth(context, 1.0);//线的宽度
        NSInteger sumlen = self.pageNumber *2;
        NSInteger sum = 0;
        for (NSInteger j = 0; j <= sumlen; j++) {
            sum += j;
        }
     
        for (NSInteger i = sumlen-1; i > sumlen-1-self.pageNumber; i--) {
            
            float radiu = 360/(CGFloat)sum*(i+1)+radius;
            float angle_start = currentangel;
            currentangel += 360/(CGFloat)sum*(i+1);
            float angle_end = currentangel;

            CGFloat radiuMove = 0;
            
           radiuMove = [self drawTextByAngle:angle_end];

            CGPoint labelPoint = [GPFDataCalculateUtils calcCircleCoordinateWithCenter:centerPoint andWithAngle:360-(angle_start+angle_end)/2 andWithRadius:radius+radiuMove];
            
            GPFRankingListModel *rankModel;
            if (sumlen-1-i < _rankingListArray.count) {
                
                rankModel = _rankingListArray[sumlen-1-i];
                
                NSString *str = [NSString stringWithFormat:@"%ld",rankModel.number];
                
                NSDictionary *attributeDict ;
                CGSize textSize ;
                
                if (_ranking!=0 && sumlen-1-i == _ranking-1 -_rankingListPage*self.pageNumber&& (_ranking-1)/self.pageNumber==_rankingListPage) {
                    attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIFont systemFontOfSize:10.0],NSFontAttributeName,
                                     self.adminScoreColor,NSForegroundColorAttributeName,nil];
                     textSize = [GPFDataCalculateUtils calculateSize:10.0 sizeStr:str strWidth:CGFLOAT_MAX strHight:10];
                }else{
                    attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIFont systemFontOfSize:9.0],NSFontAttributeName,
                                     self.rankScoreColor,NSForegroundColorAttributeName,nil];
                     textSize = [GPFDataCalculateUtils calculateSize:9.0 sizeStr:str strWidth:CGFLOAT_MAX strHight:10];
                }
                
                
//                CGSize textSize = [GPFDataCalculateUtils calculateSize:9.0 sizeStr:str strWidth:CGFLOAT_MAX strHight:10];
                

                [str drawWithRect:CGRectMake(labelPoint.x-textSize.width/2, labelPoint.y-textSize.height/2, textSize.width, 10) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDict context:nil];
                
            }
            CGPoint allPoint = [GPFDataCalculateUtils calcCircleCoordinateWithCenter:centerPoint andWithAngle:360-(angle_start+angle_end)/2 andWithRadius:radiu+5];
            

            float inset = radiu-radius-1;
            UIImageView *imageView = [self loadImageViewAtIndex:(i -self.pageNumber)];

            if (sumlen-1-i < _rankingListArray.count) {
                if (_ranking!=0 && sumlen-1-i == _ranking-1 -_rankingListPage*self.pageNumber&& (_ranking-1)/self.pageNumber==_rankingListPage) {
                    CGPoint pointNow = [GPFDataCalculateUtils calcCircleCoordinateWithCenter:centerPoint andWithAngle:360-(angle_start+angle_end)/2 andWithRadius:radiu+10];
 
                    imageView.layer.borderColor=self.adminHeartLineColor.CGColor;
                    imageView.layer.borderWidth = 2.5;
                    imageView.frame = CGRectMake(pointNow.x-inset-3, pointNow.y-inset-3, inset*2+6, inset*2+6);
                    cameraIcon = sumlen-1-i;
                    
                }else{
                    imageView.layer.borderColor = self.heartLineColor.CGColor;
                    imageView.layer.borderWidth = 1.5;
                    imageView.frame = CGRectMake(allPoint.x-inset, allPoint.y-inset, inset*2, inset*2 );
                    
                }
                
                if (rankModel.heartIamgeURL) {

                    imageView.image = nil;
                    [imageView sd_setImageWithURL:[NSURL URLWithString:rankModel.heartIamgeURL] placeholderImage:[UIImage imageNamed:self.defaultHeartImageName] options:SDWebImageLowPriority | SDWebImageRetryFailed];

                }else{

                    imageView.image = [UIImage imageNamed:self.defaultHeartImageName];
                }
            }else{
                imageView.layer.borderColor=self.heartLineColor.CGColor;
                imageView.layer.borderWidth = 1.5;
                imageView.frame = CGRectMake(allPoint.x-inset, allPoint.y-inset, inset*2, inset*2 );
                imageView.image = [UIImage imageNamed:self.imageNULLName];
                
            }
            
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = imageView.bounds.size.width*0.5;
            
            if (i==sumlen-1-self.pageNumber+1) {
                if (!titlePoint.x) {
                    if (angle_end>360) {
                        angle_start = angle_end-360;
                    }else{
                        angle_start = angle_end;
                    }
                    angle_end =270;
                
                    titlePoint = [GPFDataCalculateUtils calcCircleCoordinateWithCenter:centerPoint andWithAngle:360-(angle_start+angle_end)/2 andWithRadius:radiu+50];
                    self.nameImageView.image = [UIImage imageNamed:self.titleName];
                    self.nameImageView.frame=CGRectMake(titlePoint.x-40, titlePoint.y-40, radiu+40, radiu+40);
                

                }
            }
            
        }
        
        CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
        
        NSString *fromStr=[NSString stringWithFormat:@"%ld",_rankingListPage*self.pageNumber+1];
        NSString *toStr=[NSString stringWithFormat:@"%ld",_rankingListPage*self.pageNumber+self.pageNumber];

        
        NSDictionary *strAttributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont systemFontOfSize:9.0],NSFontAttributeName,
                                           self.fromToColor,NSForegroundColorAttributeName,nil];
        
        CGSize toTextSize =[GPFDataCalculateUtils calculateSize:9.0 sizeStr:toStr strWidth:CGFLOAT_MAX strHight:10];
        CGPoint toPoint = [GPFDataCalculateUtils calcCircleCoordinateWithCenter:centerPoint andWithAngle:180 andWithRadius:radius*3/4];
        
        CGSize fromTextSize =[GPFDataCalculateUtils calculateSize:9.0 sizeStr:fromStr strWidth:CGFLOAT_MAX strHight:10];
        CGPoint formPoint = [GPFDataCalculateUtils calcCircleCoordinateWithCenter:centerPoint andWithAngle:90 andWithRadius:radius*3/4];
        
        [fromStr drawWithRect:CGRectMake(formPoint.x-fromTextSize.width-5, formPoint.y-5, fromTextSize.width, 10) options:NSStringDrawingUsesLineFragmentOrigin attributes:strAttributeDict context:nil];
        [toStr drawWithRect:CGRectMake(toPoint.x-toTextSize.width/2, toPoint.y-15, toTextSize.width, 10) options:NSStringDrawingUsesLineFragmentOrigin attributes:strAttributeDict context:nil];
        
        CGContextStrokePath(context);
        
        UIBezierPath *path =[UIBezierPath bezierPath];
        
        [path addArcWithCenter:centerPoint radius:radius*3/4 startAngle:-M_PI/2 endAngle:M_PI clockwise:YES];
        
        if (_pathLayer) {
            [_pathLayer removeFromSuperlayer];
        }
        _pathLayer =[CAShapeLayer layer];
        //_pathLayer.frame = self.frame;
        _pathLayer.path =path.CGPath;
  
        _pathLayer.strokeColor = self.fromToColor.CGColor;
        _pathLayer.lineWidth =2.0f;
        _pathLayer.fillColor = [[UIColor clearColor]CGColor];
        _pathLayer.lineJoin = kCALineJoinRound;
        [_pathLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:8], [NSNumber numberWithInt:2], nil]];
        _pathLayer.opacity =0.5;
        [self.layer addSublayer:_pathLayer];
        CABasicAnimation *pathAnimation =[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration =1.5;
        pathAnimation.fromValue =[NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue=[NSNumber numberWithFloat:1.0f];
        [_pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
        
    }

}

#pragma mark - 计算
//画图文字位置纠正
-(CGFloat)drawTextByAngle:(float)angle_end{
    CGFloat radiuMove = 0;
    if (angle_end >= 0.0 && angle_end < 45.0) {
        
        radiuMove = -30.0;
    }else if (angle_end >= 45.0 && angle_end < 90.0){
        
        radiuMove = -10.0;
    }else if (angle_end >= 90.0 && angle_end <= 135.0){
        radiuMove=0.0;
        
    }else if (angle_end >= 135.0 && angle_end < 180.0){
        radiuMove=0.0;
        
    }else if (angle_end >= 180.0 && angle_end < 225.0){
        
        radiuMove=0.0;
    }else if (angle_end >= 225.0 && angle_end <= 270.0){
        radiuMove=0.0;
        
    }else if (angle_end >= 270.0 && angle_end < 315.0){
        radiuMove = -10.0;
        
    }else{
        radiuMove = -10.0;
    }
    return radiuMove;
}


-(void)handleSwipeUpperLevel{

    // ------------
    _rankingListPage--;
    [self animationView:self.pageNumber-1 direction:NO];


}

-(void)handleSwipeLowerLevel{
    //++++++++++++

    _rankingListPage++;
    [self animationView:0 direction:YES];

    
}

-(void)heartImagedisplay{
    [self dataAcquisitionRotateSpinningHeartView];
}


- (void)dataAcquisitionRotateSpinningHeartView  //view xuanzhuan
{

            if (_ranking == 0) {
                [GPFRankingListHandler modelByDataSouceArray:_rankingListArray adminNumber:self.adminNumber adminName:self.adminName isRanking:^(BOOL isRanking, NSInteger rankNum) {
                    if (isRanking) {
                        _ranking = rankNum +_rankingListPage*self.pageNumber;
                        _cameraSum = self.adminNumber;
                        [self.delegate adminByRankingList:self ranking:_ranking score:_cameraSum];
                        [self setNeedsDisplay];
                        
                        [self drawViewRect:0 cameraIcon:_ranking-1 - self.pageNumber *_rankingListPage];

                    }else{
                        [self.delegate adminByRankingList:self ranking:0 score:0];
                        [self setNeedsDisplay];
                        
                        [self drawViewRect:0 cameraIcon:_ranking-1 - self.pageNumber *_rankingListPage];
                    }
                  }];
            }else{
                [self setNeedsDisplay];
                if (_ranking !=0 ) {
                     [self drawViewRect:0 cameraIcon:_ranking-1 - self.pageNumber *_rankingListPage];
                }else{
                     [self drawViewRect:0 cameraIcon:-1];
                }
               
                
            }

}

-(void)animationView:(NSInteger)integer direction:(BOOL)direction{ // 头像
    UIImageView *imageview;
     //  NSLog(@"%ld",integer);
    imageview = [self loadImageViewAtIndex:integer];
    [UIView animateWithDuration:0.05 animations:^{
        
        imageview.alpha=0.1;
    } completion:^(BOOL finished) {
        
        if (direction) {
            if (integer<_rankingListArray.count-1) {
                [self animationView:integer+1 direction:direction];
            }
        }else{
            
            if (integer>0 ) {
                [self animationView:integer-1 direction:direction];
            }
        }
        
    }];
}


//头像挨个显现出来
-(void)drawViewRect:(NSInteger )integer cameraIcon:(NSInteger)cameraIcon{
    
    UIImageView *imageview;
  
    imageview = [self loadImageViewAtIndex:(self.pageNumber-1-integer)];
    [UIView animateWithDuration:0.05 animations:^{

        if (cameraIcon==-1) {
            imageview.alpha=0.6;
        }else{
            imageview.alpha=0.6;
            if (integer==cameraIcon) {
                imageview.alpha=1.0;
            }

        }
        
    } completion:^(BOOL finished) {
 
        if (integer<self.pageNumber - 1) {
            [self drawViewRect:integer+1 cameraIcon:cameraIcon];
        }
  
    }];
    
}


@end
