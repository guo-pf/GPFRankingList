//
//  GPFRankingListView.m
//  GPFRankingList
//
//  Created by guo-pf on 2017/5/1.
//  Copyright © 2017年 guo-pf. All rights reserved.
//

#import "GPFRankingListView.h"
#import "GPFRankingListRouletteView.h"
#import "GPFDataCalculateUtils.h"


@interface GPFRankingListView ()<RankingListRouletteDelegate>

@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *rankingListSumLabel;
@property (nonatomic, strong) UILabel *rankingListLabel;

@property (nonatomic, strong) GPFRankingListRouletteView *rouletteView;

@property (nonatomic, strong) NSMutableArray *rankingLists;

@end

@implementation GPFRankingListView{
    
      NSInteger adminRanking;              //判断是否进入排行榜，如果进入了 排第几
      CGFloat screenWidth;                          //宽度
      CGPoint centerPoint;                          //中心点
      NSInteger  _cameraSum;                          //本身的数据
      NSInteger _scollPage;
      BOOL firstDraw;
    
    CGPoint touchPoint;
    CGPoint beginTouchPoint;
    
    BOOL _isLoding;
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
        
        if (self.frame.size.width <= self.frame.size.height) {
            screenWidth = self.frame.size.width;
        }else{
            screenWidth = self.frame.size.height;
        }
         [self initCongifig];
        _isLoding = NO;
    }
    return self;
}

-(void)initCongifig{

    
        self.backgroundColor = [UIColor clearColor];
    
        self.circleColor = [UIColor whiteColor];
    
        self.rankScoreColor = [UIColor whiteColor];
    
        self.fromToColor = [UIColor redColor];
    
        self.signRankingColor = [UIColor yellowColor];
    
        self.outRankingColor = [UIColor greenColor];
    
        self.adminScoreColor = [UIColor brownColor];
    
        self.heartLineColor = [UIColor cyanColor];
    
        self.adminHeartLineColor = [UIColor greenColor];
    
        self.signMessageColor = [UIColor redColor];
    
       self.outMessageColor = [UIColor greenColor];

    
       // self.maxRanking = 50;
        self.pageNumber = 15;
       // self.isUpRanking = YES;
        firstDraw = YES;
        _scollPage = 0;
        adminRanking = 0;
        centerPoint = CGPointMake(screenWidth/2, screenWidth/2);
    
}

-(NSMutableArray *)rankingLists{
    if (!_rankingLists) {
        _rankingLists = [[NSMutableArray alloc]init];
    }
    return _rankingLists;
}

#pragma mark - ui及配置

-(GPFRankingListRouletteView *)rouletteView{
    if (!_rouletteView) {
        _rouletteView =  [[GPFRankingListRouletteView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenWidth)];
        [self addSubview:_rouletteView];
         _rouletteView.delegate = self;
    }
    return _rouletteView;
}

-(UILabel *)rankingListSumLabel{
    if (!_rankingListSumLabel) {
        _rankingListSumLabel = [[UILabel alloc]init];
        _rankingListSumLabel.adjustsFontSizeToFitWidth=YES;
        _rankingListSumLabel.textColor=self.adminScoreColor;
        _rankingListSumLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_rankingListSumLabel];
    }
    return _rankingListSumLabel;
}
-(UILabel *)rankingListLabel{
    if (!_rankingListLabel) {
        _rankingListLabel = [[UILabel alloc]init];
        _rankingListLabel.numberOfLines = 0;
        _rankingListLabel.adjustsFontSizeToFitWidth = YES;
        
        _rankingListLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_rankingListLabel];
    }
    return _rankingListLabel;
}
-(UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc]init];
        _scoreLabel.adjustsFontSizeToFitWidth=YES;
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_scoreLabel];
    }
    return _scoreLabel;
}

#pragma mark - 赋值

-(void)setCircleColor:(UIColor *)circleColor{
    _circleColor = circleColor;
}

