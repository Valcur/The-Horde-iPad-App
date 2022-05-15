//
//  HordeAppViewModel.swift
//  Horde
//
//  Created by Loic D on 14/05/2022.
//

import Foundation

class HordeAppViewModel: ObservableObject {
    @Published var readyToPlay: Bool
    
    init() {
        self.readyToPlay = false
    }
}
