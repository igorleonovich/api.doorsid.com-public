import Foundation

let file = "plan.md" //this is the file. we will write to and read from it

struct MarkdownPoint {
    let text: String
    
    var markdownRepresentation: String {
        return "* \(text)"
    }
}

let markdownPointPlan = MarkdownPoint(text: "Plan")
let markdownPointCurrentPlan = MarkdownPoint(text: "Current Plan")

if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

    let fileURL = dir.appendingPathComponent(file)

    //writing
    do {
        try markdownPointPlan.text.write(to: fileURL, atomically: false, encoding: .utf8)
    }
    catch {/* error handling here */}

    //reading
    do {
        let text2 = try String(contentsOf: fileURL, encoding: .utf8)
    }
    catch {/* error handling here */}
}
