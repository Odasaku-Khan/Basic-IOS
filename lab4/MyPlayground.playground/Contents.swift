// =============================================================
//  Station ALMA-7, Part II: The Teleporter Incident
//  iOS Mobile Development · Module 4 · Lab Assignment
//
//  How to use:
//   • Xcode: File → New → Playground → Blank, replace everything
//     with this file's contents.
//   • Terminal: swift ALMA7_Part2_Starter.swift
//
//  Rules:
//   • Do NOT modify the STARTER DATA section.
//   • `!` (force unwrap) is forbidden: −0.5 points each.
//   • No map / filter / reduce / compactMap.
//   • Default to struct. Use class only where the task says so.
// =============================================================


// MARK: - =================== STARTER DATA ===================
// MARK: - Do not modify anything in this section

/// Splits a line into fields.
/// fields("crate:101:120")            -> ["crate", "101", "120"]
/// fields("livestock:lab mice:12:2")  -> ["livestock", "lab mice", "12", "2"]
/// fields("junk")                     -> ["junk"]
func fields(_ line: String, separatedBy separator: Character = ":") -> [String] {
    var result: [String] = []
    var current = ""
    for character in line {
        if character == separator {
            result.append(current)
            current = ""
        } else {
            current.append(character)
        }
    }
    result.append(current)
    return result
}

/// Cargo manifest as recovered from the damaged recorder.
let rawManifest = [
    "crate:101:120",
    "container:KZ-ALM-7:340",
    "livestock:lab mice:12:2",
    "???-corrupted-line",
    "crate:102:75",
    "container:KZ-ALM-9:410",
    "livestock:ficus:3:5",
    "crate:103:260",
    "crate:104:abc",
    ""
]

/// Oxygen readings. One of these deck names is not a real deck.
let deckReadings: [(deck: String, oxygen: Int)] = [
    (deck: "bridge",     oxygen: 78),
    (deck: "lab",        oxygen: 64),
    (deck: "greenhouse", oxygen: 55),
    (deck: "cargo",      oxygen: 12),
    (deck: "medbay",     oxygen: 90),
    (deck: "engine",     oxygen: 41)
]

/// Crew records, straight from the personnel file.
let crewData: [(name: String, deck: String, oxygen: Int)] = [
    (name: "Timur",   deck: "engine", oxygen: 62),
    (name: "Dana",    deck: "lab",    oxygen: 48),
    (name: "Aigerim", deck: "bridge", oxygen: 91),
    (name: "Nurlan",  deck: "cargo",  oxygen: 17)
]

print("ALMA-7 recorder online: \(rawManifest.count) manifest lines, \(deckReadings.count) readings, \(crewData.count) crew records.")

// MARK: - ================= END OF STARTER DATA =================


// MARK: - =================== YOUR SOLUTION ===================


// MARK: Level 1 · The Deck Register

// 1.1
enum Deck: String, CaseIterable {
    case bridge
    case lab
    case cargo
    case medbay
    case engine
    var evacuationPriority: Int {
        switch self {
        case .bridge:
            return 1
        case .medbay:
            return 2
        case .lab:
            return 3
        case .engine:
            return 4
        case.cargo:
            return 5
        }
    }
}
for deck in Deck.allCases{
    print(deck,deck.evacuationPriority)
}


// 1.2
enum AlarmLevel: Int {
    case green = 0
    case yellow
    case orange
    case red
    
    static func level(forTotalMass mass: Int ) -> AlarmLevel {
        if mass < 0 {
            fatalError("mass cant be negative even in no gravity space")
        }
        var step:Int = mass / 500
        step = min(step,3)
        guard let level = AlarmLevel(rawValue: step) else {
            fatalError("invalid rawValue")
        }
        return level
    }
}
AlarmLevel.level(forTotalMass: 0)
AlarmLevel.level(forTotalMass: 7000)
//AlarmLevel.level(forTotalMass: -200)



// MARK: Level 2 · The Manifest

// 2.1
enum ManifestEntry {
    case crate(id: Int, massKg: Int)
    case container(code: String, massKg: Int)
    case livestock(species: String, count: Int, massPerUnitKg: Int)
    case unknown(raw: String)
}

// 2.2
func parseEntry(_ line: String) -> ManifestEntry {
    var field: [String] = []
    field = fields(line)
    if field.isEmpty {
        return .unknown(raw: line)
    }
    switch field[0]{
    case "crate":
        guard field.count == 3,
              let id = Int(field[1]),
              let mass = Int(field[2]) else {
            return .unknown(raw: line)
        }
        return .crate(id: id, massKg: mass)
    case "container":
        guard field.count == 3,
              let masKg = Int(field[2]) else {
            return .unknown(raw: line)
        }
        return .container(code: field[1], massKg: masKg)
    case "livestock":
        guard field.count == 4,
              let count = Int(field[2]),
              let massPerUnitKg = Int(field[3]) else {
            return .unknown(raw: line)
        }
        return .livestock(species: field[1], count: count, massPerUnitKg: massPerUnitKg)
    default:
        return .unknown(raw: line)
    }

}

