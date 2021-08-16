//
//  ContentView.swift
//  ToastExample
//
//  Created by Huy Nguyen on 9/16/20.
//  Copyright © 2020 HuyNguyen. All rights reserved.
//

import SwiftUI
import ToastSwiftUI

struct ContentView: View {
    // 1. Add @State variables to control when showing the toast or popup
    @State private var isPresentingPopup = false
    
    // The first way to show a toast
    @State private var isPresentingToast = false
    
    // The second way to show a toast
    @State private var toastMessage: String?
    @State private var count = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show a success toast") {
                // 3a. Set state variable to true if you want to show the toast
                self.isPresentingToast = true
            }
            
            Button("Dismiss the success toast") {
                // 3b. Set state variable to false if you want to hide the toast
                self.isPresentingToast = false
            }
            
            Divider()
            
            Button("Show counter toast") {
                // 3e. Set text variable you want to show
                toastMessage = "Toast number \(count)"
                
                count += 1
            }
            
            Button("Dismiss counter toast") {
                // 3f. Set text variable to nil
                self.toastMessage = nil
            }
            
            Divider()
            
            Button("Show popup") {
                // 3c. Set state variable to true if you want to show the popup
                self.isPresentingPopup = true
            }
            
            Button("Dismiss popup") {
                // 3d. Set state variable to true if you want to hide the popup
                self.isPresentingPopup = false
            }
            
            Spacer()
        }
        .padding()
        
        // 2. Add a `popup` modifier to your view with the binding variable in step 1
        .popup(isPresenting: $isPresentingPopup) {
            MyPopup(isPresenting: $isPresentingPopup)
                .background(Color(.systemBackground))
        }
        
        // 2. Add a `toast` modifier to your view with the binding variable in step 1
        .toast(isPresenting: $isPresentingToast, message: "Success", icon: .success)
        
        .toast($toastMessage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
