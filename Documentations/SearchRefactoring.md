# 검색 결과의 종류 

|<img src="https://user-images.githubusercontent.com/83946805/235576797-ed2a539b-fe89-4c0c-b2c7-2671e79d988c.png" width="150" height="300" />

위 이미지에서 보듯이 검색을 할 때 어떤 유형의 검색을 할 것인지 지정하려고 한다. 현재까지 정해진 것은 레시피-쿠키-사용자인데 앞으로 어떤 유형의 검색이 추가될지 모른다.

```swift
enum SearchType: String, CaseIterable {
    case recipe = "레시피"
    case cookie = "쿠키"
    case user = "사용자"
}

func search() {
    switch searchType {
    case .recipe:
        // 레시피 검색
    case .cookie:
        // 쿠키 검색
    case .user:
        // 사용자 검색 
    }
}
```
검색 유형을 Enum으로 정의하면 새로운 유형이 추가될 때마다 SearchType과 `search()`를 실행하는 ViewModel에 변경이 생겨 OCP를 위반한다. 

1. if문
2. switch문
3. 타입 캐스팅
4. 중복 코드 

위 4가지가 보일 때는 가능한 제거해주는 것이 좋다. 

# Cell 추상화 

사용자 검색, 레시피 검색, 쿠키 검색을 추상화하려고 보니 이 함수들의 Signature가 애매했다.  

각각 UserCell, RecipeCell, CookieCell이라는 별도의 타입을 반환할 것이다. 검색에 대한 추상화뿐 아니라 Cell에 대한 추상화도 필요하다. 

<img width="407" alt="IMG_1965" src="https://user-images.githubusercontent.com/83946805/235577954-56055fb2-5472-4fa2-b150-ef53c50fe4dd.PNG">

이미 RecipeCell의 UI가 정해져있으니 이를 토대로 추상화할 것이다. 좋아요와 조회수는 당장 서비스에서 구현하지 않으니 사용자 이름, 썸네일 URL, 제목 세가지만을 사용한다. 


```swift
protocol Cell: Identifiable, Hashable {
    var thumbnail: String { get set }
    var title: String { get set }
    var userNmae: String { get set }
}

struct RecipeCell: Cell { 
    let id: String = UUID().uuidString
    var thumbnail: String
    var title: String
    var userNmae: String
}
```

# 검색 추상화 
Cell이 추상화 됐으니 이제 검색을 추상화 할 수 있다. 

```swift
protocol SearchCellServiceProtocol {
    func searchCell(page: Int, size: Int, sort: String, month: Int) async -> Result<[any Cell], ServiceError>
}
```

<img width="600" alt="IMG_1965" src="https://user-images.githubusercontent.com/83946805/235578769-bb656e2f-1c9c-4718-8dc0-d8ee8dda1338.png">

Cell을 반환하도록 프로토콜을 만들어준 후 기존에 작성된 서비스 프로토콜들이 이 프로토콜을 준수하도록 했다.

# 뷰모델에서 사용 

```swift
class SearchCellViewModel: ObservableObject {

    @Published var cells: [any Cell] = []
    private var searchCellService: SearchCellServiceProtocol

    
    @MainActor
    func searchCell() async {
        let result = await searchCellService.searchCell(page: 0, size: 0, sort: "sort", month: 0)
        
        switch result {
        case .success(let success):
            cells.append(contentsOf: success)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
}
```

View에서는 어떤 searchCellService에 대한 의존성을 주입해주면 검색 기능이 확장되어도 SearchCellViewModel에는 변경이 생기지 않아 OCP를 지킬 수 있게된다. 

# View 재사용 
```swift
struct CellView: View {
    
    let cell: any Cell
    
    var body: some View {
        HStack {
            // 생략...
            Text("\(cell.userNmae)")
          
            
            // 생략... 
            KFImage(URL(string: cell.thumbnail))

            // 생략... 
            Text(cell.title)
                   
        }
    }
}
```

쿠키, 사용자, 레시피를 모두 같은 뷰로 사용하고 싶어도 문제 없다. Cell 프로토콜만 준수한다면 뷰 재사용도 가능해진다. 