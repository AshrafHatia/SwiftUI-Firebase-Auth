//
//  ButtonView.swift
//  SwiftAuth
//
//  Created by Ashraf Hatia on 14/03/24.
//

import SwiftUI

struct ButtonView: View {
    var label: String
    let icon: String?
    let formValid: Bool
    let action: () -> Void
    
    var body: some View {
        
        Button(action: {
            action()
        }, label: {
            HStack{
                Text(label)
                    .fontWeight(.semibold)
                if let icon {
                    Image(systemName: icon)
                }
            }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
        })
        .background(Color(.systemBlue))
        .disabled(!formValid)
        .opacity(formValid ? 1.9 : 0.5)
        .cornerRadius(10)
        .padding(.top, 24)    }
}

#Preview {
    ButtonView(label: "", icon: "arrow.right", formValid: false) {
        print("clicked")
    }
}
