//
//  CaritasAppApp.swift
//  CaritasApp
//
//  Created by Abdiel Martínez Caicedo on 26/08/26.
//

import SwiftUI

@main
struct CaritasAppApp: App {
    @State private var hasStarted = false
    @State private var speech = SpeechService()
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            Group {
                if hasStarted {
                    AppTabView()
                } else {
                    WelcomeView(onEmpezar: {
                        speech.stop()
                        hasStarted = true
                    })
                }
            }
            .environment(speech)
            .alert(
                speech.alertMessage,
                isPresented: $speech.showUnavailableAlert
            ) {
                Button("Aceptar", role: .cancel) {}
            }
            .onChange(of: scenePhase) { _, newPhase in
                if newPhase != .active {
                    speech.stop()
                }
            }
        }
    }
}
