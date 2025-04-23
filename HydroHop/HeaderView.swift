//
//  HeaderView.swift
//  HydroHop
//
//  Created by Agam Singh Talwar on 2025-04-22.
//
import SwiftUI

struct HeaderView: View {
    @State private var selectedDate = Date()
    @State private var showCalendar = false

    var body: some View {
        VStack(spacing: 10) {
            // Header
            HStack {
                // Toggle Calendar Picker Button
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

                // Date in center
                HStack(spacing: 0) {
                    Text(getWeekday(from: selectedDate))
                        .font(.system(size: 17, weight: .semibold))
                    Text(" \(getMonthDay(from: selectedDate))")
                        .foregroundColor(.gray)
                }

                Spacer()
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                        .font(.system(size: 17))
                }

            }
            .padding(.horizontal)
            .padding(.top)
            HStack{
                Spacer()
                // Week Strip
                if !showCalendar {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(currentWeekDates(), id: \.self) { date in
                                VStack {
                                    Text(getShortWeekday(from: date))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(getDayNumber(from: date))
                                        .fontWeight(.medium)
                                        .foregroundColor(Calendar.current.isDate(date, inSameDayAs: selectedDate) ? .white : .primary)
                                        .frame(width: 35, height: 35)
                                        .background(
                                            Circle()
                                                .fill(Calendar.current.isDate(date, inSameDayAs: selectedDate) ? Color.blue : Color.clear)
                                        )
                                }
                                .onTapGesture {
                                    selectedDate = date
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Full Calendar Picker (Dropdown)
                if showCalendar {
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .padding(.horizontal)
                }
                Spacer()
            }
        }
    }

    // Helper functions
    func getWeekday(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }

    func getMonthDay(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }

    func getShortWeekday(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }

    func getDayNumber(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }

    func currentWeekDates() -> [Date] {
        var calendar = Calendar.current
        calendar.firstWeekday = 2 // Monday
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let diff = weekday - calendar.firstWeekday
        let startOfWeek = calendar.date(byAdding: .day, value: -diff, to: today)!

        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
}

#Preview {
    NavigationStack{
        HeaderView()
    }
}
