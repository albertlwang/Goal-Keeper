//
//  TimeInterval+Formatting.swift
//  Goal Keeper
//
//  Created by Albert Wang on 7/6/26.
//

import Foundation

extension TimeInterval {
    /// Formats interval as  acompact "1h 30m"-style string.
    /// Omits units if they are zero (e.g. "45m" or "2h")
    var hoursAndMinutes: String {
        let total = Int(self)
        let h = total / 3600
        let m = (total % 3600) / 60

        switch (h, m) {
        case (0, let m): return "\(m)m"
        case (let h, 0): return "\(h)h"
        case (let h, let m): return "\(h)h \(m)m"
        }
    }
}