-(void)setSignRankingColor:(UIColor *)signRankingColor{
    _signRankingColor = signRankingColor;
}

-(void)setOutRankingColor:(UIColor *)outRankingColor{
    _outRankingColor = outRankingColor;
}


-(void)setSignMessageColor:(UIColor *)signMessageColor{
    _signMessageColor = signMessageColor;
}

-(void)setOutMessageColor:(UIColor *)outMessageColor{
    _outMessageColor = outMessageColor;
}

-(void)setAdminScoreColor:(UIColor *)adminScoreColor{
    _adminScoreColor = adminScoreColor;
    self.rouletteView.adminScoreColor = _adminScoreColor;
}


-(void)setRankScoreColor:(UIColor *)rankScoreColor{
    _rankScoreColor = rankScoreColor;
    self.rouletteView.rankScoreColor = _rankScoreColor;
}

-(void)setFromToColor:(UIColor *)fromToColor{
    _fromToColor = fromToColor;
     self.rouletteView.fromToColor = _fromToColor;
}


-(void)setHeartLineColor:(UIColor *)heartLineColor{
    _heartLineColor = heartLineColor;
    self.rouletteView.heartLineColor = _heartLineColor;
}

-(void)setAdminHeartLineColor:(UIColor *)adminHeartLineColor{
    _adminHeartLineColor = adminHeartLineColor;
      self.rouletteView.adminHeartLineColor = _adminHeartLineColor;
}


-(void)setDefaultHeartImageName:(NSString *)defaultHeartImageName{
    _defaultHeartImageName = defaultHeartImageName;
     self.rouletteView.defaultHeartImageName = _defaultHeartImageName;
}

-(void)setImageNULLName:(NSString *)imageNULLName{
    _imageNULLName = imageNULLName;
    self.rouletteView.imageNULLName = _imageNULLName;
}

-(void)setPageNumber:(NSInteger)pageNumber{
    _pageNumber = pageNumber;
    self.rouletteView.pageNumber = _pageNumber;
}


-(void)setTitleName:(NSString *)titleName{
    _titleName = titleName;
    self.rouletteView.titleName = _titleName;
}

-(void)setAdminName:(NSString *)adminName{
    _adminName = adminName;
    self.rouletteView.adminName = _adminName;
}

-(void)setAdminNumber:(NSInteger)adminNumber{
    _adminNumber = adminNumber;
     self.rouletteView.adminNumber = _adminNumber;
}

#pragma mark - 绘图

-(void)shapeLayerPath:(UIBezierPath*)path{
    CAShapeLayer *pathLayer =[CAShapeLayer layer];
    // pathLayer.frame = self.frame;
    pathLayer.path =path.CGPath;
    pathLayer.opacity=0.8;
    pathLayer.strokeColor = self.circleColor.CGColor;
    pathLayer.lineWidth =1.5f;
    pathLayer.fillColor = [[UIColor clearColor]CGColor];
    pathLayer.lineJoin = kCALineJoinBevel;
    [self.layer addSublayer:pathLayer];
    
}

