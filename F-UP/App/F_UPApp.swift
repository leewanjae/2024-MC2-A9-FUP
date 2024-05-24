//
//  F_UPApp.swift
//  F-UP
//
//  Created by 박현수 on 5/14/24.
//

import SwiftUI
import SwiftData

@main
struct F_UPApp: App {
    @State private var swiftDataManager = SwiftDataManager()
    @State private var avfoundationManager = AVFoundationManager()
    @State private var refreshTrigger = RefreshTrigger()

    @AppStorage("streak") private var streak: Int = 0
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            History.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            SplashView()
//            AVFoundationTestView()
//            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .environment(avfoundationManager)
        .environment(swiftDataManager)
        .environment(refreshTrigger)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        NotificationManger.shared.setNotiAuth()
        HapticManager.sharedInstance.prepareHapticEngine()
        return true
    }
}
