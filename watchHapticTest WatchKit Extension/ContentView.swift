//
//  ContentView.swift
//  watchHapticTest WatchKit Extension
//
//  Created by Issac Penn on 9/26/20.
//

import SwiftUI

struct ContentView: View {
    private let allHapticTypes: [(WKHapticType, String)] = [
        (.notification, "Notification"),
        (.directionUp, "Direction Up"),
        (.directionDown, "Direction Down"),
        (.success, "Success"),
        (.failure, "Failure"),
        (.retry, "Retry"),
        (.start, "Start"),
        (.stop, "Stop"),
        (.click, "Click"),
        (.navigationLeftTurn, "Navigation Left Turn"),
        (.navigationRightTurn, "Navigation Right Turn"),
        (.navigationGenericManeuver, "Navigation Generic Maneuver"),
    ]
    
    @State private var locationManager: CLLocationManager!
    
    var body: some View {
        NavigationView {
            List (allHapticTypes, id: \.self.0 ){ hapticType in
                Button("\(hapticType.1)") {
                    let interfaceDevice = WKInterfaceDevice.current()
                    if hapticType.0.rawValue >= 9 {
                        self.locationManager.requestAlwaysAuthorization()
                        self.locationManager.allowsBackgroundLocationUpdates = true
                        self.locationManager.startUpdatingLocation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                            interfaceDevice.play(hapticType.0)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                            self.locationManager.stopUpdatingLocation()
                        }
                    } else {
                        interfaceDevice.play(hapticType.0)
                    }
                }
            }
            .navigationTitle("Haptics")
            .onAppear {
                if self.locationManager == nil { self.locationManager = CLLocationManager() }
//                self.locationManager.delegate = self
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
