import SwiftUI

struct LlogaterView2: View {
    @State private var selectedStatus: String = ""
    @State private var smokes: String = ""
    @State private var likesPets: String = ""
    @State private var selectedBudget: Double = 500
    
    let statuses = ["Semanal", "Diari", "Cada 2-3 dies"]
    
    var llog: Llogater
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("loginImage")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Normes del pis on vius")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(.white)
                    
                    // Estado actual
                    Section(header: Text("Rutina de neteja?").font(.headline).foregroundColor(.white)) {
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
                    Section(header: Text("Es pot fumar?").font(.headline).foregroundColor(.white)) {
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
                    }
                    
                    // Te gustan las mascotas
                    Section(header: Text("Hi ha mascotes?").font(.headline).foregroundColor(.white)) {
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
                    Section(header: Text("Quant val el lloguer?")
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
}

#Preview {
    LlogaterView2(llog: Llogater(dadesUser: Usuari(nomICognoms: "Test User", mail: "test@example.com", edat: 30, cumple: Date(), genere: "No especificar"), direccio: "", CP: "", poblacio: "", provincia: "", pais: "", unisAprop: "", lavabos: 1, habitacions: 1, metrosCuadrats: 1, rutinaNeteja: 1, fumador: true, mascotes: true, preu: 1.0))
}


