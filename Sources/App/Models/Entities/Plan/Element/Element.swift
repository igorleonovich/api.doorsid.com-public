import Vapor
import Fluent

final class Element: Model, Codable {
  
    static let schema = "elements"

    @ID
    var id: UUID?
    
    @Parent(key: "userID")
    var user: User
    
    @OptionalParent(key: "superElementID")
    var superElement: Element?
    
    @OptionalParent(key: "markupElementContainer")
    var markupElementContainer: MarkupElementContainer?
    
    @OptionalParent(key: "dataElementContainer")
    var dataElementContainer: DataElementContainer?
    
    @Field(key: "index")
    var index: Int
    
    @Field(key: "flipFlag")
    var flipFlag: Bool

    init() {}

    init(id: UUID? = nil, userID: User.IDValue, superElementID: Element.IDValue? = nil, markupElementContainerID: MarkupElementContainer.IDValue? = nil, dataElementContainerID: DataElementContainer.IDValue? = nil, index: Int) {
        self.id = id
        self.$user.id = userID
        self.$superElement.id = superElementID
        self.$markupElementContainer.id = markupElementContainerID
        self.$dataElementContainer.id = dataElementContainerID
        self.index = index
        self.flipFlag = false
    }
}
