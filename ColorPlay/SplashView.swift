//SplashView.swift

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            ContentView() // Após o Splash, exibe o conteúdo principal
        } else {
            VStack {
                Image(systemName: "paintpalette") // Substitua pelo logo real
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()

                Text("ColorPlay")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .padding(.top, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
