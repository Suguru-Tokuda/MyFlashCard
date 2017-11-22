import Foundation

public class User {
    
    private var userName: String;
    private var email: String;
    
    // initializer
    public init() {
        userName = "";
        email = "";
    }
    
    public init(userName: String, email: String) {
        self.userName = userName;
        self.email = email;
    }
    
    // getters and setters
    public func getUserName() -> String {
        return userName;
    }
    
    public func setUserName(userName: String) {
        self.userName = userName;
    }
    
    public func getEmail() -> String {
        return email;
    }
    
    public func setEmail(email: String) {
        self.email = email;
    }
    
}
