import SwiftUI

struct ContentView: View {
    var id: UUID
    @State private var navigationPath = NavigationPath()
    @State private var isLoggedIn: Bool = true

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Image("backgroundImage")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer().frame(height: 50)
                    
                    Text("Benvingut al cercapisos!")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        if isLoggedIn {
                            navigationPath.append(MainView()) // Vista de búsqueda
                        } else {
                            navigationPath.append(LoginView(id: id))
                        }
                    }) {
                        Text(isLoggedIn ? "Comença a buscar marrano!" : "Inicia sesión")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 50)
                }
                .padding()
            }
            .navigationDestination(for: LoginView.self) { view in
                view.onDisappear {
                    // Actualiza el estado de inicio de sesión cuando se vuelve a la vista principal
                    isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
                }
            }
            .navigationDestination(for: BuscadorView.self) { buscadorView in
                buscadorView
            }
        }
    }
}

#Preview {
    ContentView(id: UUID())
}

