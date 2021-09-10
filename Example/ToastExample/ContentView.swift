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
    // 1.1. Example 1: Add @State variables to control when showing the popup
    @State private var isPresentingPopup = false
    
    // 1.2. Example 2: First way to show a toast. Add @State variables to control when showing the toast
    @State private var isPresentingToast = false
    
    // 1.3. Example 3: Second way to show a toast. Add an optional String @State variables to control when showing the toast
    @State private var toastMessage: String?
    
    @State private var count = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show a success toast with a boolean variable") {
                // 3.2.1. Set state variable to true if you want to show the toast
                self.isPresentingToast = true
            }
            
            Button("Dismiss the success toast") {
                // 3.2.2. Set state variable to false if you want to hide the toast
                self.isPresentingToast = false
            }
            
            Divider()
            
            Button("Show toast with a text binding") {
                // 3.3.1. Set text variable you want to show
                toastMessage = "Toast number \(count)"
                
                count += 1
            }
            
            Button("Dismiss toast") {
                // 3.3.2. Set text variable to nil
                self.toastMessage = nil
            }
            
            Divider()
            
            Button("Show popup") {
                // 3.1.1. Set state variable to true if you want to show the popup
                self.isPresentingPopup = true
            }
            
            Button("Dismiss popup") {
                // 3.1.2. Set state variable to true if you want to hide the popup
                self.isPresentingPopup = false
            }
            
            Spacer()
        }
        .padding()
        
        // 2.1. Add a `popup` modifier to your view with the binding variable in step 1
        .popup(isPresenting: $isPresentingPopup, popup:
            MyPopup(isPresenting: $isPresentingPopup)
                .background(Color(.systemBackground))
        )
        
        // 2.2. Add a `toast` modifier to your view with the binding variable in step 1
        .toast(isPresenting: $isPresentingToast, message: "Success", icon: .success)
        
        // 2.3. Add a `toast` modifier to your view with the binding variable in step 1
        .toast($toastMessage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
