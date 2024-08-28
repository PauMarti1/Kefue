//
//  Item.swift
//  AverKePaseAki
//
//  Created by Pau on 26/8/24.
//

import Foundation
import SwiftData

@Model
final class Usuari {
    var nomICognoms: String
    var mail: String
    var edat: Int
    var cumple: Date
    var password: String?
    var genere: String
    
    
    init(nomICognoms: String, mail: String, edat: Int, cumple: Date, password: String? = nil, genere: String) {
        self.nomICognoms = nomICognoms
        self.mail = mail
        self.edat = edat
        self.cumple = cumple
        self.password = password
        self.genere = genere
    }
    
    static var usuarios: [Usuari] = []
        
        // Busca un usuario por email y verifica la contraseña
        static func verificarCredenciales(mail: String, password: String) -> Bool {
            // Encuentra el usuario con el correo electrónico dado
            guard let usuario = usuarios.first(where: { $0.mail == mail }) else {
                return false // Usuario no encontrado
            }
            
            // Verifica si la contraseña coincide
            return usuario.password == password
        }
}

@Model
final class Buscador {
    var dadesUser : [Usuari]
    var lavabos : Int
    var habitacions : Int
    var metrosCuadrats : Int
    var professio : String // "Estudio", "Treballo", "Res"
    var fumador : Bool
    var mascotes : Bool
    var preu : Float
    
    
    init(dadesUser: [Usuari], lavabos: Int, habitacions: Int, metrosCuadrats: Int, professio: String, fumador: Bool, mascotes: Bool, preu: Float, password: String) {
        self.dadesUser = dadesUser
        self.lavabos = lavabos
        self.habitacions = habitacions
        self.metrosCuadrats = metrosCuadrats
        self.professio = professio
        self.fumador = fumador
        self.mascotes = mascotes
        self.preu = preu
    }
}

@Model
final class Llogater {
    var dadesUser : Usuari
    var direccio : String
    var CP : String
    var poblacio : String
    var provincia : String
    var pais : String
    var unisAprop : String
    var lavabos : Int?
    var habitacions : Int?
    var metrosCuadrats : Int?
    var rutinaNeteja : Int? // 1 = Semanal, 2 = Diari, 3 = Cada 2-3 dies
    var fumador : Bool?
    var mascotes : Bool?
    var preu : Float?
    
    init(dadesUser: Usuari, direccio: String, CP: String, poblacio: String, provincia: String, pais: String, unisAprop: String, lavabos: Int? = nil, habitacions: Int? = nil, metrosCuadrats: Int? = nil, rutinaNeteja: Int? = nil, fumador: Bool? = nil, mascotes: Bool? = nil, preu: Float? = nil) {
        self.dadesUser = dadesUser
        self.direccio = direccio
        self.CP = CP
        self.poblacio = poblacio
        self.provincia = provincia
        self.pais = pais
        self.unisAprop = unisAprop
        self.lavabos = lavabos
        self.habitacions = habitacions
        self.metrosCuadrats = metrosCuadrats
        self.rutinaNeteja = rutinaNeteja
        self.fumador = fumador
        self.mascotes = mascotes
        self.preu = preu
    }
}

/*@Model
final class Anuncio {
    var titulo: String
    var descripcion: String
    var precio: String
    
    init(id: UUID = UUID(), titulo: String, descripcion: String, precio: String) {
        self.titulo = titulo
        self.descripcion = descripcion
        self.precio = precio
    }
}*/
