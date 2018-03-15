//
//  ViewController.m
//  排序算法
//
//  Created by 廖靖宇 on 2018/3/15.
//  Copyright © 2018年 liaojingyu. All rights reserved.
//

#import "ViewController.h"
//#import "ChessBoardModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *marr = [@[@4,@11,@9,@3,@14,@22,@2,@3,@100,@19,@1,@21] mutableCopy];
    NSLog(@"初始:%@", [self stringFromArray:marr head:0 tail:marr.count-1]);
    
    //    [self maopaoDemo:marr];
    //    [self fastDemo:marr head:0 tail:marr.count-1];
    //    [self directInsetDemo:marr];
    //    [self dichotomyInsetDemo:marr];
    NSLog(@"最终:%@", [self stringFromArray:marr head:0 tail:marr.count-1]);
}
#pragma mark - 冒泡排序
- (void)maopaoDemo:(NSMutableArray *)marr{
    if (marr.count <= 1) {return;}
    
    for (int i=0; i<marr.count; i++) {
        for (int j=i+1; j<marr.count; j++) {
            if ([marr[i] integerValue] > [marr[j] integerValue]) {
                NSNumber *t = marr[j];
                marr[j] = marr[i];
                marr[i] = t;
            }
        }
    }
    NSLog(@"marr:%@",marr);
}
#pragma mark - 快速排序
- (void)fastDemo:(NSMutableArray *)marr head:(NSInteger)head tail:(NSInteger)tail{
    if (marr.count <= 1) {return;}
    if (head<0 || tail>marr.count-1) {return;}
    if (head>=tail) {return;}
    
    NSInteger low = head;
    NSInteger hight = tail;
    BOOL kRight = NO;       // 比较的基数是否已交换到右边
    while (1) {
        if (low == hight){
            if (low-head>0) {
                // 左边递归
                NSLog(@"左边递归:%@",[self stringFromArray:marr head:head tail:low-1]);
                [self fastDemo:marr head:head tail:low-1];
            }
            if (tail-hight>0) {
                // 右边递归
                NSLog(@"右边递归:%@",[self stringFromArray:marr head:hight+1 tail:tail]);
                [self fastDemo:marr head:hight+1 tail:tail];
            }
            break;
        }
        
        // 交换
        if (marr[low] > marr[hight]) {
            id t = marr[hight];
            marr[hight] = marr[low];
            marr[low] = t;
            kRight = !kRight;
            NSLog(@"交换后:%@",[self stringFromArray:marr head:head tail:tail]);
        }
        kRight ? low++ : hight--;
    }
}
- (NSString *)stringFromArray:(NSArray *)arr head:(NSInteger)head tail:(NSInteger)tail{
    NSMutableString *mstr = [@"" mutableCopy];
    for (NSInteger i=head; i<=tail; i++) {
        [mstr appendString:[NSString stringWithFormat:@"%@,",arr[i]]];
    }
    return [mstr copy];
}
#pragma mark - 插入排序
// 直接插入排序
- (void)directInsetDemo:(NSMutableArray *)marr{
    if (marr.count <= 1) {return;}
    
    for (int i=1; i<marr.count; i++) {
        // 顺序不对
        if (marr[i]<marr[i-1]) {
            id inset = marr[i];
            
            // 开始插入交换
            for (int j=i; j>0; j--) {
                if (marr[j] > marr[j-1]) {
                    break;
                }
                marr[j] = marr[j-1];
                marr[j-1] = inset;
            }
        }
    }
}
// 二分插入排序
- (void)dichotomyInsetDemo:(NSMutableArray *)marr{
    if (marr.count <= 1) {return;}
    
    for (int i=1; i<marr.count; i++) {
        if (marr[i] < marr[i-1]) {
            
            id inset = marr[i];
            // 开始二分查找排序
            NSLog(@"开始二分查找排序 obj:%@ array:%@", inset, [self stringFromArray:marr head:0 tail:i-1]);
            NSInteger insetIndex = [self insetIndexOfObject:inset inArray:marr head:0 fail:i-1];
            
            for (int j=i; j>insetIndex; j--) {
                marr[j] = marr[j-1];
            }
            marr[insetIndex] = inset;
            NSLog(@"替换后的数组：%@", [self stringFromArray:marr head:0 tail:marr.count-1]);
        }
    }
}
// 二分查找法
static const NSInteger kErrorIndex = -99;       // 查找错误，比如不满足查找条件时，返回此值
- (NSInteger)insetIndexOfObject:(id)obj inArray:(NSArray *)arr head:(NSInteger)head fail:(NSInteger)fail{
    NSInteger errorIndex = kErrorIndex;
    if (!obj) {return errorIndex;}
    if (head < 0 || fail > arr.count-1) {return errorIndex;}
    if (head > fail) {return errorIndex;}
    
    NSInteger insetIndex = errorIndex;
    NSInteger centerIndex = head + (fail - head)/2;
    if (arr[centerIndex] == obj) {
        insetIndex = centerIndex+1;
        NSLog(@"--中心值相等center:%ld insetIndex:%ld", centerIndex, insetIndex);
    }else if (arr[centerIndex] > obj) {
        if (centerIndex <= head){
            // 最小
            insetIndex = centerIndex;
            NSLog(@"--比最左还小 insetIndex:%ld", insetIndex);
        }else{
            NSLog(@"--head:%ld fail:%ld center:%ld 左边二分查找obj:%@ arr:%@", head, fail, centerIndex, obj , [self stringFromArray:arr head:head tail:centerIndex]);
            insetIndex = [self insetIndexOfObject:obj inArray:arr head:head fail:centerIndex];
        }
    }else {
        if (centerIndex >= fail) {
            // 最大
            insetIndex = centerIndex+1;
            NSLog(@"--比最右还大 insetIndex:%ld", insetIndex);
        }else{
            NSLog(@"--head:%ld fail:%ld center:%ld 右边二分查找obj:%@ arr:%@", head, fail, centerIndex, obj , [self stringFromArray:arr head:centerIndex+1 tail:fail]);
            insetIndex = [self insetIndexOfObject:obj inArray:arr head:centerIndex+1 fail:fail];
        }
    }
    return insetIndex;
}

@end



