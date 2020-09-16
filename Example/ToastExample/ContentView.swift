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
    @State private var isShowingToast = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show toast") {
                self.isShowingToast = true
            }
            
            Button("Dismiss toast") {
                self.isShowingToast = false
            }
            
            Spacer()
        }
        .padding()
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
