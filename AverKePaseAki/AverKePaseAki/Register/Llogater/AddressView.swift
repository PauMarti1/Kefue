import SwiftUI

struct AddressView: View, Hashable {
    var id: UUID = UUID()
    @State private var address = ""
    @State private var postalCode = ""
    @State private var city = ""
    @State private var province = ""
    @State private var country = ""
    @State private var showUniversities = false
    @State private var universities: [String] = []
    @State private var selectedUniversity = ""
    @State private var isFormValid = false
    
    var user: Usuari
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Fondo negro
            
            VStack(alignment: .center, spacing: 20) {
                Text("Ingrese su dirección")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                
                Group {
                    CustomTextField(placeholder: "Dirección", text: $address, icon: "house")
                    CustomTextField(placeholder: "Código Postal", text: $postalCode, icon: "envelope")
                    CustomTextField(placeholder: "Población", text: $city, icon: "building.2")
                    CustomTextField(placeholder: "Provincia", text: $province, icon: "map")
                    CustomTextField(placeholder: "País", text: $country, icon: "globe")
                }
                
                Spacer()
                
                NavigationLink(destination: UniversityProximityView(llog: Llogater(dadesUser: user, direccio: address, CP: postalCode, poblacio: city, provincia: province, pais: country, unisAprop: ""))) { // Reemplaza BuscadorView2 con tu vista de destino
                    Text("Següent")
                        .padding()
                        .frame(maxWidth: 200)
                        .background(isFormValid ? Color.white : Color.black)
                        .foregroundColor(isFormValid ? Color.black : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2) // Contorno blanco
                        )
                }
                .disabled(!isFormValid) // Deshabilitar el botón si el formulario no es válido
                .padding(.bottom, 30) // Espacio en la parte inferior
            }
            .padding(20)
            .onChange(of: [address, postalCode, city, province, country], perform: { _ in
                validateForm()
            })
        }
    }
    
    private func fetchUniversities(for city: String) {
        // Simulación de la obtención de universidades. En una aplicación real, esto debería ser una llamada a una API.
        let allUniversities = [
            "Madrid": ["Universidad Complutense de Madrid", "Universidad Politécnica de Madrid", "Universidad Autónoma de Madrid"],
            "Barcelona": ["Universitat de Barcelona", "Universitat Autònoma de Barcelona", "Universitat Politècnica de Catalunya"]
        ]
        
        if let universitiesInCity = allUniversities[city] {
            universities = universitiesInCity
            showUniversities = true
        } else {
            universities = ["No se encontraron universidades en \(city)"]
            showUniversities = true
        }
    }
    
    private func validateForm() {
        isFormValid = !address.isEmpty && !postalCode.isEmpty && !city.isEmpty && !province.isEmpty && !country.isEmpty
    }
    
    static func == (lhs: AddressView, rhs: AddressView) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct UniversityButton: View {
    @Binding var isSelected: Bool
    var action: () -> Void
    var text: String
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
            action()
        }) {
            Text(text)
                .fontWeight(.bold)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(isSelected ? Color.white : Color.clear)
                .foregroundColor(isSelected ? Color.black : Color.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 2)
                )
        }
    }
}

#Preview{
    AddressView(user: Usuari(nomICognoms: "Test User", mail: "test@example.com", edat: 30, cumple: Date(), genere: "No especificar"))
}

