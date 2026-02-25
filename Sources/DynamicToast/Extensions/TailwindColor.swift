//
//  TailwindColor.swift
//  DynamicToast
//
//  Created by Alhassan AlMakki on 08/09/1447 AH.
//

import SwiftUI

public extension Color {
    init(oklch string: String, opacity: Double = 1.0) {
        let cleanedString = string
            .replacingOccurrences(of: "oklch(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "%", with: "")
        
        let components = cleanedString.split(separator: " ").compactMap { Double(String($0)) }
        
        guard components.count >= 3 else {
            self.init(.clear)
            return
        }
        
        let l = components[0] / 100.0
        let c = components[1]
        let h = components[2]
        
        let hRad = h * .pi / 180.0
        let a = c * cos(hRad)
        let b = c * sin(hRad)
        
        let l_ = l + 0.3963377774 * a + 0.2158037573 * b
        let m_ = l - 0.1055613458 * a - 0.0638541728 * b
        let s_ = l - 0.0894841775 * a - 1.2914855480 * b
        
        let l_3 = l_ * l_ * l_
        let m_3 = m_ * m_ * m_
        let s_3 = s_ * s_ * s_
        
        let r = +4.0767416621 * l_3 - 3.3077115913 * m_3 + 0.2309699292 * s_3
        let g = -1.2684380046 * l_3 + 2.6097574011 * m_3 - 0.3413193965 * s_3
        let b_ = -0.0041960863 * l_3 - 0.7034186147 * m_3 + 1.7076147010 * s_3
        
        self.init(.displayP3, red: max(0, min(1, r)), green: max(0, min(1, g)), blue: max(0, min(1, b_)), opacity: opacity)
    }
    
    // MARK: - Slate
    static let twSlate50 = Color(oklch: "oklch(98.4% 0.003 247.858)")
    static let twSlate100 = Color(oklch: "oklch(96.8% 0.007 247.896)")
    static let twSlate200 = Color(oklch: "oklch(92.9% 0.013 255.508)")
    static let twSlate300 = Color(oklch: "oklch(86.9% 0.022 252.894)")
    static let twSlate400 = Color(oklch: "oklch(70.4% 0.04 256.788)")
    static let twSlate500 = Color(oklch: "oklch(55.4% 0.046 257.417)")
    static let twSlate600 = Color(oklch: "oklch(44.6% 0.043 257.281)")
    static let twSlate700 = Color(oklch: "oklch(37.2% 0.044 257.287)")
    static let twSlate800 = Color(oklch: "oklch(27.9% 0.041 260.031)")
    static let twSlate900 = Color(oklch: "oklch(20.8% 0.042 265.755)")
    static let twSlate950 = Color(oklch: "oklch(12.9% 0.042 264.695)")
    
    // MARK: - Gray
    static let twGray50 = Color(oklch: "oklch(98.5% 0 0)")
    static let twGray100 = Color(oklch: "oklch(96.7% 0.001 286.375)")
    static let twGray200 = Color(oklch: "oklch(92.8% 0.006 264.531)")
    static let twGray300 = Color(oklch: "oklch(87.2% 0.01 258.338)")
    static let twGray400 = Color(oklch: "oklch(70.7% 0.022 261.325)")
    static let twGray500 = Color(oklch: "oklch(55.1% 0.027 264.364)")
    static let twGray600 = Color(oklch: "oklch(44.6% 0.03 256.802)")
    static let twGray700 = Color(oklch: "oklch(37.3% 0.034 259.733)")
    static let twGray800 = Color(oklch: "oklch(27.8% 0.033 256.018)")
    static let twGray900 = Color(oklch: "oklch(21% 0.034 264.665)")
    static let twGray950 = Color(oklch: "oklch(13% 0.028 261.692)")
    
    // MARK: - Zinc
    static let twZinc50 = Color(oklch: "oklch(98.5% 0 0)")
    static let twZinc100 = Color(oklch: "oklch(96.7% 0.001 286.375)")
    static let twZinc200 = Color(oklch: "oklch(92.7% 0.006 264.531)")
    static let twZinc300 = Color(oklch: "oklch(87.1% 0.006 286.286)")
    static let twZinc400 = Color(oklch: "oklch(70.5% 0.015 286.067)")
    static let twZinc500 = Color(oklch: "oklch(55.2% 0.016 285.938)")
    static let twZinc600 = Color(oklch: "oklch(44.2% 0.017 285.786)")
    static let twZinc700 = Color(oklch: "oklch(36.6% 0.014 285.254)")
    static let twZinc800 = Color(oklch: "oklch(27.7% 0.01 285.751)")
    static let twZinc900 = Color(oklch: "oklch(21% 0.006 285.885)")
    static let twZinc950 = Color(oklch: "oklch(14.5% 0.004 285.938)")
    
    // MARK: - Neutral
    static let twNeutral50 = Color(oklch: "oklch(98.5% 0 0)")
    static let twNeutral100 = Color(oklch: "oklch(97% 0 0)")
    static let twNeutral200 = Color(oklch: "oklch(92.3% 0 0)")
    static let twNeutral300 = Color(oklch: "oklch(86.9% 0 0)")
    static let twNeutral400 = Color(oklch: "oklch(70.5% 0 0)")
    static let twNeutral500 = Color(oklch: "oklch(55.6% 0 0)")
    static let twNeutral600 = Color(oklch: "oklch(44.2% 0 0)")
    static let twNeutral700 = Color(oklch: "oklch(36.5% 0 0)")
    static let twNeutral800 = Color(oklch: "oklch(27.3% 0 0)")
    static let twNeutral900 = Color(oklch: "oklch(20.5% 0 0)")
    static let twNeutral950 = Color(oklch: "oklch(14% 0 0)")
    
    // MARK: - Stone
    static let twStone50 = Color(oklch: "oklch(98.5% 0.001 106.423)")
    static let twStone100 = Color(oklch: "oklch(97% 0.001 106.424)")
    static let twStone200 = Color(oklch: "oklch(92.3% 0.003 48.717)")
    static let twStone300 = Color(oklch: "oklch(86.9% 0.005 56.366)")
    static let twStone400 = Color(oklch: "oklch(70.9% 0.01 56.259)")
    static let twStone500 = Color(oklch: "oklch(55.3% 0.013 58.071)")
    static let twStone600 = Color(oklch: "oklch(44.4% 0.011 73.639)")
    static let twStone700 = Color(oklch: "oklch(37.4% 0.01 67.558)")
    static let twStone800 = Color(oklch: "oklch(26.8% 0.007 34.298)")
    static let twStone900 = Color(oklch: "oklch(21.6% 0.006 56.043)")
    static let twStone950 = Color(oklch: "oklch(14.7% 0.004 49.25)")
    
    // MARK: - Red
    static let twRed50 = Color(oklch: "oklch(97.1% 0.013 17.38)")
    static let twRed100 = Color(oklch: "oklch(93.6% 0.032 17.717)")
    static let twRed200 = Color(oklch: "oklch(88.5% 0.062 18.334)")
    static let twRed300 = Color(oklch: "oklch(80.8% 0.114 19.571)")
    static let twRed400 = Color(oklch: "oklch(70.4% 0.191 22.216)")
    static let twRed500 = Color(oklch: "oklch(63.7% 0.237 25.331)")
    static let twRed600 = Color(oklch: "oklch(57.7% 0.245 27.325)")
    static let twRed700 = Color(oklch: "oklch(50.5% 0.213 27.518)")
    static let twRed800 = Color(oklch: "oklch(44.4% 0.177 26.899)")
    static let twRed900 = Color(oklch: "oklch(39.6% 0.141 25.723)")
    static let twRed950 = Color(oklch: "oklch(25.8% 0.092 26.042)")
    
    // MARK: - Orange
    static let twOrange50 = Color(oklch: "oklch(98% 0.016 73.684)")
    static let twOrange100 = Color(oklch: "oklch(95.4% 0.038 75.164)")
    static let twOrange200 = Color(oklch: "oklch(90.1% 0.076 70.697)")
    static let twOrange300 = Color(oklch: "oklch(83.7% 0.128 66.29)")
    static let twOrange400 = Color(oklch: "oklch(75% 0.183 55.934)")
    static let twOrange500 = Color(oklch: "oklch(70.5% 0.213 47.604)")
    static let twOrange600 = Color(oklch: "oklch(64.6% 0.222 41.116)")
    static let twOrange700 = Color(oklch: "oklch(55.3% 0.195 38.402)")
    static let twOrange800 = Color(oklch: "oklch(47% 0.157 37.304)")
    static let twOrange900 = Color(oklch: "oklch(40.8% 0.123 38.172)")
    static let twOrange950 = Color(oklch: "oklch(26.6% 0.079 36.259)")
    
    // MARK: - Amber
    static let twAmber50 = Color(oklch: "oklch(98.7% 0.022 95.277)")
    static let twAmber100 = Color(oklch: "oklch(96.2% 0.059 95.617)")
    static let twAmber200 = Color(oklch: "oklch(92.4% 0.12 95.746)")
    static let twAmber300 = Color(oklch: "oklch(87.9% 0.169 91.605)")
    static let twAmber400 = Color(oklch: "oklch(82.8% 0.189 84.429)")
    static let twAmber500 = Color(oklch: "oklch(76.9% 0.188 70.08)")
    static let twAmber600 = Color(oklch: "oklch(66.6% 0.179 58.318)")
    static let twAmber700 = Color(oklch: "oklch(55.5% 0.163 48.998)")
    static let twAmber800 = Color(oklch: "oklch(47.3% 0.137 46.201)")
    static let twAmber900 = Color(oklch: "oklch(41.4% 0.112 45.904)")
    static let twAmber950 = Color(oklch: "oklch(27.9% 0.077 45.635)")
    
    // MARK: - Yellow
    static let twYellow50 = Color(oklch: "oklch(98.7% 0.026 102.212)")
    static let twYellow100 = Color(oklch: "oklch(97.3% 0.071 103.193)")
    static let twYellow200 = Color(oklch: "oklch(94.5% 0.129 101.54)")
    static let twYellow300 = Color(oklch: "oklch(90.5% 0.182 98.111)")
    static let twYellow400 = Color(oklch: "oklch(85.2% 0.199 91.936)")
    static let twYellow500 = Color(oklch: "oklch(79.5% 0.184 86.047)")
    static let twYellow600 = Color(oklch: "oklch(68.1% 0.162 75.834)")
    static let twYellow700 = Color(oklch: "oklch(55.4% 0.135 66.447)")
    static let twYellow800 = Color(oklch: "oklch(47.6% 0.114 61.907)")
    static let twYellow900 = Color(oklch: "oklch(42.1% 0.095 57.708)")
    static let twYellow950 = Color(oklch: "oklch(28.6% 0.066 53.813)")
    
    // MARK: - Lime
    static let twLime50 = Color(oklch: "oklch(98.6% 0.031 120.757)")
    static let twLime100 = Color(oklch: "oklch(96.7% 0.067 122.328)")
    static let twLime200 = Color(oklch: "oklch(93.8% 0.127 124.388)")
    static let twLime300 = Color(oklch: "oklch(89.7% 0.196 126.665)")
    static let twLime400 = Color(oklch: "oklch(84.1% 0.238 128.85)")
    static let twLime500 = Color(oklch: "oklch(76.8% 0.233 130.85)")
    static let twLime600 = Color(oklch: "oklch(64.8% 0.2 131.684)")
    static let twLime700 = Color(oklch: "oklch(53.2% 0.157 131.589)")
    static let twLime800 = Color(oklch: "oklch(45.3% 0.124 130.933)")
    static let twLime900 = Color(oklch: "oklch(40.5% 0.101 131.063)")
    static let twLime950 = Color(oklch: "oklch(27.4% 0.072 132.109)")
    
    // MARK: - Green
    static let twGreen50 = Color(oklch: "oklch(98.2% 0.018 155.826)")
    static let twGreen100 = Color(oklch: "oklch(96.2% 0.044 156.743)")
    static let twGreen200 = Color(oklch: "oklch(92.5% 0.084 155.995)")
    static let twGreen300 = Color(oklch: "oklch(87.1% 0.15 154.449)")
    static let twGreen400 = Color(oklch: "oklch(79.2% 0.209 151.711)")
    static let twGreen500 = Color(oklch: "oklch(72.3% 0.219 149.579)")
    static let twGreen600 = Color(oklch: "oklch(62.8% 0.173 149.214)")
    static let twGreen700 = Color(oklch: "oklch(52.7% 0.133 149.214)")
    static let twGreen800 = Color(oklch: "oklch(44.8% 0.111 149.579)")
    static let twGreen900 = Color(oklch: "oklch(39.3% 0.095 150.722)")
    static let twGreen950 = Color(oklch: "oklch(26.6% 0.065 152.934)")
    
    // MARK: - Emerald
    static let twEmerald50 = Color(oklch: "oklch(97.9% 0.021 166.113)")
    static let twEmerald100 = Color(oklch: "oklch(95% 0.052 163.051)")
    static let twEmerald200 = Color(oklch: "oklch(90.5% 0.093 164.15)")
    static let twEmerald300 = Color(oklch: "oklch(84.5% 0.143 164.978)")
    static let twEmerald400 = Color(oklch: "oklch(76.5% 0.177 163.223)")
    static let twEmerald500 = Color(oklch: "oklch(69.6% 0.17 162.48)")
    static let twEmerald600 = Color(oklch: "oklch(59.6% 0.145 163.225)")
    static let twEmerald700 = Color(oklch: "oklch(50.8% 0.118 165.612)")
    static let twEmerald800 = Color(oklch: "oklch(43.2% 0.095 166.913)")
    static let twEmerald900 = Color(oklch: "oklch(37.8% 0.077 168.94)")
    static let twEmerald950 = Color(oklch: "oklch(26.2% 0.051 172.552)")
    
    // MARK: - Teal
    static let twTeal50 = Color(oklch: "oklch(98.4% 0.014 180.72)")
    static let twTeal100 = Color(oklch: "oklch(95.3% 0.051 180.801)")
    static let twTeal200 = Color(oklch: "oklch(91% 0.096 180.426)")
    static let twTeal300 = Color(oklch: "oklch(85.5% 0.138 181.071)")
    static let twTeal400 = Color(oklch: "oklch(77.7% 0.152 181.912)")
    static let twTeal500 = Color(oklch: "oklch(70.4% 0.14 182.503)")
    static let twTeal600 = Color(oklch: "oklch(60% 0.118 184.704)")
    static let twTeal700 = Color(oklch: "oklch(51.1% 0.096 186.391)")
    static let twTeal800 = Color(oklch: "oklch(43.7% 0.081 186.974)")
    static let twTeal900 = Color(oklch: "oklch(38.6% 0.063 188.416)")
    static let twTeal950 = Color(oklch: "oklch(27.7% 0.046 192.524)")
    
    // MARK: - Cyan
    static let twCyan50 = Color(oklch: "oklch(98.4% 0.019 200.873)")
    static let twCyan100 = Color(oklch: "oklch(95.6% 0.045 203.388)")
    static let twCyan200 = Color(oklch: "oklch(91.7% 0.08 205.041)")
    static let twCyan300 = Color(oklch: "oklch(86.5% 0.127 207.16)")
    static let twCyan400 = Color(oklch: "oklch(78.9% 0.154 211.53)")
    static let twCyan500 = Color(oklch: "oklch(71.5% 0.143 215.221)")
    static let twCyan600 = Color(oklch: "oklch(60.9% 0.126 221.723)")
    static let twCyan700 = Color(oklch: "oklch(52% 0.105 223.128)")
    static let twCyan800 = Color(oklch: "oklch(45% 0.085 224.283)")
    static let twCyan900 = Color(oklch: "oklch(39.8% 0.07 227.392)")
    static let twCyan950 = Color(oklch: "oklch(29.3% 0.05 227.392)")
    
    // MARK: - Sky
    static let twSky50 = Color(oklch: "oklch(97.7% 0.013 236.62)")
    static let twSky100 = Color(oklch: "oklch(95.1% 0.026 236.824)")
    static let twSky200 = Color(oklch: "oklch(90.1% 0.058 239.059)")
    static let twSky300 = Color(oklch: "oklch(82.8% 0.111 241.688)")
    static let twSky400 = Color(oklch: "oklch(74.6% 0.16 242.435)")
    static let twSky500 = Color(oklch: "oklch(65.6% 0.136 246.377)")
    static let twSky600 = Color(oklch: "oklch(57.5% 0.141 248.807)")
    static let twSky700 = Color(oklch: "oklch(49.2% 0.13 250.771)")
    static let twSky800 = Color(oklch: "oklch(42.5% 0.114 251.789)")
    static let twSky900 = Color(oklch: "oklch(37.4% 0.093 253.298)")
    static let twSky950 = Color(oklch: "oklch(26% 0.062 254.195)")
    
    // MARK: - Blue
    static let twBlue50 = Color(oklch: "oklch(97% 0.014 254.604)")
    static let twBlue100 = Color(oklch: "oklch(93.2% 0.032 255.585)")
    static let twBlue200 = Color(oklch: "oklch(88.2% 0.059 254.128)")
    static let twBlue300 = Color(oklch: "oklch(80.9% 0.105 251.813)")
    static let twBlue400 = Color(oklch: "oklch(70.7% 0.165 254.639)")
    static let twBlue500 = Color(oklch: "oklch(62.3% 0.174 254.604)")
    static let twBlue600 = Color(oklch: "oklch(54.6% 0.185 254.604)")
    static let twBlue700 = Color(oklch: "oklch(47.2% 0.171 255.517)")
    static let twBlue800 = Color(oklch: "oklch(40.5% 0.15 256.417)")
    static let twBlue900 = Color(oklch: "oklch(35.3% 0.121 256.347)")
    static let twBlue950 = Color(oklch: "oklch(23.9% 0.081 256.429)")
    
    // MARK: - Indigo
    static let twIndigo50 = Color(oklch: "oklch(96.2% 0.018 272.314)")
    static let twIndigo100 = Color(oklch: "oklch(93% 0.034 272.788)")
    static let twIndigo200 = Color(oklch: "oklch(87% 0.065 274.039)")
    static let twIndigo300 = Color(oklch: "oklch(78.5% 0.115 274.713)")
    static let twIndigo400 = Color(oklch: "oklch(67.3% 0.182 276.935)")
    static let twIndigo500 = Color(oklch: "oklch(58.5% 0.233 277.117)")
    static let twIndigo600 = Color(oklch: "oklch(51.1% 0.262 276.966)")
    static let twIndigo700 = Color(oklch: "oklch(45.7% 0.24 277.023)")
    static let twIndigo800 = Color(oklch: "oklch(39.8% 0.195 277.366)")
    static let twIndigo900 = Color(oklch: "oklch(35.9% 0.144 278.697)")
    static let twIndigo950 = Color(oklch: "oklch(25.7% 0.09 281.288)")
    
    // MARK: - Violet
    static let twViolet50 = Color(oklch: "oklch(96.9% 0.016 293.756)")
    static let twViolet100 = Color(oklch: "oklch(94.3% 0.029 294.588)")
    static let twViolet200 = Color(oklch: "oklch(89.4% 0.057 293.283)")
    static let twViolet300 = Color(oklch: "oklch(81.1% 0.111 293.571)")
    static let twViolet400 = Color(oklch: "oklch(70.2% 0.183 293.541)")
    static let twViolet500 = Color(oklch: "oklch(60.6% 0.25 292.717)")
    static let twViolet600 = Color(oklch: "oklch(54.1% 0.281 293.009)")
    static let twViolet700 = Color(oklch: "oklch(49.1% 0.27 292.581)")
    static let twViolet800 = Color(oklch: "oklch(43.2% 0.232 292.759)")
    static let twViolet900 = Color(oklch: "oklch(38% 0.189 293.745)")
    static let twViolet950 = Color(oklch: "oklch(28.3% 0.141 291.089)")
    
    // MARK: - Purple
    static let twPurple50 = Color(oklch: "oklch(97.7% 0.014 308.299)")
    static let twPurple100 = Color(oklch: "oklch(94.6% 0.033 307.174)")
    static let twPurple200 = Color(oklch: "oklch(90.2% 0.063 306.703)")
    static let twPurple300 = Color(oklch: "oklch(82.7% 0.119 306.383)")
    static let twPurple400 = Color(oklch: "oklch(71.4% 0.203 305.504)")
    static let twPurple500 = Color(oklch: "oklch(62.7% 0.265 303.9)")
    static let twPurple600 = Color(oklch: "oklch(55.8% 0.288 302.321)")
    static let twPurple700 = Color(oklch: "oklch(49.6% 0.265 301.924)")
    static let twPurple800 = Color(oklch: "oklch(43.8% 0.218 303.724)")
    static let twPurple900 = Color(oklch: "oklch(38.1% 0.176 304.987)")
    static let twPurple950 = Color(oklch: "oklch(28.2% 0.125 304.577)")
    
    // MARK: - Fuchsia
    static let twFuchsia50 = Color(oklch: "oklch(97.7% 0.017 322.284)")
    static let twFuchsia100 = Color(oklch: "oklch(95.2% 0.038 322.284)")
    static let twFuchsia200 = Color(oklch: "oklch(90.7% 0.076 322.284)")
    static let twFuchsia300 = Color(oklch: "oklch(83.6% 0.137 322.284)")
    static let twFuchsia400 = Color(oklch: "oklch(74% 0.22 322.284)")
    static let twFuchsia500 = Color(oklch: "oklch(66.7% 0.272 322.284)")
    static let twFuchsia600 = Color(oklch: "oklch(59.5% 0.284 322.284)")
    static let twFuchsia700 = Color(oklch: "oklch(52.2% 0.252 322.284)")
    static let twFuchsia800 = Color(oklch: "oklch(45.5% 0.204 322.284)")
    static let twFuchsia900 = Color(oklch: "oklch(39.8% 0.16 322.284)")
    static let twFuchsia950 = Color(oklch: "oklch(28.4% 0.108 322.284)")
    
    // MARK: - Pink
    static let twPink50 = Color(oklch: "oklch(97.1% 0.014 343.198)")
    static let twPink100 = Color(oklch: "oklch(94.8% 0.031 343.198)")
    static let twPink200 = Color(oklch: "oklch(89.9% 0.061 343.198)")
    static let twPink300 = Color(oklch: "oklch(82.3% 0.12 346.018)")
    static let twPink400 = Color(oklch: "oklch(71.8% 0.202 349.761)")
    static let twPink500 = Color(oklch: "oklch(65.6% 0.241 354.308)")
    static let twPink600 = Color(oklch: "oklch(59.2% 0.249 358.467)")
    static let twPink700 = Color(oklch: "oklch(52.5% 0.223 3.958)")
    static let twPink800 = Color(oklch: "oklch(45.9% 0.187 3.815)")
    static let twPink900 = Color(oklch: "oklch(40.8% 0.153 2.432)")
    static let twPink950 = Color(oklch: "oklch(28.4% 0.109 3.034)")
    
    // MARK: - Rose
    static let twRose50 = Color(oklch: "oklch(96.9% 0.015 12.422)")
    static let twRose100 = Color(oklch: "oklch(94.1% 0.03 12.58)")
    static let twRose200 = Color(oklch: "oklch(89.2% 0.058 10.001)")
    static let twRose300 = Color(oklch: "oklch(81% 0.117 11.638)")
    static let twRose400 = Color(oklch: "oklch(71.2% 0.194 13.428)")
    static let twRose500 = Color(oklch: "oklch(64.5% 0.246 16.439)")
    static let twRose600 = Color(oklch: "oklch(58.6% 0.253 17.585)")
    static let twRose700 = Color(oklch: "oklch(51.4% 0.222 16.935)")
    static let twRose800 = Color(oklch: "oklch(45.5% 0.188 13.697)")
    static let twRose900 = Color(oklch: "oklch(40.6% 0.154 11.076)")
    static let twRose950 = Color(oklch: "oklch(27.1% 0.105 12.094)")
    
    // MARK: - Mauve
    static let twMauve50 = Color(oklch: "oklch(98.5% 0 0)")
    static let twMauve100 = Color(oklch: "oklch(96% 0.003 325.6)")
    static let twMauve200 = Color(oklch: "oklch(92.2% 0.005 325.62)")
    static let twMauve300 = Color(oklch: "oklch(86.5% 0.012 325.68)")
    static let twMauve400 = Color(oklch: "oklch(71.1% 0.019 323.02)")
    static let twMauve500 = Color(oklch: "oklch(54.2% 0.034 322.5)")
    static let twMauve600 = Color(oklch: "oklch(43.5% 0.029 321.78)")
    static let twMauve700 = Color(oklch: "oklch(36.4% 0.029 323.89)")
    static let twMauve800 = Color(oklch: "oklch(26.3% 0.024 320.12)")
    static let twMauve900 = Color(oklch: "oklch(21.2% 0.019 322.12)")
    static let twMauve950 = Color(oklch: "oklch(14.5% 0.008 326)")

    // MARK: - Olive
    static let twOlive50 = Color(oklch: "oklch(98.8% 0.003 106.5)")
    static let twOlive100 = Color(oklch: "oklch(96.6% 0.005 106.5)")
    static let twOlive200 = Color(oklch: "oklch(93% 0.007 106.5)")
    static let twOlive300 = Color(oklch: "oklch(88% 0.011 106.6)")
    static let twOlive400 = Color(oklch: "oklch(73.7% 0.021 106.9)")
    static let twOlive500 = Color(oklch: "oklch(58% 0.031 107.3)")
    static let twOlive600 = Color(oklch: "oklch(46.6% 0.025 107.3)")
    static let twOlive700 = Color(oklch: "oklch(39.4% 0.023 107.4)")
    static let twOlive800 = Color(oklch: "oklch(28.6% 0.016 107.4)")
    static let twOlive900 = Color(oklch: "oklch(22.8% 0.013 107.4)")
    static let twOlive950 = Color(oklch: "oklch(15.3% 0.006 107.1)")

    // MARK: - Mist
    static let twMist50 = Color(oklch: "oklch(98.7% 0.002 197.1)")
    static let twMist100 = Color(oklch: "oklch(96.3% 0.002 197.1)")
    static let twMist200 = Color(oklch: "oklch(92.5% 0.005 214.3)")
    static let twMist300 = Color(oklch: "oklch(87.2% 0.007 219.6)")
    static let twMist400 = Color(oklch: "oklch(72.3% 0.014 214.4)")
    static let twMist500 = Color(oklch: "oklch(56% 0.021 213.5)")
    static let twMist600 = Color(oklch: "oklch(45% 0.017 213.2)")
    static let twMist700 = Color(oklch: "oklch(37.8% 0.015 216)")
    static let twMist800 = Color(oklch: "oklch(27.5% 0.011 216.9)")
    static let twMist900 = Color(oklch: "oklch(21.8% 0.008 223.9)")
    static let twMist950 = Color(oklch: "oklch(14.8% 0.004 228.8)")

    // MARK: - Taupe
    static let twTaupe50 = Color(oklch: "oklch(98.6% 0.002 67.8)")
    static let twTaupe100 = Color(oklch: "oklch(96% 0.002 17.2)")
    static let twTaupe200 = Color(oklch: "oklch(92.2% 0.005 34.3)")
    static let twTaupe300 = Color(oklch: "oklch(86.8% 0.007 39.5)")
    static let twTaupe400 = Color(oklch: "oklch(71.4% 0.014 41.2)")
    static let twTaupe500 = Color(oklch: "oklch(54.7% 0.021 43.1)")
    static let twTaupe600 = Color(oklch: "oklch(43.8% 0.017 39.3)")
    static let twTaupe700 = Color(oklch: "oklch(36.7% 0.016 35.7)")
    static let twTaupe800 = Color(oklch: "oklch(26.8% 0.011 36.5)")
    static let twTaupe900 = Color(oklch: "oklch(21.4% 0.009 43.1)")
    static let twTaupe950 = Color(oklch: "oklch(14.7% 0.004 49.3)")
}
