import SwiftUI

struct LandingView: View {
    @AppStorage("hasSeenLanding") private var hasSeenLanding: Bool = false
    @State private var navigateToHome = false

    var body: some View {
        NavigationView {
            VStack(spacing: 35) {
                Spacer()

                Image(systemName: "drop.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.blue)

                Text("Welcome to HydroHop")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)

                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "bell.badge.fill")
                            .foregroundColor(.accentColor)
                            .frame(width: 24)
                        Text("HydroHop gently reminds you to **drink water** and **stand up**, helping you build habits passively.")
                    }

                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "hare.fill")
                            .foregroundColor(.accentColor)
                            .frame(width: 24)
                        Text("You don’t need to open the app constantly — just launch it once, and we’ll take care of the rest.")
                    }

                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "checkmark.shield.fill")
                            .foregroundColor(.accentColor)
                            .frame(width: 24)
                        Text("No sign-in. No setup. Just healthy habits built into your day.")
                    }
                }
                .font(.body)
                .padding(.horizontal)

                Spacer()

                // Use NavigationLink with state binding
                NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true),
                               isActive: $navigateToHome) {
                    EmptyView()
                }

                Button(action: {
                    hasSeenLanding = true
                    navigateToHome = true
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                        .padding(.horizontal)
                }

                Spacer(minLength: 40)
            }
            .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    LandingView()
}
