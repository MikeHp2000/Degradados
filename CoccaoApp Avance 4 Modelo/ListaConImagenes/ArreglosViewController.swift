//
//  ArreglosViewController.swift
//  ListaConImagenes
//
//  Created by Miguel Angel Herrera Perez on 13/03/23.
//

import Foundation

var shapeList = [Shape]()
func Lugar(Salon: String!, Unidad: Character, Uname: String!,Iname: String! ) {
    shapeList.append(  Shape(Salon: Salon, UbSalon: "Unidad \(Unidad)", imageName: Uname, imageUb: Iname) )
}
