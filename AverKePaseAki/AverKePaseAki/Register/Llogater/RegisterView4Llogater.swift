import SwiftUI
import SwiftData

struct LlogaterView: View, Hashable {
    var id: UUID = UUID()
    var llog: Llogater // Recibe el objeto Usuari

    @State private var selectedBathrooms: Int = 1
    @State private var selectedBedrooms: Int = 1
    @State private var selectedSquareMeters: Double = 50.0 // Changed to Double
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Com és on vius?")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundColor(.white)
                
                // Sección de Baños
                Section(header: Text("Quants lavabos?").font(.headline).foregroundColor(.white)) {
                    HStack {
                        Image(systemName: "shower.fill")
                            .foregroundColor(.blue)
                        Text("\(selectedBathrooms)")
                            .font(.title)
                            .frame(width: 50, alignment: .center)
                            .foregroundColor(.white)
                        Stepper("", value: $selectedBathrooms, in: 1...5)
                            .labelsHidden()
                    }
                    .padding()
                    .background(Color.blue.opacity(0.5))
                    .cornerRadius(10)
                }
                
                // Sección de Habitaciones
                Section(header: Text("Quantes habitacions?").font(.headline).foregroundColor(.white)) {
                    HStack {
                        Image(systemName: "bed.double.fill")
                            .foregroundColor(.green)
                        Text("\(selectedBedrooms)")
                            .font(.title)
                            .frame(width: 50, alignment: .center)
                            .foregroundColor(.white)
                        Stepper("", value: $selectedBedrooms, in: 1...5)
                            .labelsHidden()
                    }
                    .padding()
                    .background(Color.green.opacity(0.5))
                    .cornerRadius(10)
                }
                
                // Sección de Metros Cuadrados
                Section(header: Text("Quants metres quadrats?").font(.headline).foregroundColor(.white)) {
                    VStack {
                        Text("\(Int(selectedSquareMeters)) m²") // Convert to Int for display
                            .font(.title)
                            .foregroundColor(.white)
                        Slider(value: $selectedSquareMeters, in: 20...200, step: 10)
                            .accentColor(.orange)
                    }
                    .padding()
                    .background(Color.orange.opacity(0.5))
                    .cornerRadius(10)
                }
                
                Spacer()
                
                // NavigationLink to the next view, e.g., LlogaterView2
                NavigationLink(destination: LlogaterView2(llog: Llogater(dadesUser: Usuari(nomICognoms: llog.dadesUser.nomICognoms, mail: llog.dadesUser.mail, edat: llog.dadesUser.edat, cumple: llog.dadesUser.cumple, password: llog.dadesUser.password, genere: llog.dadesUser.genere), direccio: "", CP: "", poblacio: "", provincia: "", pais: "", unisAprop: "", lavabos: selectedBathrooms, habitacions: selectedBedrooms, metrosCuadrats: Int(selectedSquareMeters)))) { // Convert to Int for passing
                    Text("Següent")
                        .padding()
                        .frame(maxWidth: 200)
                        .background(isFormValid ? Color.white : Color.black)
                        .foregroundColor(isFormValid ? Color.black : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2) // Contorno negro
                        )
                }
                .disabled(!isFormValid) // Deshabilitar el botón si el formulario no es válido
                .padding(.bottom, 30) // Espacio en la parte inferior
                Spacer()
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
    
    // Computed property to check if all fields are filled
    private var isFormValid: Bool {
        selectedBathrooms > 0 && selectedBedrooms > 0 && selectedSquareMeters > 0
    }
    
    // Implementación de Hashable
    static func == (lhs: LlogaterView, rhs: LlogaterView) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

#Preview {
    LlogaterView(llog: Llogater(dadesUser: Usuari(nomICognoms: "Test User", mail: "test@example.com", edat: 30, cumple: Date(), genere: "No especificar"), direccio: "", CP: "", poblacio: "", provincia: "", pais: "", unisAprop: ""))
}

