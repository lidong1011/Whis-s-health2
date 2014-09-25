//
//  AppDelegate.m
//  DouBanTV
//
//  Created by apple on 14-8-29.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "CaiCaiViewController.h"
#import "ViewController.h"
#import "HealthNews.h"
#import "Header.h"
@interface AppDelegate ()<TabBarDelegate>
{
    UITabBarController *tabBarCtr;
}

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    HomeViewController *homeVtr=[[HomeViewController alloc]init];
    UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:homeVtr];
    
    CaiCaiViewController *secondVCtr=[[CaiCaiViewController alloc]init];
    UINavigationController *secondNavigation = [[UINavigationController alloc]initWithRootViewController:secondVCtr];
    
    ViewController *hospitalCtro = [[ViewController alloc] init];
    UINavigationController *hospitalNav = [[UINavigationController alloc] initWithRootViewController:hospitalCtro];

    HealthNews *healthVCtr=[[HealthNews alloc]init];
    UINavigationController *healthNavigation = [[UINavigationController alloc]initWithRootViewController:healthVCtr];
//    [navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"RecommandationViewTitleBackground"] forBarMetrics:UIBarMetricsDefault];
    
    tabBarCtr=[[UITabBarController alloc]init];
    tabBarCtr.viewControllers=@[navigation,secondNavigation,hospitalNav,healthNavigation];
    
    
    [tabBarCtr.tabBar addSubview:[self makeTabBar]];
    
    
    self.window.rootViewController=tabBarCtr;
    return YES;
}

- (TabBar *)makeTabBar
{
    NSArray *imageArray=@[@"小常识.png",
                          @"apple.png",
                          @"hospital2.png",
                          @"资讯.png"];
    NSMutableArray *itemsArray=[[NSMutableArray alloc]init];
    for (int i=0; i<4; i++)
    {
        UIImage *image=[UIImage imageNamed:imageArray[i]];
        Items *item=[[Items alloc]initWithImage:image title:nil];
//        item.selectImage=[UIImage imageNamed:@"TabBarHomeBackgroundSelected.png"];
        item.selectImage=[UIImage imageNamed:@"粉红.png"];
        [itemsArray addObject:item];
    }
    TabBar *tabBar=[[TabBar alloc]initWithFrame:tabBarCtr.tabBar.bounds];
    tabBar.itemArray=itemsArray;
    //RecommandationViewTitleBackground@2x
    tabBar.bgImage=[UIImage imageNamed:@"青色.png"];
    tabBar.selectIndex=0;
    tabBar.delegate=self;
    return tabBar;
}

- (void)tabBar:(TabBar *)tabBar didTag:(NSInteger)tag
{
    tabBarCtr.selectedIndex=tag;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
