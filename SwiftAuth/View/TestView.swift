//
//  TestView.swift
//  SwiftAuth
//
//  Created by Ashraf Hatia on 12/03/24.
//

import SwiftUI

struct TestView: View {
    @State private var tapCount = 0
    
    @State private var progressValue: Float = 0
    
    
    var body: some View {
        Spacer()
        
//        Path { path in
//            path.move(to: CGPoint(x: 100, y: 20))
//            path.addLine(to: CGPoint(x: 10, y: 100))
//            path.addLine(to: CGPoint(x: 150, y: 100))
//            path.addLine(to: CGPoint(x: 150, y: 0))
//            // or path.closeSubpath() //for the last line closing the shape
//        }
//        .stroke()
        
    }
    
    private func getDateToday() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return "Today, \(formatter.string(from: date))"
    }
    
    
    private func incrementProgress(){
        if self.tapCount>0 && self.tapCount % 33 == 0 {
            self.progressValue = (1/33)
        } else {
            self.progressValue += (1/33)
        }
        
        self.tapCount += 1
        
        //            Preferences.saveInt(value: self.tapCount, forKey: AppConstant().PREF_TOTAL_TAP)
        //
        //            Preferences.saveFloat(value: self.progressValue, forKey: AppConstant().PREF_PROGRESS)
    }
    
    private func resetCounter(){
        self.tapCount = 0
        self.progressValue = 0
        
        //            Preferences.saveInt(value: self.tapCount, forKey: AppConstant().PREF_TOTAL_TAP)
        //
        //            Preferences.saveFloat(value: self.progressValue, forKey: AppConstant().PREF_PROGRESS)
    }
}


#Preview {
    TestView()
}
