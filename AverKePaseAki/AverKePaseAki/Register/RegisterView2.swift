import SwiftUI

struct RegisterView2: View {
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isNavigating = false
    var id = UUID()
    
    @Environment(\.modelContext) private var modelContext
    
    var user: Usuari
    
    private var isFormValid: Bool {
        !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer().frame(height: 30)
                    
                    Text("Lorem ipsum")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    
                    Spacer().frame(height: 50)
                    
                    VStack(spacing: 15) {
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("   Crea una contrasenya: ")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            CustomTextFieldPass(placeholder: "Contrasenya", text: $password, icon: "lock.fill", isSecure: true)
                        }
                        .frame(maxWidth: 280, alignment: .center)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("   Confirma la contrasenya: ")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            CustomTextFieldPass(placeholder: "Confirma", text: $confirmPassword, icon: "lock.fill", isSecure: true)
                        }
                        .frame(maxWidth: 280, alignment: .center)
                        
                        NavigationLink(destination: RegisterView3(user: Usuari(nomICognoms: user.nomICognoms, mail: user.mail, edat: user.edat, cumple: user.cumple, password: password, genere: user.genere))) {
                                Text("Registrar")
                                    .padding()
                                    .frame(maxWidth: 200)
                                    .background(isFormValid ? Color.white : Color.black)
                                    .foregroundColor(isFormValid ? Color.black : Color.white)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            .disabled(!isFormValid)
                            }
                            .isDetailLink(false)
                            .padding(.top, 30)
                    }
                    .padding()
                    .padding(.horizontal)
                    .frame(maxWidth: 300)
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                }
                .padding(.top, 50)
            }
        }
    }
    
    func registerUser() {
        // Aquí podemos agregar la lógica para registrar al usuario
        user.password = password // Asignamos la contraseña al objeto Usuari
    }
    
    // MARK: - Conformidad a Hashable y Equatable
    static func == (lhs: RegisterView2, rhs: RegisterView2) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct CustomTextFieldPass: View {
    var placeholder: String
    @Binding var text: String
    var icon: String
    var isSecure: Bool = false
    @State private var showPassword: Bool = false

    var body: some View {
        ZStack {
            // Fondo del campo de texto
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
                .shadow(color: .white.opacity(0.3), radius: 10, x: 0, y: 5)
            
            HStack {
                // Icono a la izquierda
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                
                // Campo de texto
                if isSecure {
                    Group {
                        if showPassword {
                            TextField("", text: $text)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.clear)
                                .overlay(
                                    Text(placeholder)
                                        .foregroundColor(.white)
                                        .opacity(text.isEmpty ? 0.7 : 0)
                                        .padding(.leading, 5),
                                    alignment: .leading
                                )
                        } else {
                            SecureField("", text: $text)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.clear)
                                .overlay(
                                    Text(placeholder)
                                        .foregroundColor(.white)
                                        .opacity(text.isEmpty ? 0.7 : 0)
                                        .padding(.leading, 5),
                                    alignment: .leading
                                )
                        }
                    }
                } else {
                    TextField("", text: $text)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.clear)
                        .overlay(
                            Text(placeholder)
                                .foregroundColor(.white)
                                .opacity(text.isEmpty ? 0.7 : 0)
                                .padding(.leading, 5),
                            alignment: .leading
                        )
                }
                
                // Botón de ojo a la derecha
                if isSecure {
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.white)
                            .padding(.trailing, 10)
                    }
                }
            }
        }
        .frame(height: 35)
        .padding(.horizontal, 10)
    }
}

struct RegisterView2_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView2(user: Usuari(nomICognoms: "Test User", mail: "test@example.com", edat: 30, cumple: Date(), genere: "No especificar"))
            .previewLayout(.sizeThatFits)
    }
}


