import Testing
@testable import FADBADSwift

func equation1(x: T, y: T) -> T {
    let z = sqrt(x)
    return y * z + sin(z)
}

@Test func testExample() async throws {
    let x = T(1.0)
    let y = T(2.0)
    
    x[1] = 1
    
    let f = equation1(x: x, y: y)
    
    f.evaluate(to: 10)
    
    for i in 0...10 {
        print("(1/k!)*(d^\(i)f/dx^\(i))=\(f[i])")
    }
}
