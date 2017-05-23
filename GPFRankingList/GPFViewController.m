//
//  ViewController.m
//  GPFRankingList
//
//  Created by IAP-guo-pf on 17/4/24.
//  Copyright © 2017年 guo-pf. All rights reserved.
//

#import "GPFViewController.h"
#import "GPFRankingListView.h"

#import "GPFRankingListModel.h"

#import "GPFRankingListHandler.h"
#import "AFNetworking.h"



@interface GPFViewController () <RankingListDelegate>


@property (nonatomic, strong) NSMutableArray *rankingListDataSouce;

@property (nonatomic, strong) GPFRankingListView *rankingListView;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIButton *simulationBtn;

@end

@implementation GPFViewController{
    BOOL _isReal;
    NSInteger myCount;
    NSInteger myIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    _isReal = NO;

    self.rankingListDataSouce = [NSMutableArray arrayWithArray:[self addDataSouce]];

    
    self.rankingListView = [[GPFRankingListView alloc]initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds))];
    
    self.rankingListView.defaultHeartImageName = @"imageLoading";
    self.rankingListView.imageNULLName = @"imageNULL";
   // self.rankingListView.pageNumber = 20;
    [self.view addSubview:self.rankingListView];
    self.rankingListView.delegate = self;
     self.rankingListView.titleName  = @"rankingTitle";
//    self.rankingListView.adminName = @"习大大";
//    self.rankingListView.adminNumber = 38;
    
//    self.rankingListView.adminName = @"张三";
//    self.rankingListView.adminNumber = 12;
    
//    self.rankingListView.adminName = @"宇宙";
//    self.rankingListView.adminNumber = 69;
    
   //  [self.rankingListView startRanking];
    
    self.btn = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.view.bounds) - 100, self.view.frame.size.width - 100, 30)];
    [self.btn setTitle:@"排行榜" forState:UIControlStateNormal];
    [self.view addSubview:self.btn];
    [self.btn addTarget:self action:@selector(rangkingListStart:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.simulationBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.btn.frame) + 20, self.view.frame.size.width - 100, 30)];
    [self.simulationBtn setTitle:@"模拟" forState:UIControlStateNormal];
    [self.view addSubview:self.simulationBtn];
    [self.simulationBtn addTarget:self action:@selector(rangkingListStart:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) rankingListDidScroll:(GPFRankingListView *)rankingListView
                   pageCount:(NSInteger)pageCount//每页多少个
                  pageIndex:(NSInteger)pageIndex//第几页 从0开始的
{
    if (_isReal) {  //真实用法
        
    
    if (rankingListView == self.rankingListView) {
        NSLog(@"开始了");
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        // 超时时间
        manager.requestSerializer.timeoutInterval = 30;
       manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
        
        // 声明获取到的数据格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
        
        [manager POST:@"" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //数据格式 对应model 或者对应例子的假数据也可
            NSMutableArray * arr = [[NSMutableArray alloc]init];
            for (NSInteger i = pageCount *pageIndex; i<pageCount *(pageIndex+1); i++) {
                if (self.rankingListDataSouce.count > i ) {
                    [arr addObject:self.rankingListDataSouce[i]];
                }else{
                    break;
                }
                
            }
            if (arr.count) {
                [self.rankingListView startDrawRankingListWithDataSourceArr:arr pageIndex:pageIndex];//这里传数据
            }else{
                [self.rankingListView recoveryDrawRankingListWithMessage:nil];
            }
            NSLog(@"成功了");

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
            [self.rankingListView recoveryDrawRankingListWithMessage:nil];

               NSLog(@"失败了");

        }];
       
    }
    }else{      //模拟

        
        NSMutableArray * arr = [[NSMutableArray alloc]init];
        for (NSInteger i = pageCount *pageIndex; i<pageCount *(pageIndex+1); i++) {
            if (self.rankingListDataSouce.count > i ) {
                [arr addObject:self.rankingListDataSouce[i]];
            }else{
                break;
            }
            
        }
        if (arr.count) {
            [self.rankingListView startDrawRankingListWithDataSourceArr:arr pageIndex:pageIndex];//这里传数据
        }else{
            [self.rankingListView recoveryDrawRankingListWithMessage:nil];
        }
      

        
    }
    
}

- (void)delayDo : (id)sender {
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSInteger i = myCount *myIndex; i<myCount *(myIndex+1); i++) {
        if (self.rankingListDataSouce.count > i ) {
            [arr addObject:self.rankingListDataSouce[i]];
        }else{
            break;
        }
        
    }
    if (arr.count) {
        [self.rankingListView startDrawRankingListWithDataSourceArr:arr pageIndex:myIndex];//这里传数据
    }else{
        [self.rankingListView recoveryDrawRankingListWithMessage:nil];
    }

}

-(void)rangkingListStart:(UIButton *)sender{
    if (sender == self.btn) {
        _isReal = YES;
    }else{
        _isReal = NO;
    }
    [self.rankingListView startRanking];

}


//假数据   这里正常是从外界获取数据，然后对应成相应的数据即可。
-(NSArray *)addDataSouce{
    NSArray *numberArr = @[@"10",@"11",@"12",@"12",@"12",@"13",@"15",@"16",@"17",@"21",
                           @"22",@"24",@"25",@"27",@"29",@"30",@"32",@"33",@"36",@"37",
                           @"38",@"40",@"41",@"42",@"44",@"45",@"46",@"47",@"47",@"48",
                           @"49",@"51",@"52",@"54",@"57",@"58",@"59",@"60",@"61",@"62",
                           @"69",@"74",@"78",@"79",@"79",@"83",@"83",@"88",@"93",@"101"];
    
    
    
    NSArray *nameArr = @[@"张三",@"李四",@"张三",@"刘欢",@"德化",@"大康",@"高三",@"亮片",@"花花",@"小二",
                         @"奇怪",@"郁闷",@"嘻嘻",@"哈哈",@"蚂蚁",@"哼哈",@"iOS",@"安卓",@"八卦",@"成了",
                         @"习大大",@"奥巴马",@"数据",@"暴雨",@"金链",@"门清",@"厚厚",@"秦始皇",@"武则天",@"武大郎",
                         @"疯子",@"蚂蚁",@"大象",@"星星",@"月亮",@"太阳",@"奇怪",@"iOS",@"八卦",@"鸡蛋",
                         @"宇宙",@"神仙",@"男人",@"女人",@"老人",@"小孩",@"玫瑰",@"仙人掌",@"月季",@"嫦娥"];
    NSArray *iconArr = @[@"0",@"2",@"1",@"3",@"4",@"5",@"6",@"7",@"8",@"9",
                         @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"1",
                         @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"1",@"2",
                         @"6",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"1",@"2",
                         @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"1"];
    NSMutableArray *dataSouce = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i<50; i++) {
        GPFRankingListModel *model = [[GPFRankingListModel alloc]init];
        model.name = nameArr[i];
        model.number = [numberArr[i] integerValue];
        NSString *heart = @"file://";
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:iconArr[i] ofType:@"png"];
      model.heartIamgeURL = [heart stringByAppendingString:imagePath];
        [dataSouce addObject:model];
        
    }
   
    return dataSouce;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
