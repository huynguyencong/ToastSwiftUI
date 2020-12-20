//
//  MyPopup.swift
//  ToastExample
//
//  Created by Huy Nguyen on 9/21/20.
//  Copyright © 2020 HuyNguyen. All rights reserved.
//

import SwiftUI

struct MyPopup: View {
    @Binding var isPresenting: Bool
    
    var body: some View {
        VStack {
            Text("Hello")
                .font(.title)
            
            Text("This is my popup!")
            
            Button("Dismiss") {
                isPresenting = false
            }
            .padding(.top)
        }
        .padding()
    }
}

struct MyPopup_Previews: PreviewProvider {
    static var previews: some View {
        MyPopup(isPresenting: .constant(true))
    }
}
