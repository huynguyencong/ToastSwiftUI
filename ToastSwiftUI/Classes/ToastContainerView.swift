//
//  ToastContainerView.swift
//  SwiftUIDemo
//
//  Created by Huy Nguyen on 9/16/20.
//  Copyright © 2020 HuyNguyen. All rights reserved.
//

import SwiftUI

public enum ToastDismissType {
    case none
    case after(TimeInterval)
    case auto(String)
}

private struct ToastContainerView<Content: View, Toast: View>: View {
    @Binding var isPresenting: Bool
    let dismissType: ToastDismissType?
    let onDisappear: (() -> Void)?
    let content: Content
    let toast: () -> Toast
    
    @State var timer: Timer? = nil
    
    var body: some View {
        ZStack {
            content
            
            if isPresenting {
                toast()
                    .transition(.opacity)
                    .animation(.default)
                    .padding()
                    .onAppear {
                        self.onToastAppear()
                    }
                    .onDisappear {
                        self.onToastDisappear()
                    }
            }
        }
    }
    
    private func onToastAppear() {
        var showTime: TimeInterval = 0
        switch dismissType {
        case .after(let duration):
            showTime = duration
            
        case .auto(let message):
            let estimateWords = Double(message.count)/5
            let minDuration: TimeInterval = 2
            showTime = max(estimateWords/3, minDuration)
            
        default: break
        }
        
        if showTime > 0 {
            timer = Timer.scheduledTimer(withTimeInterval: showTime, repeats: false) { _ in
                self.isPresenting = false
            }
        }
    }
    
    private func onToastDisappear() {
        timer?.invalidate()
        timer = nil
        onDisappear?()
    }
}

public extension View {
    func toast<Toast: View>(
        isPresenting: Binding<Bool>,
        dismissType: ToastDismissType? = .after(3),
        onDisappear: (() -> Void)? = nil,
        toast: @escaping () -> Toast
    ) -> some View {
        
        return ToastContainerView(isPresenting: isPresenting, dismissType: dismissType, onDisappear: onDisappear, content: self, toast: toast)
    }
}
