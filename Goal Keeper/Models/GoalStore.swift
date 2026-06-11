//
//  GoalStore.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/11/26.
//






































//import Foundation
//import SwiftData
//
//@Observable
//class GoalStore {
//    var activeGoal: ActiveGoal?
//    var settings: AppSettings
//    private let context: ModelContext
//    
//    init(context: ModelContext) {
//        self.context = context
//        self.settings = AppSettings.load()
//        archiveIfNeeded()
//        self.activeGoal = fetchActiveGoal()
//    }
//    
//    // MARK: - Derived state
//    var phase: AppPhase {
//        let inDayWindow = isInDayWindow()
//        
//        if inDayWindow {
//            guard let goal = activeGoal else { return .activeNilGoal }
//            if goal.isCompleted { return .activeGoalCompleted }
//            return .activeGoal
//        } else {
//            // Night window
//            if let previous = activeGoal, !previous.summaryShown { return .summaryPending }
//            if activeGoal == nil || activeGoal?.createdAt == todayStart() {
//                // No goal set for tomorrow yet
//                return .goalSettingOpen
//            }
//            return .goalSettingComplete
//        }
//    }
//    
//    // MARK: - Actions
//    func dismissSummary() {
//        activeGoal?.summaryShown = true
//    }
//    
//    func setGoal(_ text: String) {
//        guard phase == .goalSettingOpen else { return }
//        let goal = ActiveGoal(
//            goal: text,
//            createdAt: .now,
//            expiresAt: nextEOD()
//        )
//        context.insert(goal)
//        activeGoal = goal
//    }
//    
//    func completeGoal() {
//        guard phase == .activeGoal else { return }
//        activeGoal?.isCompleted = true
//        activeGoal?.completedAt = .now
//    }
//    
//    func editGoal(_ text: String) {
//        guard phase == .activeGoal || phase == .activeNilGoal else { return }
//        activeGoal?.goal = text
//        activeGoal?.isModified = true
//    }
//    
//    // MARK: - Launch check
//    // Called on init. Archives any expired goal reglardless of whether
//    // the app was open EOD. Nil goals are not logged
//    private func archiveIfNeeded() {
//        guard let goal = fetchActiveGoal(), goal.isExpired else { return }
//        if goal.goal != nil {
//            let log = GoalLog(
//                date: goal.createdAt,
//                goal: goal.goal!,
//                isCompleted: goal.isCompleted,
//                completedAt: goal.completedAt,
//                isModified: goal.isModified
//            )
//            context.insert(log)
//        }
//        context.delete(goal)
//    }
//    
//    // MARK: - Helpers
//    private func fetchActiveGoal() -> ActiveGoal? {
//        let descriptor = FetchDescriptor<ActiveGoal>()
//        return try? context.fetch(descriptor).first
//    }
//    
//    private func isInDayWindow() -> Bool {
//        let now = Date.now
//        return now >= todaySOD() && now < todayEOD()
//    }
//    
//    private func todaySOD() -> Date {
//        Calendar.current.date(bySettingHour: settings.startOfDay.hour!, minute: settings.startOfDay.minute!, second: 0, of: .now)!
//    }
//    
//    private func todayEOD() -> Date {
//        Calendar.current.date(bySettingHour: settings.endOfDay.hour!, minute: settings.endOfDay.minute!, second: 0, of: .now)!
//    }
//    
//    private func nextEOD() -> Date {
//        // If we're in the night window, EOD is tomorrow
//        let base = Calendar.current.date(byAdding: .day, value: 1, to: .now)!
//        return Calendar.current.date(bySettingHour: settings.endOfDay.hour!, minute: settings.endOfDay.minute!, second: 0, of: .now)!
//    }
//    
//    private func todayStart() -> Date {
//        Calendar.current.startOfDay(for: .now)
//    }
//}
