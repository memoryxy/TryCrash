//
//  ViewController.m
//  TryCrash
//
//  Created by wangjianfei on 16/2/27.
//  Copyright © 2016年 wangjianfei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, copy) NSArray *all;
@property (nonatomic, copy) NSArray *sectionHeaders;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Try to crash";
    /*
     * 人造异常、崩溃，越多越好，请尽量去找些crash的并增加上去
     * 循环引用的话，测试被循环引用的对象的dealloc 是否调用，如果没调用，就循环引用成功
     */
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    NSArray *exception = @[@"NSArray", @"NSMutableArray", @"NSDictionary", @"NSMutableDictionary", @"Not found selector"];
    NSArray *cycleRetain = @[@"timer", @"KVO", @"block"];
    NSArray *threadException = @[@"死锁", @"多线程同时读写"];
    NSArray *badAccess = @[@"野指针", @"访问常量区"];
    
    self.all            = @[exception, cycleRetain, threadException, badAccess];
    self.sectionHeaders = @[@"异常", @"循环引用", @"线程异常", @"内存崩溃"];
}

#pragma mark - All tests

- (void)testArray {
    NSArray *array = [NSArray new];
    [array objectAtIndex:1];

    // 可以这么解决
//    @try {
//        NSArray *array = [NSArray new];
//        [array objectAtIndex:1];
//    }
//    @catch (NSException *exception) {
//        
//    }
//    @finally {
//        
//    }
    
//    // 也可以
//    if (array.count > 1) {
//        [array objectAtIndex:1];
//    }
    
    // 还可以 写个类别，调用安全的类别
}

- (void)testNoSelector {
    
}

#pragma mark - delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *aSection = self.all[indexPath.section];
    NSString *cell = aSection[indexPath.row];
    
    // TODO: NSArray为例子
    if ([cell isEqualToString:@"NSArray"]) {
        [self testArray];
    } else if ([cell isEqualToString:@"Not found selector"]) {
        [self testNoSelector];
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sectionHeaders[section];
}

#pragma mark - dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *aSection = self.all[section];
    return aSection.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.all.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSArray *aSection = self.all[indexPath.section];
    cell.textLabel.text = aSection[indexPath.row];
    return cell;
}

@end
