import SwiftUI

struct UniversityProximityView: View, Hashable {
    var id: UUID = UUID()
    @State private var isNearUniversity = false
    @State private var universities: String = ""
    @State private var newUniversityName = ""
    @State private var newUniversityDistance = ""
    
    @State private var navigate = false
    
    var llog: Llogater
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Fondo negro
            
            VStack(alignment: .center, spacing: 20) {
                Text("¿Está cerca de alguna universidad?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                
                HStack {
                    Button(action: {
                        isNearUniversity = true
                    }) {
                        Text("Sí")
                            .fontWeight(.bold)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(isNearUniversity ? Color.black : Color.white)
                            .background(isNearUniversity ? Color.white : Color.clear)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                    
                    Button(action: {
                        isNearUniversity = false
                        universities = ""
                    }) {
                        Text("No")
                            .fontWeight(.bold)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(!isNearUniversity ? Color.black : Color.white)
                            .background(!isNearUniversity ? Color.white : Color.clear)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                }
                
                if isNearUniversity {
                    VStack(alignment: .leading, spacing: 20) {
                                CustomTextField(placeholder: "Universidad", text: $universities, icon: "building.columns")
                            }
                }
                
                Spacer()
                
                NavigationLink(destination: LlogaterView(llog: llog), isActive: $navigate) {
                    Text("Següent")
                        .padding()
                        .frame(maxWidth: 200)
                        .background(isFormValid ? Color.white : Color.black)
                        .foregroundColor(isFormValid ? Color.black : Color.white)
                        .cornerRadius(10)
                        .overlay(
                          RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                .simultaneousGesture(TapGesture().onEnded {
                    if isFormValid {
                        posaUnis()
                        navigate = true
                    }
                })
                .disabled(!isFormValid) // Deshabilitar el botón si el formulario no es válido
                .padding(.bottom, 30) // Espacio en la parte inferior
            }
            .padding(20)
        }
    }
    
    private var isFormValid: Bool {
        return true
    }
    
    static func == (lhs: UniversityProximityView, rhs: UniversityProximityView) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func posaUnis() {
        llog.unisAprop = universities
    }
}

struct UniversityProximityView_Previews: PreviewProvider {
    static var previews: some View {
        UniversityProximityView(llog: Llogater(dadesUser: Usuari(nomICognoms: "Test User", mail: "test@example.com", edat: 30, cumple: Date(), genere: "No especificar"), direccio: "", CP: "", poblacio: "", provincia: "", pais: "", unisAprop: ""))
    }
}


