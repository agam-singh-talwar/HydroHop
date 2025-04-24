//
//  CardView.swift
//  HydroHop
//
//  Created by Agam Singh Talwar on 2025-04-22.
//

import SwiftUI

struct CardView: View {
    var title: String
    var emoji: String
    var time: String
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.9),
                                    Color.gray.opacity(0.2)
                                ]),
                                center: .center,
                                startRadius: 5,
                                endRadius: 60
                            )
                        )
                        .overlay(
                            Circle()
                                .stroke(Color.gray.opacity(0.4), lineWidth: 2)
                        )
                        .frame(width: 70, height: 70)
                        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)

                    Text(emoji)
                        .font(.system(size: 28))
                }

                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)

                Spacer()
            }
            .padding(.horizontal)

            HStack {
                Spacer()

                VStack(alignment: .leading, spacing: 4) {
                    Text("Next notification in:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text(time)
                        .font(.title3)
                        .fontWeight(.semibold)
                }

                Spacer()
            }
            .padding()
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 10)
    }
}

#Preview {
    CardView(title: "Sip your water", emoji: "💧", time: "25 minutes")
}
