import SwiftUI

struct BuscadorView: View, Hashable {
    var id: UUID = UUID()
    @State private var selectedBathrooms: Int = 1
    @State private var selectedBedrooms: Int = 1
    @State private var selectedSquareMeters: Double = 50
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    Text("Quina classe de pis busques?")
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
                            Text("\(Int(selectedSquareMeters)) m²")
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
                    
                    NavigationLink(destination: BuscadorView2()) { // Reemplaza NextView con tu vista de destino
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
    }
    // Computed property to check if all fields are filled
    private var isFormValid: Bool {
        selectedBathrooms > 0 && selectedBedrooms > 0 && selectedSquareMeters > 0
    }
    
    // Implementación de Hashable
    static func == (lhs: BuscadorView, rhs: BuscadorView) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


#Preview {
    BuscadorView()
}


