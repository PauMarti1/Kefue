import SwiftUI

struct LoginView: View, Hashable {
    var id: UUID
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Image("loginImage")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer().frame(height: 30)
                
                Text("Estas al login yerma")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer().frame(height: 30)
                
                Spacer().frame(height: 80)
                
                VStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Posa el mail cabesudo: ")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        CustomTextField(placeholder: "Posa el mail", text: $email, icon: "envelope.fill")
                    }
                    .frame(maxWidth: 280, alignment: .center)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Posa la contra: ")
                            .font(.headline)
                            .foregroundColor(.white)
                        CustomTextField(placeholder: "Posa la contrasenya", text: $password, icon: "lock.fill")
                    }
                    .frame(maxWidth: 280, alignment: .center)
                    
                    Button(action: {
                        login()
                    }) {
                        Text("Login")
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                    .padding(.top, 10)
                    
                    
                    Text("No tens compte?").foregroundColor(.white)
                    
                    NavigationLink(destination: RegisterView1()) { // Reemplaza BuscadorView2 con tu vista de destino
                        Text("Registra't")
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2) // Contorno blanco
                            )
                    }
                    .padding(.bottom, 30) // Espacio en la parte inferior
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 50)
                
                Spacer()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func login() {
        if Usuari.verificarCredenciales(mail: email, password: password) {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            presentationMode.wrappedValue.dismiss()
        } else {
            alertMessage = "Credenciales incorrectas. Por favor, inténtelo de nuevo."
            showAlert = true
        }
    }
    
    static func == (lhs: LoginView, rhs: LoginView) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

#Preview {
    LoginView(id: UUID())
}

