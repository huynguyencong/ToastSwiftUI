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
            Text("Success")
                .font(.title)
            
            Text("You just show a custom popup!")
            
            Button("Dismiss") {
                isPresenting = false
            }
        }
    }
}

struct MyPopup_Previews: PreviewProvider {
    static var previews: some View {
        MyPopup(isPresenting: .constant(true))
    }
}
