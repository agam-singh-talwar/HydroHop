//
//  HeaderView.swift
//  HydroHop
//
//  Created by Agam Singh Talwar on 2025-04-22.
//

import SwiftUI

struct HeaderView: View {
    @State private var selectedDate = Date()

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack {
                // Back arrow
                Image(systemName: "chevron.left")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.primary)

                Spacer()

                // Date text
                HStack(spacing: 0) {
                    Text(getWeekday(from: selectedDate))
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)

                    Text(" \(getMonthDay(from: selectedDate))")
                        .font(.system(size: 17))
                        .foregroundColor(.gray)
                }

                Spacer()

                // Menu icon
                Image(systemName: "line.3.horizontal.circle")
                    .font(.system(size: 17))
                    .foregroundColor(.primary)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 10)

            // Calendar Date Picker
            DatePicker(
                "",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .labelsHidden()
            .padding(.horizontal)
        }
    }

    // Helper functions to format the date
    func getWeekday(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E" // e.g., "Mon"
        return formatter.string(from: date)
    }

    func getMonthDay(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d" // e.g., "Jan 2"
        return formatter.string(from: date)
    }
}

#Preview {
    HeaderView()
}
