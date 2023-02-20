//
//  LifePointsView.swift
//  Horde
//
//  Created by Loic D on 23/07/2022.
//

import SwiftUI

struct LifePointsView: View {

    @EnvironmentObject var lifePointsViewModel: LifePointsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LifePointsHordePanelView()
                .environmentObject(lifePointsViewModel)
            LifePointsSurvivorsPanelView()
                .environmentObject(lifePointsViewModel)
        }.ignoresSafeArea()
    }
}

struct LifePointsHordePanelView: View {
    
    @EnvironmentObject var lifePointsViewModel: LifePointsViewModel
    
    @State var prevValue: CGFloat = 0
    @State var totalChange: Int = 0
    @State var totalChangeTimer: Timer?
    
    var body: some View {
        ZStack {
            LifePointsPanelView(playerName: "Horde", lifepoints: $lifePointsViewModel.hordeLifepoints, totalChange: $totalChange, blurEffect: .systemMaterialDark)
            VStack(spacing: 0) {
                Rectangle()
                    .opacity(0.0001)
                    .onTapGesture {
                        addLifepoint()
                        startTotalChangeTimer()
                    }
                Rectangle()
                    .opacity(0.0001)
                    .onTapGesture {
                        removeLifepoint()
                        startTotalChangeTimer()
                    }
            }
        }
        .gesture(DragGesture()
            .onChanged { value in
                let newValue = value.translation.height
                if newValue > prevValue + 10 {
                    prevValue = newValue
                    removeLifepoint()
                }
                else if newValue < prevValue - 10 {
                    prevValue = newValue
                    addLifepoint()
                }
            }
            .onEnded({ _ in
                startTotalChangeTimer()
            })
        )
    }
    
    private func addLifepoint() {
        totalChangeTimer?.invalidate()
        lifePointsViewModel.hordeLifepoints += 1
        totalChange += 1
    }
    
    private func removeLifepoint() {
        totalChangeTimer?.invalidate()
        if lifePointsViewModel.hordeLifepoints > 0 {
            lifePointsViewModel.hordeLifepoints -= 1
            totalChange -= 1
        }
    }
    
    private func startTotalChangeTimer() {
        totalChangeTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            totalChange = 0
        }
    }
}

struct LifePointsSurvivorsPanelView: View {
    
    @EnvironmentObject var lifePointsViewModel: LifePointsViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    
    @State var prevValue: CGFloat = 0
    @State var totalChange: Int = 0
    @State var totalChangeTimer: Timer?
    
    var body: some View {
        ZStack {
            LifePointsPanelView(playerName: "Player", lifepoints: $lifePointsViewModel.survivorLifepoints, totalChange: $totalChange, blurEffect: .systemThinMaterialDark)
            VStack(spacing: 0) {
                Rectangle()
                    .opacity(0.0001)
                    .onTapGesture {
                        addLifepoint()
                        startTotalChangeTimer()
                    }
                Rectangle()
                    .opacity(0.0001)
                    .onTapGesture {
                        removeLifepoint()
                        startTotalChangeTimer()
                    }
            }
        }
        .gesture(DragGesture()
            .onChanged { value in
                let newValue = value.translation.height
                
                if newValue > prevValue + 15 {
                    prevValue = newValue
                    removeLifepoint()
                }
                else if newValue < prevValue - 15 {
                    prevValue = newValue
                    addLifepoint()
                }
            }
            .onEnded({ _ in
                startTotalChangeTimer()
            })
        )
    }
    
    private func addLifepoint() {
        totalChangeTimer?.invalidate()
        lifePointsViewModel.survivorLifepoints += 1
        totalChange += 1
    }
    
    private func removeLifepoint() {
        totalChangeTimer?.invalidate()
        if lifePointsViewModel.survivorLifepoints > 0 {
            lifePointsViewModel.survivorLifepoints -= 1
            totalChange -= 1
        }
    }
    
    private func startTotalChangeTimer() {
        totalChangeTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            if totalChange < 0 {
                if hordeAppViewModel.hordeGainLifeLostBySurvivor {
                    lifePointsViewModel.hordeLifepoints += -totalChange
                }
            }
            
            totalChange = 0
        }
    }
}

struct LifePointsPanelView: View {
    
    @EnvironmentObject var lifePointsViewModel: LifePointsViewModel
    
    let playerName: String
    @Binding var lifepoints: Int
    @Binding var totalChange: Int
    let blurEffect: UIBlurEffect.Style
    
    var body: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: blurEffect))
            
            VStack {
                Spacer()
                
                Text(playerName)
                    .font(.title3)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(lifepoints)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            
            if totalChange != 0 {
                VStack {
                    HStack {
                        Text(totalChange > 0  ? "+\(totalChange)" : "\(totalChange)")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.leading, 20).padding(.top, 20)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct LifePointsView_Previews: PreviewProvider {
    static var previews: some View {
        LifePointsView()
            .environmentObject(LifePointsViewModel(startingLife: 60))
    }
}

class LifePointsViewModel: ObservableObject {
    @Published var hordeLifepoints: Int
    @Published var survivorLifepoints: Int
    
    init(startingLife: Int) {
        self.hordeLifepoints = 20
        self.survivorLifepoints = startingLife
    }
}
