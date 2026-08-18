import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 247 / 255, green: 248 / 255, blue: 250 / 255)
                .ignoresSafeArea()

            VStack(spacing: 10) {
                Text("Integrated Plugins")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(Color(red: 17 / 255, green: 24 / 255, blue: 39 / 255))

                Text("No packaged plugins installed")
                    .font(.system(size: 15))
                    .foregroundStyle(Color(red: 75 / 255, green: 85 / 255, blue: 99 / 255))
            }
            .multilineTextAlignment(.center)
            .padding(24)
        }
    }
}

#Preview {
    ContentView()
}
