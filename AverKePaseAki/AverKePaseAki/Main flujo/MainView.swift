import SwiftUI

struct Anuncio: Identifiable {
    let id = UUID()
    let titulo: String
    let habitaciones: Int
    let lavabos: Int
    let precio: String
    let fotos: [String] // URLs o nombres de imágenes locales
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct MainView: View, Hashable {
    var id: UUID = UUID()
    @State private var anuncios: [Anuncio] = [
        Anuncio(
            titulo: "Piso en Barcelona",
            habitaciones: 2,
            lavabos: 1,
            precio: "€1200/mes",
            fotos: ["fotopis", "fotopis2"] // Reemplaza con tus nombres de imágenes
        ),
        Anuncio(
            titulo: "Apartamento en Madrid",
            habitaciones: 1,
            lavabos: 1,
            precio: "€900/mes",
            fotos: ["fotopis", "fotopis2"] // Reemplaza con tus nombres de imágenes
        )
        // Puedes agregar más anuncios aquí...
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(anuncios) { anuncio in
                                VStack(spacing: 0) {
                                    TabView {
                                        ForEach(anuncio.fotos, id: \.self) { foto in
                                            Image(foto) // Usa nombres de imágenes locales o URLs
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                .clipped()
                                        }
                                    }
                                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                                    .frame(height: 200)
                                    .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))
                                    
                                    RoundedRectangle(cornerRadius: 0)
                                        .fill(Color.black.opacity(0.7))
                                        .frame(height: 100)
                                        .overlay(
                                            VStack(spacing: 10) {
                                                Text(anuncio.titulo)
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                                    .padding(.top, 10)
                                                
                                                Spacer()
                                                
                                                HStack(spacing: 20) {
                                                    HStack {
                                                        Image(systemName: "bed.double.fill")
                                                            .foregroundColor(.white)
                                                        Text("\(anuncio.habitaciones) Hab")
                                                            .foregroundColor(.white)
                                                    }
                                                    
                                                    HStack {
                                                        Image(systemName: "bathtub.fill")
                                                            .foregroundColor(.white)
                                                        Text("\(anuncio.lavabos) Baños")
                                                            .foregroundColor(.white)
                                                    }
                                                    
                                                    HStack {
                                                        Image(systemName: "eurosign.circle.fill")
                                                            .foregroundColor(.white)
                                                        Text(anuncio.precio)
                                                            .foregroundColor(.white)
                                                    }
                                                }
                                                .font(.subheadline)
                                                .padding(.bottom, 10)
                                            }
                                                .padding()
                                        )
                                        .border(Color.white, width: 2)
                                }
                                .border(Color.white, width: 7)
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                            }
                        }
                        .padding(.vertical)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 80)
                            .padding(.horizontal, 20)
                            .shadow(color: .white.opacity(0.5), radius: 10, x: 0, y: 5)
                        
                        HStack(spacing: 60) {
                            NavigationLink(destination: ChatView()) {
                                Image(systemName: "message.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                            }
                            
                            NavigationLink(destination: HomeView()) {
                                ZStack {
                                    Circle()
                                        .fill(Color.orange)
                                        .frame(width: 70, height: 70)
                                        .shadow(color: .orange.opacity(0.5), radius: 10, x: 0, y: 5)
                                    
                                    Image(systemName: "house.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 28))
                                }
                            }
                            .offset(y: -20)
                            
                            NavigationLink(destination: SettingsView()) {
                                Image(systemName: "person.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                            }
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
        }
    }
    
    static func == (lhs: MainView, rhs: MainView) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct HomeView: View {
    var body: some View {
        Text("Home View")
            .font(.largeTitle)
            .foregroundColor(.orange)
            .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings View")
            .font(.largeTitle)
            .foregroundColor(.white)
            .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct ChatView: View {
    var body: some View {
        Text("Chat View")
            .font(.largeTitle)
            .foregroundColor(.white)
            .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    MainView()
}

