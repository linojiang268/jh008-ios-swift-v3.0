//
//  AppDelegate.swift
//  Jike
//
//  Created by ios on 15-4-21.
//  Copyright (c) 2015 ios. All rights reserved.
//

import UIKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var nav:UINavigationController!
 

    var manager:SDWebImageManager = SDWebImageManager.sharedManager()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch. weitebi20150427#abroaddog
        LogUtils.log("didFinishLaunchingWithOptions")

        //缓存屏幕的宽高，备后面使用
        UiUtils.setBaseWidth(UIScreen.mainScreen().bounds.width)
        UiUtils.setBaseHeight(UIScreen.mainScreen().bounds.height)

        //初始化友盟
        MobClick.startWithAppkey(Constants.youmengId, reportPolicy: BATCH, channelId: nil)
        UMessage.startWithAppkey(Constants.youmengId, launchOptions: launchOptions)
        SetUmengOC().setUmeng()
        UMessage.setLogEnabled(false)
        
        ShareSDK.registerApp("4ee82564c8f7", activePlatforms: nil, onImport: nil, onConfiguration: nil)
        ShareHelper.initShareSDK()

        initVC()

        return true
    }
    
    //打开根viewcontroller，其实就是主界面
    func getRootNavVC() -> UINavigationController {
        return self.nav
    }

    //初始化viewController
    private func initVC() {
        nav = UINavigationController(rootViewController: MainTabVC())
        nav.navigationBarHidden = true
        self.window = UIWindow(frame:UIScreen.mainScreen().bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = nav

    }


    //首次安装并进入应用时，展示引导页
//    func loadLogin() {
//        if(CachedData.isFirstTimeOpenApp()) {
//            UiUtils.openOneNewVcNoAnim(SplashVC())
//            CachedData.setAppOpend()
//        }
//        else {
//            let dataUser = CachedData.getUserLoginedInfoCached()
//            if(dataUser == nil || dataUser!.userId == 0)
//            {
//                let loginVC = FirstLoginRegisterVC()
//                UiUtils.openOneNewVcNoAnim(loginVC)
//            }
//        }
//    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        LogUtils.log("applicationWillResignActive")

    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        LogUtils.log("applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        LogUtils.log("applicationWillEnterForeground")

    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        LogUtils.log("applicationDidBecomeActive")
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        LogUtils.log("applicationWillTerminate")
    }

//    func copyDBSourceFile()
//    {
//        //libiary
//        let libPath:String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory,
//                                                                 NSSearchPathDomainMask.UserDomainMask, true)[0] 
//        let dbFilePath:String = NSBundle.mainBundle().pathForResource("country_school.db", ofType: nil)!
//        //db文件是否存在
//        let fileManager = NSFileManager.defaultManager()
//        var value = ObjCBool(false)
//        let dbLibPath = NSURL(string: libPath)?.URLByAppendingPathComponent("country_school.db")
//        if(!fileManager.fileExistsAtPath("", isDirectory: &value))
//        {
//            do {
//                try fileManager.copyItemAtPath(dbFilePath, toPath: (dbLibPath?.absoluteString)!)
//            } catch _ {
//            }
//        }
//    }
    
    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "jikekeji.Jike" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] 
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Jike", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Gather4_dev.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch let error1 as NSError {
                    error = error1
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog("Unresolved error \(error), \(error!.userInfo)")
                    abort()
                }
            }
        }
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {

        return true
    }

    @available(iOS 8.0, *)
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        
    }

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {

    }

    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {

        LogUtils.log("application:EaseMob:didFailToRegisterForRemoteNotificationsWithError:error=\(error)")
    }

    //当应用在存活状态下，接到apns推送，点击推送消息时，会调用这个函数
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {

        LogUtils.log("application:didReceiveRemoteNotification():userInfo=\(userInfo)")

    }

    //这是本地推送，是我们自己的代码逻辑发出的提醒，是应用存活，应用的代码逻辑能运行，且应用在后台的时候产生的。
    //一般是刚刚按了home后，在线消息到达时，我们的代码逻辑主动发出提醒,会进入这个函数
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {


    }


}

