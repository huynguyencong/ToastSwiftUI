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
                // 4a. Set @State variable to true if you want to show the toast
                self.isShowingToast = true
            }
            
            Button("Dismiss toast") {
                // 4b. Set @State variable to false if you want to hide the toast
                self.isShowingToast = false
            }
            
            Spacer()
        }
        .padding()
        
        // 2. Add `toast` modifier to your view with the binding variable in step 1
        .toast(isPresenting: $isShowingToast, dismissType: .after(2)) {
            
            // 3. This is the toast will be showed.
            // You can use built-in ToastView, or any custom view created by you.
            ToastView(message: "Hello world!", icon: .success)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
