//
//  ViewController.m
//  GCD
//
//  Created by zhaolin01 on 2018/6/1.
//  Copyright © 2018年 zhaolin01. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self syncSerial];
    //[self syncConcurrent];
    //[self asyncSerial];
    //[self asyncConcurrent];
    //[self asyncMainQueue];
    //[self syncMainQueue];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//同步，异步开启新线程的能力。串行，并行队列里的任务有没有同时执行的权利。
//主队列只在主线程中运行
//全局队列和并行队列一样，只是并行队列需要我们自己创建，而全局队列不需要，由系统提供

//同步串行队列  -> 在当前线程按顺序执行
- (void)syncSerial {
    NSLog(@"任务0，当前线程---%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("同步串行", DISPATCH_QUEUE_SERIAL);
    sleep(4);
    dispatch_sync(queue, ^{
        NSLog(@"任务1，当前线程---%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        sleep(5);
        NSLog(@"任务2，当前线程---%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"任务3，当前线程---%@",[NSThread currentThread]);
    });
    sleep(2);
    NSLog(@"任务4，当前线程---%@",[NSThread currentThread]);
}

//同步并行队列 -> 在当前线程按顺序执行
- (void)syncConcurrent {
    NSLog(@"任务0，当前线程---%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("同步并行", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        sleep(5);
        NSLog(@"任务1，当前线程---%@",[NSThread currentThread]);
    });
    sleep(4);
    
    dispatch_sync(queue, ^{
        NSLog(@"任务2，当前线程---%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"任务3，当前线程---%@",[NSThread currentThread]);
    });
    
    sleep(2);
    NSLog(@"任务4，当前线程---%@",[NSThread currentThread]);
}

//异步串行 有开启新线程的能力，因为是串行队列，队列里的任务没有同时执行的能力，所以队列里的任务是按顺序执行的，因为是异步，可以先声明，后执行
- (void)asyncSerial {
    NSLog(@"任务0，当前线程---%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("异步串行", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        sleep(3);
        NSLog(@"任务1，当前线程---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2，当前线程---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3，当前线程---%@",[NSThread currentThread]);
    });
    sleep(2);
    NSLog(@"任务4，当前线程---%@",[NSThread currentThread]);
}

//异步并行队列 异步有开启新线程的能力，并行队列：队列中的任务可以不按顺序执行
- (void) asyncConcurrent {
    NSLog(@"任务0，当前线程---%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("异步并行", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"任务1，当前线程---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2，当前线程---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3，当前线程---%@",[NSThread currentThread]);
    });
    NSLog(@"任务4，当前线程---%@",[NSThread currentThread]);
}

//主队列异步 不开新线程 按顺序执行队列中的任务 可以先声明后执行
- (void)asyncMainQueue {
    NSLog(@"任务0，当前线程---%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"任务1，当前线程---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2，当前线程---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3，当前线程---%@",[NSThread currentThread]);
    });
    NSLog(@"任务4，当前线程---%@",[NSThread currentThread]);
}

//主队列同步 死锁
- (void)syncMainQueue {
    NSLog(@"任务0，当前线程---%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"任务1，当前线程---%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2，当前线程---%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3，当前线程---%@",[NSThread currentThread]);
    });
    NSLog(@"任务4，当前线程---%@",[NSThread currentThread]);
}

@end
