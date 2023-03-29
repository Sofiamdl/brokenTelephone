//
//  CustomFont.swift
//  client
//
//  Created by mvitoriapereirac on 29/03/23.
//

import SwiftUI

enum Style {
    case extraBold
    case light
}

func projectFont(style:Style, size: CGFloat) -> Font {
if style == .extraBold {

return .custom("Gilroy-ExtraBold", size: size)

}

if style == .light {

return .custom("Gilroy-Light", size: size)

}



return .custom("Gilroy-Light", size: 30)

}


