//
//  SettingsView.swift
//  HydroHop
//
//  Created by Agam Singh Talwar on 2025-04-22.
//
import SwiftUI

struct SettingsView: View {
    @AppStorage("waterReminderEnabled") private var waterReminderEnabled = true
    @AppStorage("standReminderEnabled") private var standReminderEnabled = true
    @AppStorage("soundEnabled") private var soundEnabled = true
    @AppStorage("vibrationEnabled") private var vibrationEnabled = true
    @AppStorage("waterInterval") private var waterInterval = 60
    @AppStorage("standInterval") private var standInterval = 45
    @AppStorage("accentColorHex") private var accentColorHex = "#007AFF"

    let intervalOptions = [15, 30, 45, 60, 90, 120]
    let accentColors: [(name: String, color: Color, hex: String)] = [
        ("Blue", .blue, "#007AFF"),
        ("Green", .green, "#34C759"),
        ("Purple", .purple, "#AF52DE"),
        ("Orange", .orange, "#FF9500"),
        ("Pink", .pink, "#FF2D55")
    ]

    var body: some View {
        Form {
            Section(header: Text("Reminders")) {
                Toggle("Water Reminder", isOn: $waterReminderEnabled)
                if waterReminderEnabled {
                    Picker("Water Interval", selection: $waterInterval) {
                        ForEach(intervalOptions, id: \.self) { minutes in
                            Text("\(minutes) min").tag(minutes)
                        }
                    }
                }

                Toggle("Stand Reminder", isOn: $standReminderEnabled)
                if standReminderEnabled {
                    Picker("Stand Interval", selection: $standInterval) {
                        ForEach(intervalOptions, id: \.self) { minutes in
                            Text("\(minutes) min").tag(minutes)
                        }
                    }
                }
            }

            Section(header: Text("Notification Settings")) {
                Toggle("Sound", isOn: $soundEnabled)
                Toggle("Vibration", isOn: $vibrationEnabled)
            }

            Section(header: Text("Choose a theme")) {
                VStack(alignment: .leading, spacing: 10) {

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 5), spacing: 16) {
                        ForEach(accentColors, id: \.hex) { colorOption in
                            ZStack {
                                Circle()
                                    .fill(colorOption.color)
                                    .frame(width: 36, height: 36)
                                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.primary.opacity(accentColorHex == colorOption.hex ? 0.7 : 0), lineWidth: 2)
                                    )
                                    .scaleEffect(accentColorHex == colorOption.hex ? 1.1 : 1.0)
                                    .animation(.easeInOut(duration: 0.2), value: accentColorHex)
                                    .onTapGesture {
                                        accentColorHex = colorOption.hex
                                    }
                            }
                        }
                    }
                    .padding(.vertical, 6)
                }
                .padding(.vertical, 5)
            }


            Section {
                Button(role: .destructive) {
                    resetProgress()
                } label: {
                    Text("Reset All Progress")
                }
            }
        }
        .navigationTitle("Settings")
    }

    func resetProgress() {
        waterReminderEnabled = true
        standReminderEnabled = true
        soundEnabled = true
        vibrationEnabled = true
        waterInterval = 60
        standInterval = 45
        accentColorHex = "#007AFF"
    }
}


#Preview {
    SettingsView()
}
