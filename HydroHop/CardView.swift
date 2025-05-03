import SwiftUI

struct CardView: View {
    var title: String
    var notificationDuration: Int
    var emoji: String
    var streak: Int
    
    let totalDuration: Double = 60.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // Top "Now Playing" style Label
            HStack(spacing: 6) {
                Image(systemName: "flame")
                    .foregroundColor(.pink)
                
                Text("\(streak) day streak!")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.pink)
            }
            .padding(.horizontal)
            
            // Main card
            HStack(spacing: 16) {
                Button(action: {
                    print("Emoji tapped")
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 60, height: 60)
                        
                        Text(emoji)
                            .font(.system(size: 30))
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary) // Dynamically adjusts for light/dark mode
                    
                    Text("💧 \(streak) sips ahead of yesterday!")
                        .font(.caption)
                        .foregroundColor(.secondary) // Dynamically adjusts for light/dark mode
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            // Progress Bar
            VStack(alignment: .leading, spacing: 8) {
                Text("Next notification in \(notificationDuration) mins")
                    .font(.caption)
                    .foregroundColor(.secondary) // Dynamically adjusts for light/dark mode
                
                ProgressView(value: progressValue)
                    .progressViewStyle(LinearProgressViewStyle(tint: .green))
                    .frame(height: 6)
                    .clipShape(Capsule())
            }
            .padding(.horizontal)
            .padding(.bottom)
            
        }
        .padding()
        .background(Color(.systemBackground)) // Use system background for light/dark mode
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 10, y: 5)
        .padding(.horizontal)
        .background(Color(.systemGray6)) // Light subtle bg behind the card
    }
    
    var progressValue: Double {
        1.0 - (Double(notificationDuration) / totalDuration)
    }
}

#Preview {
    CardView(title: "Drink Water", notificationDuration: 45, emoji: "💧", streak: 3)
}
