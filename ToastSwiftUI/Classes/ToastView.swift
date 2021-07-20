//
//  ToastView.swift
//  SwiftUIDemo
//
//  Created by Huy Nguyen on 9/16/20.
//  Copyright © 2020 HuyNguyen. All rights reserved.
//

import SwiftUI

public struct ToastView: View {
    public enum Icon {
        case info
        case error
        case success
        case custom(Image)
        case loading
    }
    
    let message: String
    let icon: Icon?
    let backgroundColor: Color
    let textColor: Color
    
    var iconSize: CGFloat {
        return message.isEmpty ? 40 : 20
    }
    
    public init(message: String, icon: Icon? = nil, backgroundColor: Color = Color(UIColor.systemBackground), textColor: Color = Color(UIColor.label)) {
        self.message = message
        self.icon = icon
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
    
    public var body: some View {
        VStack {
            if let icon = icon {
                iconView(icon: icon)
                    .frame(width: iconSize, height: iconSize)
            }
            
            if message.isEmpty == false {
                Text(message)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .foregroundColor(textColor)
            }
        }
        .padding(20)
        .background(backgroundColor)
    }
    
    @ViewBuilder
    private func iconView(icon: Icon) -> some View {
        switch icon {
        case .info:
            Image(systemName: "info.circle").resizable()
        case .success:
            Image(systemName: "checkmark.circle").resizable()
        case .error:
            Image(systemName: "xmark.circle").resizable()
        case .custom(let image):
            image
        case .loading:
            ActivityIndicator()
        }
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(message: "Hello World")
    }
}
