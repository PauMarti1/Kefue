import SwiftUI

struct RegisterView1: View {
    @State private var nom: String = ""
    @State private var email: String = ""
    @State private var selectedDate = Date()
    @State private var age: Int = 0
    @State private var selectedGender = "No especificar"
    
    @EnvironmentObject var registroData: RegistroData
    @Environment(\.modelContext) private var modelContext
    
    let genders = [
        "Home", "Dona", "No especificar", "Agènere", "Bigènere", "Gènere fluid", "Gènere no binari",
        "Gènere neutre", "Intergènere", "Pangènere", "Transgènere", "Altres"
    ]
    
    private var isFormValid: Bool {
        !nom.isEmpty && !email.isEmpty && selectedDate != Date.distantFuture
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer().frame(height: 30)
                
                Text("Registre1")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer().frame(height: 50)
                
                VStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("   Posa nom i cognoms: ")
                            .font(.headline)
                            .foregroundColor(.white)
                        ZStack(alignment: .leading) {
                            CustomTextField(placeholder: "Nom i cognoms", text: $nom, icon: "person.circle")
                        }
                    }
                    .padding(.horizontal, 12)
                    .frame(maxWidth: 280, alignment: .center)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("   Posa el email: ")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ZStack(alignment: .leading) {
                            CustomTextField(placeholder: "Email", text: $email, icon: "envelope.fill")
                        }
                        .padding(.horizontal, 12)
                    }
                    .frame(maxWidth: 280, alignment: .center)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(" Posa el teu cumple: ")
                            .font(.headline)
                            .foregroundColor(.white)
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .frame(maxWidth: 150)
                            .labelsHidden()
                            .colorScheme(.dark)
                            .tint(.white)
                    }
                    .frame(maxWidth: 280, alignment: .center)
                    .onChange(of: selectedDate) { newDate in
                        let age = calculateAge(from: newDate)
                        self.age = age
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Com t'identifiques?")
                            .font(.headline)
                            .foregroundColor(.white)
                        Picker("Selecciona tu género", selection: $selectedGender) {
                            ForEach(genders, id: \.self) { gender in
                                Text(gender).tag(gender)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 44)
                        )
                        .frame(maxWidth: 150)
                        .labelsHidden()
                    }
                    .frame(maxWidth: 280, alignment: .center)
                    
                    NavigationLink(destination: RegisterView2(user: Usuari(nomICognoms: nom, mail: email, edat: age, cumple: selectedDate, genere: selectedGender))) {
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
                    .disabled(!isFormValid)
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
    
    func calculateAge(from date: Date) -> Int {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: date, to: Date())
        return ageComponents.year ?? 0
    }
}

#Preview {
    RegisterView1()
}
