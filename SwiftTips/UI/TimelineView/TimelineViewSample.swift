//
//  TimelineViewSample.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/05/26.
//

import SwiftUI

struct TimelineViewSample: View {
    var body: some View {
        // 円の描写をanimationで
//        TimelineView(.animation) { context in
//            let date = context.date
//            let value = context.cadence <= .live ? nanosValue(for: date) : secondsValue(for: date)

        // 5秒ごとに一気に描写
//        TimelineView(.periodic(from: .now, by: 5)) { context in
//            let value = secondsValue(for: context.date)

        TimelineView(.daily) { context in
            let value = dayValue(for: context.date)

            Circle()
                .trim(from: 0, to: value)
                .stroke()
        }
    }

    private func dayValue(for date: Date) -> Double {
        let day = Calendar.current.component(.day, from: date)
        return Double(day) / 30
    }

    private func secondsValue(for date: Date) -> Double {
        let seconds = Calendar.current.component(.second, from: date)
        return Double(seconds) / 60
    }

    private func nanosValue(for date: Date) -> Double {
        let seconds = Calendar.current.component(.second, from: date)
        let nanos = Calendar.current.component(.nanosecond, from: date)
        return Double(seconds * 1_000_000_000 + nanos) / 60_000_000_000
    }
}


final class DailySchedule: TimelineSchedule {
    typealias Entries = [Date]

    func entries(from startDate: Date, mode: Mode) -> [Date] {
        (1...30).map { startDate.addingTimeInterval(Double($0 * 24 * 3600)) }
    }
}

extension TimelineSchedule where Self == DailySchedule {
    static var daily: Self { .init() }
}

struct TimelineViewSample_Previews: PreviewProvider {
    static var previews: some View {
        TimelineViewSample()
    }
}
