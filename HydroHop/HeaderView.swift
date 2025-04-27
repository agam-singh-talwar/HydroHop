//  HeaderView.swift
//  HydroHop
//
//  Created by Agam Singh Talwar on 2025-04-22.
//
import SwiftUI

struct HeaderView: View {
    @State private var selectedDate = Date()
    @State private var showCalendar = false

    // Dates when habits were completed
    var waterHabitDates: [Date] = []
    var standHabitDates: [Date] = []

    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 10) {
                // Header Bar
                HStack {
                    // Toggle Calendar Picker
                    Button(action: {
                        withAnimation {
                            showCalendar.toggle()
                        }
                    }) {
                        Image(systemName: "chevron.down")
                            .font(.system(size: 17, weight: .medium))
                            .rotationEffect(.degrees(showCalendar ? 180 : 0))
                            .animation(.easeInOut(duration: 0.2), value: showCalendar)
                    }
                    .foregroundColor(.primary)

                    Spacer()

                    // Current Date Label
                    HStack(spacing: 0) {
                        Text(getWeekday(from: selectedDate))
                            .font(.system(size: 17, weight: .semibold))
                        Text(" \(getMonthDay(from: selectedDate))")
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    // Settings Link
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 17))
                    }
                }
                .padding(.horizontal)
                .padding(.top)

                // Week Strip or Full Calendar
                HStack {
                    Spacer()
                    if !showCalendar {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(currentWeekDates(), id: \..self) { date in
                                    VStack(spacing: 4) {
                                        // Day Abbreviation
                                        Text(getShortWeekday(from: date))
                                            .font(.caption)
                                            .foregroundColor(.gray)

                                        // Day Number
                                        Text(getDayNumber(from: date))
                                            .fontWeight(.medium)
                                            .foregroundColor(Calendar.current.isDate(date, inSameDayAs: selectedDate) ? .white : .primary)
                                            .frame(width: 35, height: 35)
                                            .background(
                                                Circle()
                                                    .fill(Calendar.current.isDate(date, inSameDayAs: selectedDate) ? Color.accentColor : Color.clear)
                                            )

                                        // Habit Dots
                                        HStack(spacing: 4) {
                                            if didWater(on: date) {
                                                Circle()
                                                    .frame(width: 6, height: 6)
                                                    .foregroundColor(.blue)
                                            }
                                            if didStand(on: date) {
                                                Circle()
                                                    .frame(width: 6, height: 6)
                                                    .foregroundColor(.green)
                                            }
                                        }
                                    }
                                    .onTapGesture {
                                        selectedDate = date
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    } else {
                        ZStack(alignment: .top) {
                            DatePicker(
                                "",
                                selection: $selectedDate,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                            .padding(.horizontal)
                            .opacity(0.9)

                            habitDotsOverlay
                        }
                        .frame(maxHeight: 350)
                    }
                    Spacer()
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            )
            .padding(.horizontal)
        }
    }

    // MARK: - Helper
    func didWater(on date: Date) -> Bool {
        waterHabitDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) })
    }

    func didStand(on date: Date) -> Bool {
        standHabitDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) })
    }

    func getWeekday(from date: Date) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "E"
        return fmt.string(from: date)
    }

    func getMonthDay(from date: Date) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "MMM d"
        return fmt.string(from: date)
    }

    func getShortWeekday(from date: Date) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "E"
        return fmt.string(from: date)
    }

    func getDayNumber(from date: Date) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "d"
        return fmt.string(from: date)
    }

    func currentWeekDates() -> [Date] {
        var calendar = Calendar.current
        calendar.firstWeekday = 2 // Monday start
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let diff = weekday - calendar.firstWeekday
        let startOfWeek = calendar.date(byAdding: .day, value: -diff, to: today)!
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }

    // Habit Dots Overlay for Graphical Calendar
    var habitDotsOverlay: some View {
        VStack {
            Spacer()
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 5) {
                ForEach(generateMonthDates(), id: \..self) { date in
                    ZStack {
                        Color.clear
                            .frame(height: 30)
                        VStack(spacing: 2) {
                            Spacer()
                            HStack(spacing: 2) {
                                if didWater(on: date) {
                                    Circle()
                                        .frame(width: 4, height: 4)
                                        .foregroundColor(.blue)
                                }
                                if didStand(on: date) {
                                    Circle()
                                        .frame(width: 4, height: 4)
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 30)
            Spacer()
        }
    }

    func generateMonthDates() -> [Date] {
        var dates: [Date] = []
        let calendar = Calendar.current
        let current = calendar.dateComponents([.year, .month], from: selectedDate)
        guard let firstOfMonth = calendar.date(from: current) else { return dates }

        if let range = calendar.range(of: .day, in: .month, for: firstOfMonth) {
            for day in range.lowerBound..<range.upperBound + 1 {
                if let date = calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth) {
                    dates.append(date)
                }
            }
        }

        return dates
    }

}

#Preview {
    NavigationStack {
        HeaderView(
            waterHabitDates: [Date(), Calendar.current.date(byAdding: .day, value: -2, to: Date())!],
            standHabitDates: [Calendar.current.date(byAdding: .day, value: -1, to: Date())!]
        )
    }
}
