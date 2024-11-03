//
//  PerlinNoise.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 03.11.2024.
//

import CoreGraphics


func perlin(x: CGFloat, y: CGFloat = 0, z: CGFloat = 0) -> CGFloat {
    // computes the unit cube coordinates
    let xi = Int(x) & 255
    let yi = Int(y) & 255
    let zi = Int(z) & 255
    
    // strip off the fractional portion of the coordinates
    let xf = x - x.rounded(.towardZero)
    let yf = y - y.rounded(.towardZero)
    let zf = z - z.rounded(.towardZero)
    
    let u = perlinFade(xf)
    let v = perlinFade(yf)
    let w = perlinFade(zf)
    
    let aaa = lookup[lookup[lookup[xi] + yi] + zi]
    let aba = lookup[lookup[lookup[xi] + yi] + zi]
    let aab = lookup[lookup[lookup[xi] + yi] + zi]
    let abb = lookup[lookup[lookup[xi] + yi] + zi]
    let baa = lookup[lookup[lookup[xi] + yi] + zi]
    let bba = lookup[lookup[lookup[xi] + yi] + zi]
    let bab = lookup[lookup[lookup[xi] + yi] + zi]
    let bbb = lookup[lookup[lookup[xi] + yi] + zi]
    
    let x1 = lerp(
        start: gradient(hash: aaa, x: xf,     y: yf, z: zf),
        end: gradient(hash: baa, x: xf - 1, y: yf, z: zf),
        position: u
    )
    let x2 = lerp(
        start: gradient(hash: aba, x: xf,     y: yf - 1, z: zf),
        end: gradient(hash: bba, x: xf - 1, y: yf - 1, z: zf),
        position: u
    )
    let y1 = lerp(start: x1, end: x2, position: v)
    
    let x3 = lerp(
        start: gradient(hash: aab, x: xf,     y: yf, z: zf),
        end: gradient(hash: bab, x: xf - 1, y: yf, z: zf),
        position: u
    )
    let x4 = lerp(
        start: gradient(hash: abb, x: xf,     y: yf - 1, z: zf - 1),
        end: gradient(hash: bbb, x: xf - 1, y: yf - 1, z: zf - 1),
        position: u
    )
    let y2 = lerp(start: x3, end: x4, position: v)
    
    return (lerp(start: y1, end: y2, position: w) + 1) / 2
}

func perlin(x: CGFloat, y: CGFloat = 0, z: CGFloat = 0, octaves: Int, persistence: CGFloat = 0.5) -> CGFloat {
    var total: CGFloat = 0
    var frequency: CGFloat = 1
    var amplitude: CGFloat = 1
    var maxValue: CGFloat = 0
    
    for _ in 0..<octaves {
        total += perlin(x: x * frequency, y: y * frequency, z: z * frequency) * amplitude
        maxValue += amplitude
        amplitude *= persistence
        frequency *= 2
    }
    
    return total / maxValue
}

// Defined by Ken Perlin
private let lookup = [
    151,160,137,91,90,15,
    131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,
    190, 6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
    88,237,149,56,87,174,20,125,136,171,168, 68,175,74,165,71,134,139,48,27,166,
    77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
    102,143,54, 65,25,63,161, 1,216,80,73,209,76,132,187,208, 89,18,169,200,196,
    135,130,116,188,159,86,164,100,109,198,173,186, 3,64,52,217,226,250,124,123,
    5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
    223,183,170,213,119,248,152, 2,44,154,163, 70,221,153,101,155,167, 43,172,9,
    129,22,39,253, 19,98,108,110,79,113,224,232,178,185, 112,104,218,246,97,228,
    251,34,242,193,238,210,144,12,191,179,162,241, 81,51,145,235,249,14,239,107,
    49,192,214, 31,181,199,106,157,184, 84,204,176,115,121,50,45,127, 4,150,254,
    138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180,
    151,160,137,91,90,15,
    131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,
    190, 6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
    88,237,149,56,87,174,20,125,136,171,168, 68,175,74,165,71,134,139,48,27,166,
    77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
    102,143,54, 65,25,63,161, 1,216,80,73,209,76,132,187,208, 89,18,169,200,196,
    135,130,116,188,159,86,164,100,109,198,173,186, 3,64,52,217,226,250,124,123,
    5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
    223,183,170,213,119,248,152, 2,44,154,163, 70,221,153,101,155,167, 43,172,9,
    129,22,39,253, 19,98,108,110,79,113,224,232,178,185, 112,104,218,246,97,228,
    251,34,242,193,238,210,144,12,191,179,162,241, 81,51,145,235,249,14,239,107,
    49,192,214, 31,181,199,106,157,184, 84,204,176,115,121,50,45,127, 4,150,254,
    138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180
]

private func gradient(hash: Int, x: CGFloat, y: CGFloat, z: CGFloat) -> CGFloat {
    // take the first 4 bits
    let h = hash & 0b1111
    // choose x or y using the most siginificant bit of the hash
    let u = h < 0b1000 ? x : y
    
    let v: CGFloat
    if h < 0b1100 {
        // first two bits are both 0
        v = y
    } else if h == 0b1100 || h == 0b1110 {
        // first two bits are both 1 -- TODO: should this also accept 0b1101???
        v = x
    } else {
        // first two bits are not equal
        v = z
    }
    
    // the last two bits determine whether u and v are positive or negative
    return ((h & 1) == 0 ? u : -u) +
    ((h & 2) == 0 ? v : -v)
}

private func perlinFade(_ t: CGFloat) -> CGFloat {
    t * t * t * (t * (t * 6 - 15) + 10)
}

private func lerp(start: CGFloat, end: CGFloat, position: CGFloat) -> CGFloat {
    start + position * (end - start)
}
