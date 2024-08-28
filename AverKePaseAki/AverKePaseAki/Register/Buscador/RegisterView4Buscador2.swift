import SwiftUI

struct BuscadorView2: View, Hashable {
    var id: UUID = UUID()
    @State private var selectedStatus: String = ""
    @State private var smokes: String = ""
    @State private var likesPets: String = ""
    @State private var selectedBudget: Double = 500
    
    @State private var smokeType: String = ""
    let smokeTypes = ["Tabac", "Altres"]
    
    let statuses = ["Estudio", "Treballo", "Res"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("loginImage")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Com ets?")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(.white)
                    
                    // Estado actual
                    Section(header: Text("Que fas?").font(.headline).foregroundColor(.white)) {
                        HStack {
                            ForEach(statuses, id: \.self) { status in
                                Button(action: {
                                    selectedStatus = status
                                }) {
                                    Text(status)
                                        .foregroundColor(selectedStatus == status ? .black : .white)
                                        .padding()
                                        .background(
                                            Capsule()
                                                .fill(selectedStatus == status ? Color.white : Color.black)
                                        )
                                        .overlay(
                                            Capsule()
                                                .stroke(Color.white, lineWidth: 2)
                                        )
                                }
                            }
                        }
                        .padding(.vertical, 1)
                    }
                    
                    // Fumas
                    Section(header: Text("Fumes?").font(.headline).foregroundColor(.white)) {
                        HStack {
                            Button(action: {
                                smokes = "Sí"
                            }) {
                                Text("Sí")
                                    .foregroundColor(smokes == "Sí" ? .black : .white)
                                    .padding()
                                    .background(
                                        Capsule()
                                            .fill(smokes == "Sí" ? Color.white : Color.black)
                                    )
                                    .overlay(
                                        Capsule()
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            }
                            
                            Button(action: {
                                smokes = "No"
                            }) {
                                Text("No")
                                    .foregroundColor(smokes == "No" ? .black : .white)
                                    .padding()
                                    .background(
                                        Capsule()
                                            .fill(smokes == "No" ? Color.white : Color.black)
                                    )
                                    .overlay(
                                        Capsule()
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            }
                        }
                        .padding(.vertical, 1)
                        
                        if smokes == "Sí" {
                            HStack(spacing: 10) {
                                ForEach(smokeTypes, id: \.self) { type in
                                    Button(action: {
                                        smokeType = type
                                    }) {
                                        Text(type)
                                            .foregroundColor(smokeType == type ? .black : .white)
                                            .padding(8)
                                            .frame(width: 100) // Ajustar el ancho según lo desees
                                            .background(
                                                Capsule()
                                                    .fill(smokeType == type ? Color.white : Color.black)
                                            )
                                            .overlay(
                                                Capsule()
                                                    .stroke(Color.white, lineWidth: 2)
                                            )
                                    }
                                }
                            }
                            .padding(.vertical, 1)
                        }
                    }
                    
                    // Te gustan las mascotas
                    Section(header: Text("Conviuries amb mascotes?").font(.headline).foregroundColor(.white)) {
                        HStack {
                            Button(action: {
                                likesPets = "Sí"
                            }) {
                                Text("Sí")
                                    .foregroundColor(likesPets == "Sí" ? .black : .white)
                                    .padding()
                                    .background(
                                        Capsule()
                                            .fill(likesPets == "Sí" ? Color.white : Color.black)
                                    )
                                    .overlay(
                                        Capsule()
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            }
                            
                            Button(action: {
                                likesPets = "No"
                            }) {
                                Text("No")
                                    .foregroundColor(likesPets == "No" ? .black : .white)
                                    .padding()
                                    .background(
                                        Capsule()
                                            .fill(likesPets == "No" ? Color.white : Color.black)
                                    )
                                    .overlay(
                                        Capsule()
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            }
                        }
                        .padding(.vertical, 1)
                    }
                    
                    // Presupuesto mensual
                    Section(header: Text("Quant vols pagar?")
                                    .font(.headline)
                                    .foregroundColor(.white)) {
                                    VStack {
                                        Text("\(Int(selectedBudget)) €") // Convertir Double a Int para mostrar
                                            .font(.title)
                                            .foregroundColor(.white)
                                        
                                        Slider(value: $selectedBudget, in: 300...1500, step: 50)
                                            .accentColor(.orange)
                                            .frame(width: 250) // Ajustar el ancho del slider
                                    }
                                    .padding()
                                    .background(Color.orange.opacity(0.5))
                                    .cornerRadius(10)
                                }
                    
                    //Spacer()
                    
                    NavigationLink(destination: ProfileSummaryView(selectedStatus: selectedStatus, smokes: smokes, likesPets: likesPets, selectedBudget: Int(selectedBudget))) {
                        Text("Següent")
                            .padding()
                            .frame(maxWidth: 200)
                            .background(isFormValid ? Color.white : Color.black)
                            .foregroundColor(isFormValid ? Color.black : Color.white)
                            .cornerRadius(10)
                    }
                    .disabled(!isFormValid)
                    .padding(.bottom, 30)
                }
                .padding()
                .background(Color.black.edgesIgnoringSafeArea(.all))
            }
        }
        
        
        }
    private var isFormValid: Bool {
        !selectedStatus.isEmpty && !smokes.isEmpty && !likesPets.isEmpty && selectedBudget > 0
    }
    
    static func == (lhs: BuscadorView2, rhs: BuscadorView2) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ProfileSummaryView: View {
    var selectedStatus: String
    var smokes: String
    var likesPets: String
    var selectedBudget: Int
    
    var body: some View {
        VStack {
            Text("Resumen del Perfil")
                .font(.largeTitle)
                .bold()
                .padding()
                .foregroundColor(.white)
            
            Text("Estado actual: \(selectedStatus)")
                .foregroundColor(.white)
            Text("Fumas: \(smokes)")
                .foregroundColor(.white)
            Text("Te gustan las mascotas: \(likesPets)")
                .foregroundColor(.white)
            Text("Presupuesto mensual: €\(selectedBudget)")
                .foregroundColor(.white)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    BuscadorView2()
}


