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
    // 1. Add a @State variable to control when showing the toast
    @State private var isShowingToast = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show toast") {
                // 4a. Set state variable to true if you want to show the toast
                self.isShowingToast = true
            }
            
            Button("Dismiss toast") {
                // 4b. Set state variable to false if you want to hide the toast
                self.isShowingToast = false
            }
            
            Spacer()
        }
        .padding()
        
        // 2. Add `toast` modifier to your view with the binding variable in step 1. You can use the built-in ToastView, or a custom view for toast view.
        .toast(isPresenting: $isShowingToast, dismissType: .after(2)) {
            ToastView(message: "Hello world!", icon: .success)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
