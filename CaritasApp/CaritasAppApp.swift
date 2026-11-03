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

    var body: some Scene {
        WindowGroup {
            if hasStarted {
                AppTabView()
            } else {
                WelcomeView(onEmpezar: { hasStarted = true })
            }
        }
    }
}
