import Foundation

public class SchoolClass {
    
    private var classNum: String;
    private var className: String;
    private var classID: String;
    
    // MARK: - initiallizers
    public init() {
        classNum = ""
        className = ""
        classID = ""
    }
    
    public init(classNum: String, className: String, classID: String) {
        self.classNum = classNum
        self.className = className
        self.classID = classID
    }
    
    // MARK: - getters & setters
    public func getClassNum() -> String {
        return classNum
    }
    
    public func setClassNum(classNum: String) {
        self.classNum = classNum
    }
    
    public func getClassName() -> String {
        return className
    }
    
    public func setClassName(className: String) {
        self.className = className
    }
    
    public func getClassID() -> String {
        return classID
    }
    
    public func setClassID(classID: String) {
        self.classNum = classID
    }
    
}