// 2.3
func mass(of entry: ManifestEntry) -> Int {
    switch entry{
    case .crate(_, let massKg):
        return massKg
    case .container(_ , let massKg):
        return massKg
    case .livestock(_ ,let count,let massPerUnitKg ):
        return count * massPerUnitKg
    default :
        return 0
        //how it can be 0
    }
    
}
var sum = 0
var count = 0
for line in rawManifest {
    let field = parseEntry(line)
    let mas = mass(of: field)
    sum = sum + mas
    //if mas == 0 {
     //   count += 1
//    }
    if case.unknown(_ ) = field {
        count += 1
    }
}
print ("There \(count) amount of unknown lines ")
let A = sum


// MARK: Level 3 · Crew Snapshots

// 3.1
struct CrewSnapshot {
    let name: String
    var deck: Deck
    var oxygen: Int
    mutating func breathe(_ amount:Int){
        if oxygen < amount {
            //I hope there will not be weird -10 oxygen or similar shinanigans
            oxygen = 0
        }else{
            oxygen = oxygen-amount
        }
    }
    mutating func move(to deck:Deck){
        self.deck = deck
    }
    mutating func reviveInMedbay(){
        self = CrewSnapshot(name: self.name, deck: .medbay, oxygen: self.oxygen)
    }
    static func rookie(named name:String) -> CrewSnapshot {
        return CrewSnapshot(name: name, deck: .bridge, oxygen: 100)
    }
}

// 3.2
var crewRoster: [CrewSnapshot] = []
for record in crewData {
    guard let deck = Deck(rawValue: record.deck) else{
        print ("Warning ther is error for deck info \(record.deck) not exist")
        continue
    }
    crewRoster.append(CrewSnapshot(name: record.name, deck: deck, oxygen: record.oxygen))
}

// 3.3 · Value-semantics demonstration (copy / plain parameter / inout)
var orig = crewRoster[0]
print (orig.name,"has \(orig.oxygen) oxygen")
var cop = orig
cop.oxygen=95
print (cop.name,"Now he has \(cop.oxygen) oxygen")

func unchange(data: CrewSnapshot) -> String {
    var copy = data
    copy.oxygen=76
    return ("copy changed and printed \(copy.oxygen) ")
}
print(unchange(data: crewRoster[2]),"Now the orig value \(crewRoster[2].oxygen)")

func change(data: inout CrewSnapshot) -> String{
    data.oxygen = 99
    return ("changed and printed \(data.oxygen) ")
}
print(change(data: &crewRoster[3]),"Now the orig value changed too \(crewRoster[3].oxygen)")




// MARK: Level 4 · The Teleport Pod

// 4.1
final class TeleportPod {
    let id: String
    var chargelevel: Int
    var occupant: CrewSnapshot?
    
    init(id: String, chargelevel: Int) {
        self.id = id
        self.chargelevel = chargelevel
        self.occupant = nil
    }
    func load(_ crew: CrewSnapshot) -> Bool{
        if occupant != nil || chargelevel<20{
            return false
        }else{
            occupant = crew
            return true
        }
    }

    
    func fire() -> CrewSnapshot? {
        guard let load = occupant else{
            return nil
        }
        chargelevel = chargelevel-20
        occupant = nil
        return load
    }
}

// 4.2 · Charge ledger: load+fire three times, then fire an empty pod
let pod1 = TeleportPod(id: "P-1", chargelevel: 100)
pod1.load(crewRoster[0])
pod1.fire()
pod1.load(crewRoster[1])
pod1.fire()
pod1.load(crewRoster[3])
pod1.fire()
pod1.fire()
let C = pod1.chargelevel
// 4.3 · Reference-semantics demonstration

var pod2 = pod1
pod2.chargelevel=100
print ("First \(pod1.chargelevel) , Second \(pod2.chargelevel)")
var crew1 = crewRoster[0]
var crew2 = crew1
crew2.deck = .cargo
print ("First unchanged deck \(crew1.deck), Second changed deck \(crew2.deck)")
//CrewSnapshot is a struct, so crew2 is an independent copy. Changing crew2.deck leaves crew1.deck unchanged

// MARK: Level 5 · Station Systems

// 5.1
final class Station {
    let callSign: String
    var hullIntegrity: Int {
        willSet {
            print ("\(hullIntegrity) -> \(newValue)")
        }
        didSet{
            hullIntegrity = min(max(hullIntegrity, 0), 100)
        }
    }
    var oxygenByDeck: [Deck: Int]
    
