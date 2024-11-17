// ContentView.swift

import SwiftUI
import AVFoundation

struct ContentView: View {
    let colors: [(name: String, color: Color, audioFile: String)] = [
        ("Amarelo", .yellow, "amarelo.mp3"),
        ("Azul", .blue, "azul.mp3"),
        ("Azul-arroxeado", .indigo, "azul-arroxeado.mp3"),
        ("Azul-esverdeado", .teal, "azul-esverdeado-teal.mp3"),
        ("Bege", Color(red: 0.96, green: 0.87, blue: 0.70), "bege-beige.mp3"),
        ("Branco", .white, "branco-white.mp3"),
        ("Cinza", .gray, "cinza-gray.mp3"),
        ("Dourado", Color(red: 0.85, green: 0.65, blue: 0.13), "dourado-gold.mp3"),
        ("Laranja", .orange, "laranja.mp3"),
        ("Marrom", Color(red: 0.60, green: 0.40, blue: 0.20), "marrom-brown.mp3"),
        ("Prata", Color(red: 0.75, green: 0.75, blue: 0.75), "prata-silver.mp3"),
        ("Preto", .black, "preto-black.mp3"),
        ("Rosa", .pink, "rosa-pink.mp3"),
        ("Roxo", .purple, "roxo.mp3"),
        ("Verde", .green, "verde.mp3"),
        ("Vermelho", .red, "vermelho.mp3"),
        ("Vermelho-arroxeado", Color(red: 0.83, green: 0.22, blue: 0.55), "vermelho-arroxeado-magenta.mp3")
    ]
    
    @State private var audioPlayer: AVAudioPlayer?
    @State private var pressedButton: String?

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Título
                Text("Bem-vindo!")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .multilineTextAlignment(.center)
                    .padding(.top)

                // Subtítulo
                Text("Toque nos botões para aprender as cores!")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Botões
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                    ForEach(colors, id: \.name) { color in
                        ArcadeButton(
                            label: color.name,
                            color: color.color,
                            isPressed: pressedButton == color.name,
                            action: {
                                pressedButton = color.name
                                playAudio(fileName: color.audioFile)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    pressedButton = nil
                                }
                            }
                        )
                    }
                }
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            playAudio(fileName: "boas-vindas.mp3")
        }
    }

    func playAudio(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            print("Áudio não encontrado: \(fileName)")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Erro ao reproduzir áudio: \(error.localizedDescription)")
        }
    }
}

struct ArcadeButton: View {
    let label: String
    let color: Color
    let isPressed: Bool
    let action: () -> Void

    var body: some View {
        ZStack {
            // Fundo com profundidade
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [color.opacity(0.6), color.opacity(0.3)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .offset(y: isPressed ? 2 : 10)
                .scaleEffect(isPressed ? 0.95 : 1.0)

            // Botão principal
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [color, color.opacity(0.8)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 4)
                )
                .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: isPressed ? 2 : 6)
                .scaleEffect(isPressed ? 0.9 : 1.0)

            // Texto
            Text(label)
                .foregroundColor(color == .white ? .black : .white)
                .bold()
                .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .frame(width: 100, height: 100)
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    ContentView()
}
