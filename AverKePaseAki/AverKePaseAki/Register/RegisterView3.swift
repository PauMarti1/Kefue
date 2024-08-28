import SwiftUI
import SwiftData

struct RegisterView3: View, Hashable {
    @State private var selectedRole: String = ""
    @State private var riki: Bool = false
    var id: UUID = UUID()
    let roles = ["Owner", "Llogater", "Buscador"]
    var user: Usuari
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ZStack {
            Image("loginImage")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()

                Text("Lorem ipsum")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 20)
                    .foregroundColor(.white)
                
                HStack(spacing: 15) {
                    ForEach(roles, id: \.self) { role in
                        Button(action: {
                            selectedRole = role
                            riki = true
                        }) {
                            Text(role)
                                .foregroundColor(selectedRole == role ? .black : .white)
                                .padding()
                                .background(
                                    Capsule()
                                        .fill(selectedRole == role ? Color.white : Color.black)
                                        .shadow(radius: 2)
                                )
                                .overlay(
                                    Capsule()
                                        .stroke(Color.white, lineWidth: 2)
                                )
                        }
                    }
                }
                .padding(.horizontal, 20)

                Spacer()
                
                NavigationLink(
                    destination: destinationView(),
                    isActive: $riki
                ) {
                    buttonLabel
                }
                .padding(.bottom, 30)
            }
            .padding()
        }
    }
    
    private var buttonLabel: some View {
        Text("Següent")
            .padding()
            .frame(maxWidth: 200)
            .background(riki ? Color.white : Color.black)
            .foregroundColor(riki ? Color.black : Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 2)
            )
    }
    
    @ViewBuilder
    private func destinationView() -> some View {
        switch selectedRole {
        case "Llogater":
            LlogaterView(llog: Llogater(dadesUser: Usuari(nomICognoms: user.nomICognoms, mail: user.mail, edat: user.edat, cumple: user.cumple, password: user.password, genere: user.genere), direccio: "", CP: "", poblacio: "", provincia: "", pais: "", unisAprop: "")) // Replace with your Llogater view
        //case "Buscador":
            //RegisterViewBuscador1() // Your view for Buscador
        case "Owner":
            OwnerView() // Replace with your Owner view
        default:
            EmptyView()
        }
    }
    
    static func == (lhs: RegisterView3, rhs: RegisterView3) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .padding(.leading, 10)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.white)
                        .opacity(0.7)
                        .padding(.leading, 5)
                }
                TextField("", text: $text)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .shadow(color: .white.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
    }
}

#Preview {
    RegisterView3(user: Usuari(nomICognoms: "Test User", mail: "test@example.com", edat: 30, cumple: Date(), genere: "No especificar"))
}
