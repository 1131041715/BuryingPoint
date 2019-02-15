//
//  ViewController.m
//  BuryingPoint
//
//  Created by 大豌豆 on 19/F/15.
//  Copyright © 2019 大碗豆. All rights reserved.
//

#import "ViewController.h"

#define FILELOG_SUPPORT(str) [self redirectNSlogToDocumentFolder:str]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton new];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 100, 140, 140);
    [btn setTitle:@"客服服务" forState:(UIControlStateNormal)];
//    [btn setImage:[UIImage imageNamed:@"qwas.png"] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)click:(UIButton *)btn{
    FILELOG_SUPPORT(@"2222");
    NSString *str = FILELOG_SUPPORT(@"2222");
    NSLog(@"%@",str);
}

#pragma mark 通过宏调用自定义方法 --- 无参数无返回值的宏，带参数的宏，带返回值的宏，
- (NSString *)redirectNSlogToDocumentFolder:(NSString *)parameter{
    NSLog(@"通过宏定义调用自定义的方法~~~~%@",parameter);
    NSString *strReturn = @"我是返回值";
    
    //需要写入的数据
    NSString *str = @"1234567890";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self writeToFolderDirCache:data folder:@"12" file:@"test1"];
    
    return strReturn;
}

//写入Cache自定义的文件夹中
- (void)writeToFolderDirCache:(NSData *)data folder:(NSString *)folderName file:(NSString *)fileName{
    //创建文件夹
    NSString *documentsPath =[self dirCache];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:folderName];
    // 创建目录
    NSError *error;
    BOOL res=[fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    if (res) {
        NSLog(@"文件夹创建成功");
    }else{
        NSLog(@"文件夹创建失败 --- %@",error);
    }
    NSString *FileName=[testDirectory stringByAppendingPathComponent:fileName];
    //写入文件
    [data writeToFile:FileName atomically:YES];
}
//获取Cache目录
-(NSString *)dirCache{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSLog(@"app_home_lib_cache: %@",cachePath);
    return cachePath;
}

@end