-(void)drawArcLayer{
    
    float radius =screenWidth/3;
    
    UIBezierPath *path =[UIBezierPath bezierPath];
    [path addArcWithCenter:centerPoint radius:radius startAngle:0 endAngle:2*M_PI clockwise:NO];
    [self shapeLayerPath:path];
    //我的排名
    UIBezierPath *userPath =[UIBezierPath bezierPath];
    CGPoint userPoint ={centerPoint.x,centerPoint.y-radius/3};
    [userPath addArcWithCenter:userPoint radius:radius/3 startAngle:0 endAngle:2*M_PI clockwise:NO];
    
    [self shapeLayerPath:userPath];
    
    
    NSString *mystr=[NSString stringWithFormat:@"%ld",_cameraSum];
    
    CGSize myTextSize =[GPFDataCalculateUtils calculateSize:radius/3 sizeStr:mystr strWidth:radius/3 strHight:CGFLOAT_MAX];
    
    self.scoreLabel.frame = CGRectMake(userPoint.x-radius/6, userPoint.y-myTextSize.height/2, radius/3, myTextSize.height);
    
    UIColor *scoreColor;
    if(adminRanking==0){
        self.scoreLabel.text=@"无排名";
        scoreColor = self.outRankingColor;
    }else{
        self.scoreLabel.text=[NSString stringWithFormat:@"第%ld名",adminRanking];
        scoreColor = self.signRankingColor;
    }
    
    
    self.scoreLabel.textColor=scoreColor;

    NSString *rankingListstr;
    UIColor *rankingListstrColor;
    if (adminRanking==0) {
        rankingListstr=@"对不起，您暂未上榜，请继续努力";
        rankingListstrColor = self.outMessageColor;
    }else{
        rankingListstr=@"恭喜您，已上榜，请继续保持啊";
        rankingListstrColor = self.signMessageColor;
        
    }
    
    CGSize rankingListTextSize =[GPFDataCalculateUtils calculateSize:15 sizeStr:rankingListstr strWidth:radius*4/3 strHight:CGFLOAT_MAX];
    self.rankingListLabel.frame = CGRectMake(userPoint.x-radius*2/3, userPoint.y+radius/3 +5, radius*4/3, rankingListTextSize.height);
    self.rankingListLabel.text=rankingListstr;
    self.rankingListLabel.textColor=rankingListstrColor;
    
    
    CGSize rankingListSumTextSize =[GPFDataCalculateUtils calculateSize:15 sizeStr:mystr strWidth:radius strHight:CGFLOAT_MAX];
    
    self.rankingListSumLabel.frame = CGRectMake(self.rankingListLabel.frame.origin.x+self.rankingListLabel.frame.size.width/2-radius/2, CGRectGetMaxY(self.rankingListLabel.frame)+rankingListSumTextSize.height/2, radius, rankingListSumTextSize.height);
    
    self.rankingListSumLabel.text=mystr;
    
}



-(void)startDrawRankingListWithDataSourceArr:(NSArray *)dataSourceArr pageIndex:(NSInteger)pageIndex{
    // [self.rouletteView initListStartDelegate];
//    if (dataSourceArr.count) {
//        
//    }else{
//        [self recoveryDrawRankingListWithMessage:nil];
//        return;
//    }
    if (self.rankingLists.count <= pageIndex && dataSourceArr.count) {
        [self.rankingLists addObject:dataSourceArr];
    }
    
    if (self.rankingLists.count > _scollPage) {
        
        if (firstDraw == NO) {
            if (_isLoding) {
                
                 [self.rouletteView  handleSwipeLowerLevel];
              //  CGAffineTransform transform =CGAffineTransformMakeRotation((180.1) * M_PI / 180.0);
                
                 [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    [self.rouletteView setTransform:CGAffineTransformRotate(self.transform, (180.1) * M_PI / 180.0)];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                         [self.rouletteView setTransform:CGAffineTransformRotate(self.rouletteView.transform, (180.1) * M_PI / 180.0)];

                    } completion:^(BOOL finished) {
                        [self.rouletteView setTransform:CGAffineTransformRotate(self.transform, 0)];
                       [self.rouletteView heartImagedisplay];
                    }];
                    
                    
                }];
                
            }else{
                [self.rouletteView  handleSwipeUpperLevel];
               
                [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                   
                    [self.rouletteView setTransform:CGAffineTransformRotate(self.transform, (179.9) * M_PI / 180.0)];
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                        
                        [self.rouletteView setTransform:CGAffineTransformRotate(self.rouletteView.transform, (179.9) * M_PI / 180.0)];
                    } completion:^(BOOL finished) {
                        [self.rouletteView setTransform:CGAffineTransformRotate(self.transform, 0)];
                        [self.rouletteView heartImagedisplay];
                    }];
                    
                    
                }];
            }
            
        }
        firstDraw = NO;
        [self.rouletteView startDrawRankingListWithDataSourceArr:self.rankingLists[_scollPage]];

    }else{
        [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.rouletteView setTransform:CGAffineTransformRotate(self.transform, 0)];
        } completion:^(BOOL finished) {
            
        }];

    }
    
}
-(void)recoveryDrawRankingListWithMessage:(NSString *)Message{
    if (_scollPage>0) {
      _scollPage --;
    }
    
    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.rouletteView setTransform:CGAffineTransformRotate(self.transform, 0)];
    } completion:^(BOOL finished) {
        
    }];
}

