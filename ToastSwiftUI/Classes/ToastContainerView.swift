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
    let hasShadow: Bool
    let cornerRadius: CGFloat
    let overlayColor: Color
    let isTapOutsideToDismiss: Bool
    let content: Content
    let popup: () -> Popup
    
    @State var timer: Timer? = nil
    
    var body: some View {
        ZStack {
            content
            
            if isPresenting {
                overlayColor
                    .if(isTapOutsideToDismiss) {
                        $0.onTapGesture {
                            self.isPresenting = false
                        }
                    }
                    .transition(.opacity)
                
                popup()
                    .transition(.opacity)
                    .ifElse(hasShadow, {
                        $0
                            .cornerRadius(cornerRadius)
                            .shadow(color: Color(UIColor.tertiaryLabel), radius: 3)
                    }, else: {
                        $0.cornerRadius(cornerRadius)
                    })
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

struct PopupModifier<Popup: View>: ViewModifier {
    var isPresenting: Binding<Bool>
    var hasShadow: Bool = true
    var cornerRadius: CGFloat = 10
    var overlayColor: Color = Color.clear
    var isTapOutsideToDismiss: Bool = false
    var autoDismiss: PopupAutoDismissType = .none
    var onDisappear: (() -> Void)? = nil
    var popup: () -> Popup
    
    func body(content: Self.Content) -> some View {
        PopupContainerView(isPresenting: isPresenting, autoDismiss: autoDismiss, onDisappear: onDisappear, hasShadow: hasShadow, cornerRadius: cornerRadius, overlayColor: overlayColor, isTapOutsideToDismiss: isTapOutsideToDismiss, content: content, popup: popup)
    }
}

public extension View {
    func popup<Popup: View>(
        isPresenting: Binding<Bool>,
        hasShadow: Bool = true,
        cornerRadius: CGFloat = 10,
        overlayColor: Color = Color.gray.opacity(0.1),
        isTapOutsideToDismiss: Bool = true,
        autoDismiss: PopupAutoDismissType = .none,
        onDisappear: (() -> Void)? = nil,
        @ViewBuilder popup: @escaping () -> Popup
    ) -> some View {
        modifier(PopupModifier(isPresenting: isPresenting, hasShadow: hasShadow, cornerRadius: cornerRadius, overlayColor: overlayColor, isTapOutsideToDismiss: isTapOutsideToDismiss, autoDismiss: autoDismiss, onDisappear: onDisappear, popup: popup))
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
        
        return modifier(PopupModifier(isPresenting: isPresenting, hasShadow: true, cornerRadius: 10, overlayColor: .clear, isTapOutsideToDismiss: false, autoDismiss: popupAutoDismiss, onDisappear: onDisappear) {
            ToastView(message: message, icon: icon, backgroundColor: backgroundColor, textColor: textColor)
        })
    }
    
    func toast(
        _ messageBinding: Binding<String?>,
        icon: ToastView.Icon? = nil,
        backgroundColor: Color = Color(UIColor.systemBackground),
        textColor: Color = Color(UIColor.label),
        autoDismiss: ToastAutoDismissType = .auto,
        onDisappear: (() -> Void)? = nil
    ) -> some View {
        let message = messageBinding.wrappedValue ?? ""
        
        let isPresenting = Binding<Bool> {
            return messageBinding.wrappedValue != nil
        } set: { value in
            if value == false {
                messageBinding.wrappedValue = nil
            }
        }
        
        return toast(isPresenting: isPresenting, message: message, icon: icon, backgroundColor: backgroundColor, textColor: textColor, autoDismiss: autoDismiss, onDisappear: onDisappear)
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
