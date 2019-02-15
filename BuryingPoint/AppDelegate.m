//
//  AppDelegate.m
//  BuryingPoint
//
//  Created by 大豌豆 on 19/F/15.
//  Copyright © 2019 大碗豆. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //制定真机调试保存日志文件
    [self redirectNSlogToDocumentFolder];
    return YES;
}

#pragma mark - 用户方法,将NSLog的输出信息写入到.log文件中
// 将NSLog打印信息保存到Document目录下的文件中
- (void)redirectNSlogToDocumentFolder
{
    //文件路径也可以自定义
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@.log",[[NSDate alloc] initWithTimeIntervalSinceNow:8*3600]]; // 注意不是NSData!
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    
    //debug模式下，将打印输出流改变。release模式则正常
#ifdef DEBUG
    // 将log输入到文件
    //    "r"表示“只读访问”、"w"表示“只写访问”、"a"表示“追加写入”。
//    使用定向日志后,Xcode控制台将无法输入日志，如果需要在debug模式下在控制台打印日志，可以注掉下面这句代码
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
    NSLog(@"~~~~%@",logFilePath);
#else
    NSLog(@"~~~~%@",logFilePath);
#endif
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
