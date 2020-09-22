//
//  PopupContainerView.swift
//  SwiftUIDemo
//
//  Created by Huy Nguyen on 9/16/20.
//  Copyright © 2020 HuyNguyen. All rights reserved.
//

import SwiftUI

private struct PopupContainerView<Content: View, Popup: View>: View {
    @Binding var isPresenting: Bool
    let autoDismiss: PopupAutoDismissType
    let onDisappear: (() -> Void)?
    let content: Content
    let popup: () -> Popup
    
    @State var timer: Timer? = nil
    
    var body: some View {
        ZStack {
            content
            
            if isPresenting {
                popup()
                    .transition(.opacity)
                    .animation(.default)
                    .padding()
                    .onAppear {
                        self.onPopupAppear()
                    }
                    .onDisappear {
                        self.onPopupDisappear()
                    }
            }
        }
    }
    
    private func onPopupAppear() {
        var showTime: TimeInterval = 0
        switch autoDismiss {
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
    
    private func onPopupDisappear() {
        timer?.invalidate()
        timer = nil
        onDisappear?()
    }
}

public extension View {
    func popup<Popup: View>(
        isPresenting: Binding<Bool>,
        autoDismiss: PopupAutoDismissType = .none,
        onDisappear: (() -> Void)? = nil,
        popup: @escaping () -> Popup
    ) -> some View {
        
        return PopupContainerView(isPresenting: isPresenting, autoDismiss: autoDismiss, onDisappear: onDisappear, content: self, popup: popup)
    }
    
    func toast(
        isPresenting: Binding<Bool>,
        message: String,
        icon: ToastView.Icon? = nil,
        backgroundColor: Color = Color(UIColor.systemBackground),
        textColor: Color = Color(UIColor.label),
        autoDismiss: ToastAutoDismissType = .auto,
        onDisappear: (() -> Void)? = nil
    ) -> some View {
        
        let popupAutoDismiss = autoDismiss.toPopupAutoDismissType(message: message)
        
        return PopupContainerView(isPresenting: isPresenting, autoDismiss: popupAutoDismiss, onDisappear: onDisappear, content: self) {
            ToastView(message: message, icon: icon, backgroundColor: backgroundColor, textColor: textColor)
        }
    }
}

public enum PopupAutoDismissType {
    /// don't auto dismiss
    case none
    case after(TimeInterval)
    
    /// String param is the message that user will read. It is used to calculate time
    case auto(String)
}

public enum ToastAutoDismissType {
    /// don't auto dismiss
    case none
    case after(TimeInterval)
    
    /// String param is the message that user will read. It is used to calculate time
    case auto
    
    func toPopupAutoDismissType(message: String) -> PopupAutoDismissType {
        switch self {
        case .none:
            return .none
        case .after(let duration):
            return .after(duration)
        case .auto:
            return .auto(message)
        }
    }
}
