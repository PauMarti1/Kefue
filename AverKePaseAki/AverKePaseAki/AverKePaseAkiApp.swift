//
//  AverKePaseAkiApp.swift
//  AverKePaseAki
//
//  Created by Pau on 26/8/24.
//

import SwiftUI
import SwiftData

class RegistroData: ObservableObject {
    @Published var nomICognoms: String = ""
    @Published var mail: String = ""
    @Published var edat: Int = 0
    @Published var cumple: Date = Date()
    @Published var password: String? = nil
    @Published var genere: String = ""
    
    @Published var direccio: String = ""
    @Published var CP: String = ""
    @Published var poblacio: String = ""
    @Published var provincia: String = ""
    @Published var pais: String = ""
    @Published var unisAprop: String = ""
    @Published var lavabos: Int?
    @Published var habitacions: Int?
    @Published var metrosCuadrats: Int?
    @Published var rutinaNeteja: Int?
    @Published var fumador: Bool?
    @Published var mascotes: Bool?
    @Published var preu: Float?
}


@main
struct AverKePaseAkiApp: App {
    @StateObject private var registroData = RegistroData()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Usuari.self,
            Buscador.self,
            Llogater.self
            //Anuncio.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView(id: UUID())
        }
        .modelContainer(sharedModelContainer)
    }
}
