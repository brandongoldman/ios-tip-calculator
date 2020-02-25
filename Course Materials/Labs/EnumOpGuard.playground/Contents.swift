enum NumError : Error {
    case tooBig, tooSmall, other
}

enum NumCode : Int {
    case zero, one, two, three
}

func convertToCode(val : Int) throws -> NumCode {
    guard val < 4 else { throw NumError.tooBig }
    
    if let result = NumCode.init(rawValue: val) {
        return result
    }

    if val < NumCode.zero.rawValue {
        throw NumError.tooSmall
    }

    throw NumError.other
}

print ((try? convertToCode(val: 2)) ?? "failed")
do {
    try convertToCode(val: 6)
}
catch {
    print (error)
}
