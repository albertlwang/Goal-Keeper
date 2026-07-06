//
//  StateManager.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/12/26.
//

import Foundation

enum AppPhase: String, CaseIterable, Codable {
    case awaiting, active
}

@MainActor
@Observable
final class StateManager {
    static let shared = StateManager()
    
    private(set) var currentPhase: AppPhase = .awaiting
    private(set) var timeRemaining: TimeInterval = 0
    private(set) var endTime: Date = .now
    
    private var timer: Timer?
    
    private init() {
        loadState()
        startClock()
        // observeSettings()
    }
}

// MARK: - State logic
extension StateManager {
    private func loadState() {
        let defaults = UserDefaults.standard
        if let raw = defaults.string(forKey: "currentPhase"),
           let phase = AppPhase(rawValue: raw),
           let stored = defaults.object(forKey: "endOfDay") as? Date {
            currentPhase = phase
            endTime = stored
            if endTime < .now { updatePhase() }
        } else {
            updatePhase()
        }
    }
    
    private func saveState() {
        UserDefaults.standard.set(currentPhase.rawValue, forKey: "currentPhase")
        UserDefaults.standard.set(endTime, forKey: "endOfDay")
    }
    
    private func updatePhase() {
        print("Updating phase.")
        let next: AppPhase
        let endsAt: Date
        
        if inActiveWindow {
            next = .active
            endsAt = nextEOD
            print("Transitioning to active. EOD = \(nextEOD)")
        } else {
            next = .awaiting
            endsAt = nextSOD
            print("Transitioning to awaiting. SOD = \(nextSOD)")
        }
        
        if DataContainer.shared.activeGoalIsExpired {
            print("Active goal is expired—clearing active goal.")
            expireActiveGoal()
        }
        
        currentPhase = next
        endTime = endsAt
        saveState()
    }
    
    private func startClock() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.tick()
            }
        }
    }
    
    private func tick() {
        let remaining = endTime.timeIntervalSinceNow
        if remaining <= 0 {
            updatePhase()
        } else {
            timeRemaining = remaining
        }
    }
    
    private func expireActiveGoal() {
        if let activeGoal = DataContainer.shared.activeGoal {
            // Archive the active goal
            let newGoalLog = GoalLog(from: activeGoal)
            try? DataContainer.shared.insertGoalLog(newGoalLog)
        }
        try? DataContainer.shared.clearCurrentActiveGoal()
    }
}

// MARK: - Helpers
extension StateManager {
    var nextEOD: Date {
        let components = AppSettings.shared.endOfDay
        
        return Calendar.current.nextDate(
            after: .now,
            matching: components,
            matchingPolicy: .nextTime
        ) ?? .now
    }
    
    var nextSOD: Date {
        let components = AppSettings.shared.startOfDay
        
        return Calendar.current.nextDate(
            after: .now,
            matching: components,
            matchingPolicy: .nextTime
        ) ?? .now
    }
    
    
    private func timeIntervalSinceMidnight(from components: DateComponents) -> TimeInterval {
        let now = Date()
        let midnight = Calendar.current.startOfDay(for: now)
        let target = Calendar.current.date(bySettingHour: components.hour ?? 0,
                                           minute: components.minute ?? 0,
                                           second: components.second ?? 0,
                                           of: now) ?? midnight
        return target.timeIntervalSince(midnight)
    }
    
    private var inActiveWindow: Bool {
        let settings = AppSettings.shared
        let dayLength: TimeInterval = 24 * 60 * 60
        let gap = settings.data.gap
        
        let eodSeconds = timeIntervalSinceMidnight(from: settings.endOfDay)
        let nowSeconds = timeIntervalSinceMidnight(from: Calendar.current.dateComponents([.hour, .minute, .second], from: Date()))
        
        // Seconds since EOD, always in [0, 24hrs)
        let secondsSinceEOD = (nowSeconds - eodSeconds + dayLength).truncatingRemainder(dividingBy: dayLength)
        
        return secondsSinceEOD >= gap
    }
}