-(void) adminByRankingList:(GPFRankingListRouletteView *)rankinglistView ranking:(NSInteger)ranking score:(NSInteger)score{
    
    if (adminRanking != ranking || firstDraw) {
        adminRanking = ranking;
        _cameraSum = score;
        [self drawArcLayer];
     //   firstDraw = NO;
    }else if(ranking == 0 ){
         adminRanking = ranking ;
         [self drawArcLayer];
    }
}


-(void)startRanking{
    [self.delegate rankingListDidScroll:self pageCount:self.pageNumber pageIndex:0];

}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    

    UITouch *touch = [touches anyObject];
    beginTouchPoint = [touch locationInView:self];

}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint location;
    UITouch *touch = [touches anyObject];
    
    location = [touch locationInView:self];
    CGPoint prevLocation = [touch previousLocationInView:self];
    touchPoint = prevLocation;
  
    
    CGFloat dxLoction = location.y - prevLocation.y;

    if (dxLoction > 0) {
        // xia
        if (location.x<self.frame.size.width/2) {
            _isLoding = YES;
            //+++
            [self.rouletteView setTransform:CGAffineTransformRotate(self.transform,  ((beginTouchPoint.y -touchPoint.y)/self.frame.size.height) * 180*M_PI_4/180)];
            
        }else{
            //----------
            _isLoding = NO;
            [self.rouletteView setTransform:CGAffineTransformRotate(self.transform,  ((touchPoint.y - beginTouchPoint.y )/self.frame.size.height) * 180*M_PI_4/180)];

        }
        
        
        
        
    }else  if (dxLoction < 0) {
        // shang
        if (location.x<self.frame.size.width/2) {
            //-------
            _isLoding = NO;
            [self.rouletteView setTransform:CGAffineTransformRotate(self.transform,  ((beginTouchPoint.y -touchPoint.y)/self.frame.size.height) * 180*M_PI_4/180)];
            
        }else{
            //+++++
            _isLoding = YES;
            [self.rouletteView setTransform:CGAffineTransformRotate(self.transform,  ((touchPoint.y - beginTouchPoint.y )/self.frame.size.height) * 180*M_PI_4/180)];
     
        }
    }
    
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (fabs(touchPoint.y - beginTouchPoint.y) < self.frame.size.height/2) {
        
        
        [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.rouletteView setTransform:CGAffineTransformRotate(self.transform, 0)];
        } completion:^(BOOL finished) {
            
        }];
        

    }else{
 
        if (_isLoding ) {
                _scollPage ++;
                [self.delegate rankingListDidScroll:self pageCount:self.pageNumber pageIndex:_scollPage];
          //  }

        }else{
            if (_scollPage > 0) {
                _scollPage --;
              //  [self.delegate rankingListDidScroll:self pageCount:self.pageNumber pageIndex:_scollPage];
                [self startDrawRankingListWithDataSourceArr:nil pageIndex:_scollPage];
            }else{
                [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [self.rouletteView setTransform:CGAffineTransformRotate(self.transform, 0)];
                } completion:^(BOOL finished) {
                    
                }];

            }
 
        }
       
        
    }

    
}


@end
