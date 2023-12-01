//
//  rainbowlApp.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/4/29.
//

import SwiftUI
import Firebase
import BackgroundTasks

@main
struct rainbowlApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
    
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Request permission for notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }

        // Set the delegate to handle notifications
        UNUserNotificationCenter.current().delegate = self

        // Schedule a daily notification
        scheduleDailyNotification()

        // Register background task
        registerBackgroundTask()

        return true
    }

    func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Daily Update"
        content.body = "Perform your daily task!"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = 12 // Change this to your desired time

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }

    // Register background task
    func registerBackgroundTask() {
        let taskIdentifier = "com.yourapp.backgroundtask"
        BGTaskScheduler.shared.register(forTaskWithIdentifier: taskIdentifier, using: nil) { task in
            self.handleAppRefreshTask(task: task as! BGAppRefreshTask)
        }
    }

    // Handle background app refresh
    func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleBackgroundTask()
    }

    func scheduleBackgroundTask() {
        let request = BGAppRefreshTaskRequest(identifier: "com.yourapp.backgroundtask")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 60 * 15) // Fetch every 15 minutes

        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh task: \(error)")
        }
    }

    // Handle the app refresh task
    func handleAppRefreshTask(task: BGAppRefreshTask) {
        scheduleBackgroundTask() // Reschedule the task

        // Check if the date has changed and perform your actions
        // This is a simplified example; you may need to refine it based on your requirements
        let authViewModel = AuthViewModel.shared
            DispatchQueue.main.async {
                authViewModel.updateColors()
            }
        
        task.setTaskCompleted(success: true)
    }
}
