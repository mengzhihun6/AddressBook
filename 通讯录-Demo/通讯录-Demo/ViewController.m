//
//  ViewController.m
//  通讯录-Demo
//
//  Created by stkcctv on 16/8/24.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "ViewController.h"
#import "ChineseString.h"
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHight [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate> {
    NSArray *_nameArr;
}

@property (nonatomic, strong) NSMutableArray *dataArrM;
@property(nonatomic,strong)NSMutableArray *indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;

@property (nonatomic, strong) UILabel *sectionTitleView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.sectionTitleView = ({
        UILabel *sectionTitleView = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth-100)/2, (kDeviceHight-100)/2,100,100)];
        sectionTitleView.textAlignment = NSTextAlignmentCenter;
        sectionTitleView.font = [UIFont boldSystemFontOfSize:60];
        sectionTitleView.textColor = [UIColor blueColor];
        sectionTitleView.backgroundColor = [UIColor whiteColor];
        sectionTitleView.layer.cornerRadius = 6;
        sectionTitleView.layer.borderWidth = 1.f/[UIScreen mainScreen].scale;
        _sectionTitleView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        sectionTitleView;
    });
    
    
    
    
    [self dataArrM];

    self.indexArray = [ChineseString IndexArray:_nameArr];
    self.letterResultArr = [ChineseString LetterSortArray:_nameArr];
    
//    NSLog(@"_indexArray: %@",_indexArray);
//    NSLog(@"_letterResultArr: %@",_letterResultArr);

}

- (NSMutableArray *)dataArrM {
    
    if (!_dataArrM) {
        _dataArrM = [NSMutableArray array];
        _nameArr = @[@"李灵黛",@"冷文卿",@"阴露萍",@"柳兰歌",@"秦水支",@"李念儿",@"文彩依",@"柳婵诗",@"顾莫言",@"任水寒",@"金磨针",@"丁玲珑",@"凌霜华",@"水笙",@"容柒雁"];
        for (int i = 0; i < _nameArr.count; i++) {
            NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
            muDic[@"name"] = _nameArr[i];
            muDic[@"phone"] = [NSString stringWithFormat:@"%d578",arc4random_uniform(100)];
            
            [_dataArrM addObject:muDic];
        }
//        NSLog(@" _dataArrM:   %@",_dataArrM);
    }
    
    return _dataArrM;
}



#pragma mark - UITableViewDataSource -

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.indexArray objectAtIndex:section];
    return key;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.letterResultArr objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    NSString *nameStr = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSString *phoneStr;
    for (NSDictionary *dic in self.dataArrM) {
        if ([nameStr isEqualToString:dic[@"name"]]) {
            phoneStr = dic[@"phone"];
        }
    }

    cell.textLabel.text = nameStr;
    cell.detailTextLabel.text = phoneStr;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    [self showSectionTitle:title];
    return index;
}

#pragma mark - UITableViewDelegate -
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    UILabel *lbl = [UILabel new];
//    lbl.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    lbl.text = [self.indexArray objectAtIndex:section];
//    lbl.textColor = [UIColor blackColor];
//    return lbl;
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     NSString *nameStr = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSString *phoneStr;
    for (NSDictionary *dic in self.dataArrM) {
        if ([nameStr isEqualToString:dic[@"name"]]) {
            phoneStr = dic[@"phone"];
        }
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"呼叫:%@",nameStr] message:phoneStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}


#pragma mark - UIAlertViewDelegate -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) return;
    
    
    
    NSLog(@"在此做打电话操作==== %ld",(long)buttonIndex);
    
    
}



#pragma mark - private -
- (void)timerHandler:(NSTimer *)sender {
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
        [UIView animateWithDuration:.3 animations:^{
            self.sectionTitleView.alpha = 0;
        } completion:^(BOOL finished) {
            self.sectionTitleView.hidden = YES;
        }];
    });
}


- (void)showSectionTitle:(NSString *)title {
    
    
    [self.sectionTitleView setText:title];
    self.sectionTitleView.hidden = NO;
    self.sectionTitleView.alpha = 1;
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerHandler:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