    lazy var fullDiagnostics: String = {
            print("Running full scan...")
            return """
            Station: \(callSign)
            Hull: \(hullIntegrity)
            Total oxygen: \(totalOxygen)
            Average oxygen: \(averageOxygen)
            """
        }()
    
    var totalOxygen: Int {
        var sum=0
        for deck in oxygenByDeck.values {
            sum = sum + deck
        }
        return sum
    }
    var averageOxygen: Int {
        get {
            totalOxygen/oxygenByDeck.count
        }
        set {
            for deck in oxygenByDeck.keys {
                oxygenByDeck[deck] = newValue
            }
        }
    }
    init(callSign: String, hullIntegrity: Int) {
        self.callSign = callSign
        self.hullIntegrity = hullIntegrity
        self.oxygenByDeck = [:]
        
        for reading in deckReadings {
            if let deck = Deck(rawValue: reading.deck){
                self.oxygenByDeck[deck] = reading.oxygen
            }
        }
    }
}
let station = Station(callSign: "ALMA-7", hullIntegrity: 80)

let B = station.averageOxygen

// 5.2 · The clamp trap: 130, then -40, then 55
var station1 = Station(callSign: "ALMA-7", hullIntegrity: 80)
station1.hullIntegrity = 130
print (station1.hullIntegrity)
station1.hullIntegrity = -40
print (station1.hullIntegrity)
station1.hullIntegrity = 55
print (station1.hullIntegrity)

// MARK: Level 6 · Incident Reports
// Three of these compile and are wrong. One does not compile.
// For each: expectation, actual behaviour, the language rule, the fix.


// Report 1
var roster = crewRoster
var modified :[CrewSnapshot] = []
for var member in roster {
    member.oxygen -= 10
    modified.append(member)
}
print(modified[0].oxygen)   // author expected the crew to have lost oxygen


// Report 2
let podA = TeleportPod(id: "A", chargelevel: 100)
let podB = podA
podB.chargelevel = 0
print(podA.chargelevel)   // author expected 100
//impossible
// Report 3
struct Logbook {
    var entries: [String] = []
    mutating func add(_ entry: String) {
        entries.append(entry)
    }
}

// Report 4
var snapshot = CrewSnapshot.rookie(named: "Dana")
snapshot.oxygen = 40

let pod = TeleportPod(id: "B", chargelevel: 50)
pod.chargelevel = 10



// MARK: Level 7 · Sealing the Black Box

// The leaky original:
//
final class FlightRecorder {
     private var entries: [String] = []
     private(set) var isSealed = false
    func add(_ entry: String) {
            if isSealed {
                print("Recorder is sealed. Entry not added.")
                return
            }
            entries.append(entry)
        }
    func seal() {
            isSealed = true
        }
    var entryCount: Int {
           entries.count
       }

       var transcript: String {
           var result = ""

           for entry in entries {
               result += entry + "\n"
           }

           return result
       }
    fileprivate func auditData() -> String {
            return "Entries: \(entries.count), Sealed: \(isSealed)"
        }
 }
func auditTranscript(of recorder: FlightRecorder) -> String {
    return recorder.auditData()
}
//
// Your sealed version below. One comment per access keyword.

// final class FlightRecorder { }

// A free function elsewhere in the file that uses your fileprivate helper:
// func auditTranscript(of recorder: FlightRecorder) -> String { }


// MARK: Finale · Integrity Code

let D = AlarmLevel.level(forTotalMass: A).rawValue
let integrityCode = "\(A)-\(B)-\(C)-\(D)"
print("INTEGRITY CODE: \(integrityCode)")


// MARK: Bonus

final class TeleportPod1 {
    let id: String
    var chargeLevel: Int
    var occupant: CrewSnapshot?

    init(id: String, chargeLevel: Int) {
        self.id = id
        self.chargeLevel = chargeLevel
        self.occupant = nil
    }

    func load(_ crew: CrewSnapshot) -> Bool {
        if occupant != nil || chargeLevel < 20 {
            return false
        }

        occupant = crew
        return true
    }

    func fire() -> CrewSnapshot? {
        guard let loaded = occupant else {
            return nil
        }

        chargeLevel -= 20
        occupant = nil
        return loaded
    }

    deinit {
        print("TeleportPod \(id) deinitialized")
    }
}
// MARK: - ================= DEFENSE QUESTIONS =================
/*
 1. Why did CrewSnapshot get an initializer for free and TeleportPod did not?

 2. What does `mutating` do to self, and why do classes never need it?

 3. In Report 4 both values are `let`. What exactly does `let` freeze for a
    struct, and what does it freeze for a class?

 4. Why must a lazy property be var? When does lazy change behaviour, not
    just performance?

 5. private vs fileprivate: where in your FlightRecorder would private be
    too strict?

 Bonus. On which line does deinit fire, and why can't === be used on
 CrewSnapshot?

*/
