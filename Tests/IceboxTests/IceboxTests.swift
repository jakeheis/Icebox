import Icebox
import PathKit
import XCTest

final class IceboxTests: XCTestCase {
    
    func testRun() throws {
        let catbox = CatIcebox(template: .simple)
        let result = catbox.run("file.txt", timeout: 2)
        XCTAssertEqual(result.exitStatus, 0)
        XCTAssertEqual(result.stdout, "hello\n")
    }
    
    func testCreateFile() throws {
        let file: Path = "myFile"
        let contents = "hello there"
        let catbox = CatIcebox(template: .simple)
        
        XCTAssertFalse(catbox.fileExists(file))
        
        catbox.createFile(path: file, contents: contents)
        
        let result = catbox.run(file.string)
        
        XCTAssertEqual(result.exitStatus, 0)
        XCTAssertEqual(result.stdout, contents)
        XCTAssertEqual(catbox.fileContents("myFile"), contents)
        XCTAssertTrue(catbox.fileExists(file))
    }
    
    func testInside() {
        let catbox = CatIcebox(template: .simple)
        
        catbox.inside {
            XCTAssertEqual(try? Path("file.txt").read(), "hello\n")
        }
    }
    
    static var allTests = [
        ("testRun", testRun),
        ("testCreateFile", testCreateFile),
        ("testInside", testInside),
    ]
}

class CatConfig: IceboxConfig {
    
    enum Templates: String {
        case simple
        case lib
    }
    
    static let executable = "/bin/cat"
    
}

typealias CatIcebox = Icebox<CatConfig>
