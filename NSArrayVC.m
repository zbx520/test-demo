//
//  NSArrayVC.m
//  test
//
//  Created by 张先生 on 2021/4/1.
//

// 这是mian分支的代码.
// 这是test1分支的代码

#import "NSArrayVC.h"

/* 知识点1 NSArray类簇
 1、__NSPlaceholderArray 只进行内存分配，单例对象，地址相同
 2、__NSArray0单例 创建空的不可变数组，单例对象，地址相同
 3、__NSSingleObjectArrayI 创建单元素数组
 4、__NSArrayI 传统意义上的数组对象
 */

/* 知识点2 NSMutableArray类簇
 1、__NSPlaceholderArray 只进行内存分配，单例对象，地址相同
 2、__NSArrayM 传统意义上的可变数组对象
 */

/* 知识点3 内存分配
 c语言数组 连续的内存空间, memmove原理：插入一个元素时, 移动其后面所有的元素
 NSArray 连续的内存空间
 NSMutableArray 环形缓冲区，只会移动最少的一边元素
 */

@interface NSArrayVC ()

@end

@implementation NSArrayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array0 = [NSArray alloc];
    NSArray *array00 = [NSArray alloc];

    NSLog(@"%@ %p", array0.class, array0);
    NSLog(@"%@ %p", array00.class, array00);

    // __NSPlaceholderArray 0x1d7400850
    // __NSPlaceholderArray 0x1d7400850

    NSArray *array1 = @[];
    NSArray *array11 = [[NSArray alloc] init];

    NSLog(@"%@ %p", array1.class, array1);
    NSLog(@"%@ %p", array11.class, array11);

    // __NSArray0 0x1d723d940
    // __NSArray0 0x1d723d940

    NSArray *array2 = @[@"111"];
    NSArray *array22 = [NSArray arrayWithObject:@"sad"];

    NSLog(@"%@ %p", array2.class, array2);
    NSLog(@"%@ %p", array22.class, array22);

    // __NSSingleObjectArrayI 0x2838e0d20
    // __NSSingleObjectArrayI 0x2838e0d10

    NSArray *array3 = @[@"111", @"111"];
    NSArray *array33 = [NSArray arrayWithObjects:@"111", @"111", nil];
    NSArray *array333 = [[NSArray alloc] initWithObjects:@"111", @"111", nil];

    NSLog(@"%@ %p", array3.class, array3);
    NSLog(@"%@ %p", array33.class, array33);
    NSLog(@"%@ %p", array333.class, array333);

    // __NSArrayI 0x2831173a0
    // __NSArrayI 0x2831174e0
    // __NSArrayI 0x283117460
    
    
    NSMutableArray *muarray0 = [NSMutableArray alloc];
    NSMutableArray *muarray00 = [NSMutableArray alloc];
    
    NSLog(@"%@ %p", muarray0.class, muarray0);
    NSLog(@"%@ %p", muarray00.class, muarray00);
    
    // __NSPlaceholderArray 0x1d7400860
    // __NSPlaceholderArray 0x1d7400860
        
    NSMutableArray *muarray1 = @[]; //  变成NSArray
    NSMutableArray *muarray11 = [[NSMutableArray alloc] init];
    
    NSLog(@"%@ %p", muarray1.class, muarray1);
    NSLog(@"%@ %p", muarray11.class, muarray11);
    
    // __NSArray0 0x1d723d940  变成NSArray
    // __NSArrayM 0x281a4acd0
    
    NSMutableArray *muarray2 = @[@"111"]; //  变成NSArray
    NSMutableArray *muarray22 = [NSMutableArray arrayWithObject:@"sad"];
    
    NSLog(@"%@ %p", muarray2.class, muarray2);
    NSLog(@"%@ %p", muarray22.class, muarray22);
    
    // __NSSingleObjectArrayI 0x28162c3e0  变成NSArray
    // __NSArrayM 0x281a4afd0
    
    NSMutableArray *muarray3 = @[@"111", @"111"]; //  变成NSArray
    NSMutableArray *muarray33 = [NSMutableArray arrayWithObjects:@"111", @"111", nil];
    NSMutableArray *muarray333 = [[NSMutableArray alloc] initWithObjects:@"111", @"111", nil];

    NSLog(@"%@ %p", muarray3.class, muarray3);
    NSLog(@"%@ %p", muarray33.class, muarray33);
    NSLog(@"%@ %p", muarray333.class, muarray333);

    // __NSArrayI 0x28140a620 变成NSArray
    // __NSArrayM 0x281a4aee0
    // __NSArrayM 0x281a4adf0
    
        
    
    // c语言 连续的内存空间
    int xcdsc[5] = {1,2,3,4,5}; // xcdsc是一个指向&xcdsc[0]的指针，即数组xcdsc第一个元素的地址
    NSLog(@"%d", *(xcdsc + 2)); // 指针地址向后偏移2，加上*表示获取值
    NSLog(@"%d", xcdsc[2]); // 等同写法
    
    // oc语言
    NSArray* array = @[];
    // array是一个指向NSArray对象的指针
    NSLog(@"%p", array);
    for (int i = 0; i < 5; i++) {
        NSString * sss = @"strrdgfdgfgfgfgfdgfd";
        NSLog(@"%p", sss);
        array = [array arrayByAddingObject:sss]; // 指针地址偏移
    }
    NSLog(@"%p", array);
}


@end
