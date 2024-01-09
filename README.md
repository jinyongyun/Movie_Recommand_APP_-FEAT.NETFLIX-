# Movie_Recommand_APP_-FEAT.NETFLIX-
NETFLIX 풍 영화 추천 앱 
오늘은 넷플릭스 풍 영화 추천 앱을 만들어보려고 한다. 

대부분의 OTT 앱에서 많이 보이는 가로로 스크롤을 구현하기 위해서는 UICollectionView가 필요하다. 

예전에 일기장 앱을 구현할 때 기본은 사용해 본 적이 있다. 

## UICollectionView 알아보기

UICollectionView는 데이터와 해당 데이터를 표시하는데 사용되는 시각적 요소를 엄격하게 구분한다.

즉 데이터를 어떻게 관리할 지, 그러한 데이터를 어떻게 나타낼 지 모두 별도로 고려해서 개발해야 한다.

동시에 사용자에게 어떤 형태의 화면을 보여줄 지, 뷰를 가져와서 화면에 배치하는 모든 작업 또한 개발이 되어야 한다. 뷰는 어떻게 배치할 지, 각 뷰는 어떤 속성을 가질 지 

지정할 수 있는 레이아웃 객체와 함께 이 작업을 수행하게 된다.

따라서 데이터 영역, 레이아웃 영역은 각각 분리되어 각자 역할에 맞는 정보를 제공하고 UICollectionView는 이러한 두 구분을 종합해서 최종 형태를 구축한다.

UICollectionView는 데이터가 화면에 배치되고 표시되는 방식과 

표시되는 데이터를 분리하도록 디자인 되어있다.

아래의 표는 UIKit에서 제공되는 UICollectionView 관련 클래스와 프로토콜을 각각의 역할에 따라 정리한 것이다. 대부분의 클래스는 하위 클래스화 할 필요 없이 있는 그대로 사용하도록 설계되었기 때문에 상대적으로 아주 적은 코드로도 복잡한 UI를 구현할 수 있다.

| Purpose | Classes/Protocols |
| --- | --- |
| Top-level containment and management | UICollectionView   UICollectionViewController |
| Content management | UICollectionViewDataSource UICollectionViewDelegate |
| Presentation | UICollectionReusableView UICollectionViewCell |
| Layout | UICollectionViewLayout UICollectionViewLayoutAttributes UICollectionViewUpdateItem |
| Flow Layout | UICollectionViewFlowLayout UICollectionViewDelegateFlowLayout |

먼저 최상위 레벨에서 관리 역할을 하는 UICollectionView, UICollectionViewController가 있다.

***UICollectionView*** 객체는 컬렉션 뷰가 가지는 컨텐츠가 보여지는 영역을 어떻게 할 지 정의한다.

이 클래스는 UIScrollView를 상속하기 때문에 

이후에 다룰 레이아웃 객체에서 수신하는 레이아웃 정보를 기반으로 데이터를 쉽게 표시할 수 있도록 도와준다. 

***UICollectionViewController***는 CollectionView를 뷰컨트롤러 수준에서 관리할 수 있게 해 줄 것이다.

(UITableView와 UITableViewController의 관계와 동일)

***UICollectionViewDataSource***는 UICollectionView와 연결된 가장 중요한 객체이며, **반드시 제공되어야 한다**. DataSource는 Content를 관리하고, Content 표시에 필요한 View를 생성한다.

***UICollectionViewDelegate***는 선택적으로 구현해도 되며, 컬렉션 뷰에서 발생하는 특정 액션이나 상황을 캐치해서 뷰의 동작을 사용자 지정할 수 있다.

그리고 UICollectionView에 표시되는 모든 뷰는 UICollectionViewReusableView의 인스턴스여야 한다!!

이건 테이블 뷰도 마찬가지였지….

지금까지는 테이블 뷰와 비슷했겠지만, 이 레이아웃 관련 객체는 오직 UICollectionView만 갖고 있는 속성이다. UICollectionViewLayout과 그 하위 클래스들을 Layout 객체라고 묶어서 관리하고 

UICollectionView 내에서 cell과 reusableView의 위치 ,크기 ,시각적 속성 이런 것들을 정의하는 역할을 한다.

**이러한 책임 분리를 통해 앱에서 관리하는 데이터 객체를 변경하지 않고도 레이아웃을 동적으로 변경할 수 있다.**

> UICollectionViewLayout
> 

> UICollectionViewLayoutAttributes
> 

> UICollectionViewUpdateItem
> 

레이아웃이라는 단어에서 부모 뷰가 자식 뷰를 재배치 하는데 사용되는 Layout SubView 메서드를 떠올릴 수도 있다.

- **여기서 잠깐, 레이아웃 서브 뷰란??**
    - **ViewController**관련 메서드인 **viewWillAppear**, **viewDidAppear**이 존재하듯이 레이아웃이 결정되기 전, 후의 메서드가 존재
    - **UIKit**은 이처럼 **ViewController**의 등장에 따른 연관된 부가적인 작업을 할 수 있도록 메서드가 존재
    - **Layout** **Subviews**역시 레이아웃이 결정되는 과정 중에 레이아웃과 연관된 부가적인 작업들을 수행할 수 있도록 **UIKit**은 몇 가지 메서드를 만들어놓았다.
    - **viewWillLayoutSubviews() , layoutSubviews(), viewDidLayoutSubviews()**
    

하지만 UICollectionView 레이아웃 객체는 레이아웃 대상이 되는 뷰를 실제 소유하지는 않는다.

레이아웃 프로세스 동안 UICollectionView의 레이아웃 객체는 UICollectionView의 Cell과 ReusableView 등의 위치 크기 시각적 모양 등을 설명하는 (즉 속성을 알려주는) 레이아웃 속성 객체를 만든다.

그런 다음에 UICollectionView가 이러한 속성을 실제 뷰 객체에 적용한다.

레이아웃 객체는 UICollectionView 내에서 데이터 항목이 삽입, 삭제, 이동할 때마다 UICollectionView UpdateItem 클래스의 인스턴스를 받는다. *(해당 인스턴스를 우리가 직접 만들 필요 없으니 걱정 ㄴㄴ)

UICollectionViewFlowLayout 클래스는 그리드나 가타 선 기반 레이아웃을 구현하는데 사용하는 레이아웃 객체이다. 클래스를 있는 그대로 또는 delegate와 함께 사용하기 때문에 레이아웃 정보를 동적으로 사용자가 지정할 수 있게 도와준다.

> UICollectionViewFlowLayout
> 

> UICollectionViewDelegateFlowLayout
> 

 
![Untitled (Draft)-1 5](https://github.com/jinyongyun/Movie_Recommand_APP_FEAT.NETFLIX/assets/102133961/94263984-9362-4777-906c-df9238869974)


사실 UICollectionViewFlowLayout은 무려 iOS 6부터 제공하던 기능이다.

라인에 따라 필요한 공간을 채우고 다음 라인으로 넘어간다던지

이런 간단한 레이아웃 구현은 OK 

하지만 요오즈음 앱들을 봐라!

앱스토어만 하더라도 각 섹션마다 스크롤 방향도 다르고, 셀의 구성 요소도 다르다!! (어케 구현했냐)

서로 다른 레이아웃 객체를 중첩해서 넣은 거면….생각만 해도 머리가 복잡해진다.

이렇게 어려운 UI를 위해 iOS 13 버전부터 **UICollectionViewCompositionalLayout**을 제공하고 있다~이말이다. (그저 갓 외쳐 애플)

어떻게 사용하는지 한 번 보자

```swift
let size = NSCollectionLayoutSize(widthDimension: .fractionWidth(0.3), 
                                  heightDimension: .fractionalHeight(0.75))

let item = NSCollectionLayoutItem(layoutSize: size)

let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                               subitem: item, count: 3)

let section = NSCollectionLayoutSection(group: group)

let layout = NSCollectionViewCompositionalLayout(section: section)
```

CompositionalLayout을 만들기 위해 세 가지의 구성요소가 필요하다(또 나온 삼신기)

item, group, section이 필요한데.

계단식으로 내려온다. 먼저 LayoutSize를 구성하고, 이 LayoutSize를 갖는 item을 만들고

이 item 객체는 layout group 생성에 기여하고 LayoutGroup은 LayoutSection의 생성에 기여한다.

마지막으로 LayoutSection은 CompositionalLayout 생성에 들어가게 되는 구조로 코드를 작성한다.
![Untitled (Draft)-2 3](https://github.com/jinyongyun/Movie_Recommand_APP_FEAT.NETFLIX/assets/102133961/fdd47006-50d0-43e2-bf3c-01ac2485901d)


각 아이템은 개별 사이즈를 갖는데, .absolute   .estimated.   .fractionalWidth 이 세가지 타입으로 넣을 수 있다. 

.absolute는 절대적인 값으로 넣는다(칼같이 정확)

.estimated는 추정 값이다. 데이터가 로드되거나, 시스템 글꼴 크기가 변형된 것과 같이 런타임에 컨텐츠 크기가 변경될 수 있는 경우에 estimated를 사용한다. 초기에 추정크기를 제공하면 시스템이 나중에 실제 값을 계산해서 반영하게 된다.

.fractionalWidth는 분수, 비율이란 의미의 fractional이 있는 것처럼 아이템 컨테이너를 기준으로 비율로 정의한다. (AutoLayout처럼) 0.2면 20%이다.

Group은 item만 포함하는 것이 아니라 group도 포함할 수 있다. (nested group)

 

## SnapKit 알아보기

이번 앱을 구현하면서 storyboard를 사용하지 않을 것이다.

(뭣!! 그게 무슨 말이야!!)

당황하지 말고 들어보자

지금까지 앱을 구현하면서 모두 storyboard로 구현을 했을텐데 

사실 xcode를 이용해 UI를 작성하는 방법은 storyboard만 있는 것이 아니다.

- storyboard 즉 인터페이스 빌더를 사용한 방법
- 코드로만 작성하는 방식
- SwiftUI를 이용하는 방식

위와 같은 세 가지 방법이 있다.

(그러면 라벨의 속성이나 그런 건 그렇다고 치는데, 오토 레이아웃은 코드로 어떻게 작성하는데?!)

당연히 이런 생각이 들 것이다.

그걸 위해 준비한 SnapKit이다.

SnapKit은 코드베이스로 UI를 구현하고 AutoLayout을 고려해야 할 때, 아주 직관적이고 간편하게 오토 레이아웃을 작성할 수 있도록 도와주는 오픈소스 프레임워크이다.

만약 화면 한 가운데 정사각형 하나를 놓은 화면을 구현해본다고 하자

원래 코드베이스라면

```swift
let square = UIView()
...
square.backgroundColor = .blue
square.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

view.addSubview(square)
square.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
square.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
```

이런식으로 복잡하게 지정해줘야 할 것을

```swift
import SnapKit

view.addSubview(square)
square.snp.makeConstraints {
    $0.width.height.equalTo(100)
    $0.center.equalToSuperView()
}
```

이렇게 간단하게 작성할 수 있다. (외쳐 스냅킷!!)

그리고 외부 라이브러리를 받기 위해서 지금까지 코코아팟으로 해결했는데

이젠 다른 방식으로 접근해보겠다. 바로 Swift Package Manager를 사용하면 코코아팟처럼 별도의 pod 파일을 설정하고 워크스페이스 파일로 바꾸고 이런 귀찮은 짓을 할 필요가 없다.

package를 사용하고자 하는 프로젝트에 SnapKit에 대한 디펜던시 주소를 넣어주면 끝이다!

> File > Swift Packages > Add Package Dependency…
> 

# 구현 과정

### 기본 UI 설정

앱 이름은 MovieRecommandApp으로 했다. SwiftUI를 쓸 것도 StoryBoard를 쓸 것도 아니기 때문에 인터페이스 기본 설정인 StoryBoard를 유지했다. 

물론 들어가자마자, 스토리보드와 기본 viewController를 삭제해줬다. (결연한 의지)

물론 이 상태로 빌드를 하면 당연히 에러가 난다. 

따라서 추가적으로 이런 설정들을 없애주고 우리가 만든 뷰 컨트롤러를 바라볼 수 있도록 설정해줄 것이다.

info.plist으로 이동해서, Main storyboard file base name 항목을 삭제하고

Application Scene Manifest 항목으로 가서 하단으로 내려가다 보면, Storyboard Name이라는 항목이 있는데 이것도 삭제해준다.

이번 앱의 홈 화면 역할을 할 뷰 컨트롤러를 추가해준다. 이름은 HomeViewController로 해줬다.

```swift
import UIKit

class HomeViewController: UICollectionViewController {
    
}
```

UICollectionViewController를 상속하도록 해줬다.

이 HomeViewController를 initialViewController라고 인지하고 앱이 띄울 수 있도록 SceneDelegate에서 설정해줘야한다. SceneDelegate의 willConnectTo 메서드에서 작업한다.

```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // UIWindowScene 정의 : 옵셔널 바인딩
        guard let windowScene = scene as? UIWindowScene else { return }

        // 위에서 만들어준 windowScene으로 window 생성
        self.window = UIWindow(windowScene: windowScene)

        // CollectionView는 기본으로 UICollectionViewFlowLayout() 을 갖고 있어야 한다.
        let layout = UICollectionViewFlowLayout()
         
        // 지정해준 레이아웃을 기반으로 HomeViewcontroller를 설정한다.
        let homeViewController = HomeViewController(collectionViewLayout: layout)
       
         // 우리가 스토리보드에서도 기본 뷰컨트롤러 전에 네비게이션 컨트롤러를 루트뷰 컨트롤러로 했던 것처럼
         // 이녀석도 HomeViewController전에 UINavigationController를 루트뷰 컨트롤러로 지정해준다.
        let rootNavigationController = UINavigationController(rootViewController: homeViewController)
        
        // 맨 위에서 만들어줬던 윈도우에 루트뷰 컨트롤러를 rootNavigationController로 설정한다.
        self.window?.rootViewController = rootNavigationController
        self.window?.makeKeyAndVisible() //이걸 설정해야 설정한 값들이 실제로 보여지게 됨
    }
```

이제 위에서 배운 SnapKit을 적용하기 위해 **Swift Package Manager**를 설치할 건데

File > Add Package Dependency 를 누른다.
<img width="1399" alt="스크린샷 2024-01-07 오후 3 10 12" src="https://github.com/jinyongyun/Movie_Recommand_APP_FEAT.NETFLIX/assets/102133961/80aef9a6-fa4a-4cc0-8d28-8bb38d4f6dd2">


이렇게 나오는데, SnapKit의 경로를 검색해서 추가하면 된다.

그러면 이러한 SnapKit이나 외부 라이브러리의 경로는 어디서 얻을 수 있느냐

공식문서에서 얻을 수 있다!!
<img width="869" alt="스크린샷 2024-01-07 오후 3 11 21" src="https://github.com/jinyongyun/Movie_Recommand_APP_FEAT.NETFLIX/assets/102133961/cdcb5ca4-c537-42bd-bfb6-17e9e8d30ddd">


SnapKit 공식 깃헙에 들어가면 이런 식으로 Swift Package Manger 항목에 소개되어있다.


검색란에 URL를 입력하면 알아서 탐색하고 Verifying 후에 버전을 선택하라는 창이 나타난다. 

가장 최신 버전을 선택한 후

install 과정을 거쳐서

Finish를 누르면…

이런식으로 SnapKit이 추가된 걸 볼 수 있다.

넷플릭스의 네비게이션 바처럼 보이기 위해 커스텀을 해보겠다.

HomeViewController의 ViewDidLoad에다 설정해보겠다.

- ***미리 넷플릭스 아이콘을 준비해둬야한다 (Assets에 추가해두자), 포스터 이미지도 저작권에 안걸리게 옛날걸로….준비 (얘도 폴더 통째로 Assets에 추가해줬다)***

```swift
override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션 설정
        navigationController?.navigationBar.backgroundColor = .clear // 배경색은 .clear로
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) // 빈 UI Image
        navigationController?.navigationBar.shadowImage = UIImage() //네비게이션 바의 경계 그림자로 약간 주기
        navigationController?.hidesBarsOnSwipe = true //스크롤로 스와이프 액션일 때 네비게이션 감추기
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "netflix_icon"), style: .plain, target: nil, action: nil) // 넷플리스 아이콘
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
    }
```

### Content.plist에서 데이터 가져오기

이제 CollectionView에 뿌려줄 데이터 형태를 보고

그에 맞는 객체를 구조체로 만들어주려고 한다.

미리 형태를 Content.plist에 정의해뒀다.

Root 바로 밑에 있는 Index를 하나의 Section으로 볼 것이고 (그래서 밑에 sectionType과 sectionName이 있다), 각각의 section이 갖는 contentItem 배열을  group으로 둘 것이다.
<img width="871" alt="스크린샷 2024-01-07 오후 3 31 38" src="https://github.com/jinyongyun/Movie_Recommand_APP_FEAT.NETFLIX/assets/102133961/b8a6e447-8706-452b-9d40-07eef593170b">


새로운 파일을 만들고, 이녀석을 가져올 수 있도록 해보자.

PropertyList에 대한 Decode가 필요할텐데 이 구조체를 Codable로 할 것이냐, Decodable로 할 것이냐가 문제다. 하지만 이번 앱 같은 경우 사용자가 직접 PropertyList에 접근해서 쓰는 경우는 없고 그저 받기만 하기 때문에 Decodable로 했다.

```swift
//
//  Content.swift
//  MovieRecommandApp
//
//  Created by jinyong yun on 1/7/24.
//

import UIKit

struct Content: Decodable {
    let sectionType: SectionType // 타입이기 때문에 enum으로 바꿔주는 것이 더 직관적
    let sectionName: String
    let contentItem: [Item]
    
    enum SectionType: String, Decodable {
        case basic
        case main
        case large
        case rank
    }
}

struct Item: Decodable {
    let description: String
    let imageName: String
    
    var image: UIImage {
        return UIImage(named: imageName) ?? UIImage()
        //바로 imageName을 이미지로 리턴
    }
    
}
```

이렇게 만든 컨텐츠 배열을 기준으로 해서 컬렉션 뷰에 어떤 데이터가 뿌려질 지 설정할 수 있을 것이다.

HomeViewController로 다시 이동해서

```swift
//
//  HomeViewController.swift
//  MovieRecommandApp
//
//  Created by jinyong yun on 1/7/24.
//

import UIKit

class HomeViewController: UICollectionViewController {
    
    var contents: [Content] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션 설정
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) // 빈 UI Image
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true //스크롤로 스와이프 액션일 때 네비게이션 감추기
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "netflix_icon"), style: .plain, target: nil, action: nil) // 넷플리스 아이콘
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
        
        //Data 설정, 가져오기
        contents = getContents()
    }
    
    func getContents() -> [Content] { //Content.plist에서 데이터 가져오기
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let list = try? PropertyListDecoder().decode([Content].self, from: data) else { return [] }
        return list
    }
}
```

방금 만들어 준 구조체인 Content로 이루어진 contents 배열을 만들어주고, 

Content.plist에서 데이터를 가져와서 해당 배열에 넣어준다. 

getContents() 메서드가 데이터를 가져오는 역할을 맡을 건데

위에서도 얘기 했듯이 Bundle.main.path로 직접 Content.plist path를 받아와서, 해당 path의 contents(데이터)를 가져와서 PropertyListDecoder로 decode 해준 뒤 리턴한다.

viewDidLoad에서 contents 배열에 해당 데이터를 넣어준다.

테이블 뷰처럼 CollectionView의 DataSource를 통해서  각 세션이 어떤 셀을 가질지, 각 세션 당 셀의 개수를 어떻게 가질 지를 지정해줘야 한다.

```swift
//UICollectionView DataSource, Delegate
extension HomeViewController {
    //섹션당 보여질 셀의 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: // 첫번째 섹션에서는 무조건 하나의 셀만 보여줄거임
            return 1
        default:
            return contents[section].contentItem.count //전체 contents 배열에서 Item만 즉 하나의 섹션, 거기서 contentItem의 개수만큼이 row(가로)의 개수
        }
    }
    
    // collectionView 셀 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      //일단 패스
    }
    
    // 섹션 개수 설정
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count //Item0, Item1 ...
    }
    
    // 셀 선택했을때
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = contents[indexPath.section].sectionName
        print("TEST: \(sectionName) 섹션의 \(indexPath.row + 1)번째 컨텐츠")
    }
    
}
```

아직까지는 테이블 뷰 컨트롤러와 비슷해서 쉬울 것이다.

이제 기본 셀을 만들어보자, SectionType이 .basic인 포스터만 들어가는 작은 셀을 말하는 것이다.

ContentCollectionViewCell.swift 파일을 따로 만들어준다.

```swift
//
//  ContentCollectionViewCell.swift
//  MovieRecommandApp
//
//  Created by jinyong yun on 1/7/24.
//

import UIKit
import SnapKit

class ContentCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /*갑자기 contentView가 나와 의문일 수도 있는데
        UICollectionViewCell의 경우 cell의 layout을 표현하는 개체는 기본 cell이 있고,
        기본 contentViewCell이 있다. contentView를 superView로 보고 여기다 설정을 해야 보인다.*/
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true // 뷰의 크기에 맞춰 하위 뷰가 잘림(clipped)
        
        imageView.contentMode = .scaleAspectFill //이미지 뷰를 어떻게 표시할거냐
        
        contentView.addSubview(imageView) // contentView에 subView를 추가, 우리가 스토리보드에서 component를 올리는 것과 같음
        
        imageView.snp.makeConstraints { //이미지 뷰의 오토 레이아웃을 설정
            $0.edges.equalToSuperview() //imageView의 superView 즉 contentView에 딱 맞게
        }
    }
}
```

만들어준 cell을 CollectionView에 등록해줘야한다. 다시 HomeViewController로 돌아가서

```swift
//CollectionView Item(Cell) 설정
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "ContentCollectionViewCell")
```

viewDidLoad에 등록해주고, 이렇게 만든 cell을 아까 비워둔 cellForItemAt 메서드에도 추가해줘야한다.

```swift
// collectionView 셀 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType {
        case .basic, .large: //이 두 타입은 그냥 이미지만 보여줘서
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() } //인스턴스화
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image //이미지는 선택한 섹션의 contentItem의 이미지 요소 불러오기
            return cell
        default:
            return UICollectionViewCell() //임시설정
        }
    }
```

우리가 만들 앱에 각각의 세션에는 각각의 group들 즉 아이템 배열이 어떤 컨텐츠인지 나타내는 헤더가 존재한다.

이 헤더를 만들어보자!

ContentCollectionViewHeader.swift 파일을 새로 만들어주고, 반드시 타입은 UICollectionReusableView로 지어야한다.(그래야 header나 footer가 될 수 있다.)

ContentCollectionViewHeader와 마찬가지로 layoutSubview()를 오버라이드하고 여기서 sectionNameLabel(컨텐츠 설명을 위한 라벨)를 만져줄 것이다. 이 부분이 어떤 부분인지, 스토리보드 상에서 어떻게 구현되는지 상상하며 만들면 그렇게 어렵지 않다. 

```swift
//
//  ContentCollectionViewHeader.swift
//  MovieRecommandApp
//
//  Created by jinyong yun on 1/7/24.
//

import UIKit

class ContentCollectionViewHeader: UICollectionReusableView {
    let sectionNameLabel = UILabel() //단일 이름 속성 라벨
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionNameLabel.textColor = .white
        sectionNameLabel.sizeToFit()
        
        addSubview(sectionNameLabel) //UICollectionReusableView에 직접적으로 추가
        
        sectionNameLabel.snp.makeConstraints { //sectionNameLabel에 오토레이아웃 설정
            $0.centerY.equalToSuperview() // UICollectionReusableView 중심과 Y축 맞춰
            $0.top.bottom.leading.equalToSuperview().offset(10) //UICollectionReusableView와 위 아래 옆을 10씩 띄우기
        }
    }
}
```

이렇게 만든 헤더를 CollectionView에 등록해준다.

아까와 똑같이 HomeViewController로 가서 viewDidLoad의 아까 셀을 추가해준 밑부분에 해당 코드를 추가한다.

```swift
collectionView.register(ContentCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ContentCollectionViewHeader") // Cell이 아니므로 forCellWithReuseIdentifier를 쓰지 못하고 forSupplementaryViewOfKind로 얘가 헤더라는 걸 알려야한다.
// UICollectionView의 elementKindSectionHeader 타입으로 이녀석이 헤더라는 걸 나타낼 수 있다.
```

헤더를 등록해줬다면 DataSource에 viewForSupplementaryElementOfKind 메서드에도 헤더를 지정해줘야 한다. cellForRowAt에서 셀을 설정한 것과 비슷하다.

```swift
//헤더뷰 설정
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContentCollectionViewHeader", for: indexPath) as? ContentCollectionViewHeader else { fatalError("Could not dequeue Header") }
            headerView.sectionNameLabel.text = contents[indexPath.section].sectionName
            return headerView
        } else { //헤더 타입이 아닐 때
            return UICollectionReusableView()
        }
    }
```

이렇게 하면 기본 UI 설정이 끝났다!!

### 배너 구현하기

먼저 SwiftUIPreview를 추가하고 시작해보겠다!

CollectionView같은 복잡한 레이아웃을 개발할 때에는 내가 적용한 설정이 적절한 지 확인하기 위해 수시로 시뮬레이터를 돌려야만 한다. 이걸 방지하기 위해 previewProvider를 이용할 수 있다. 다만 이건 SwiftUI에서 제공하는 것이라, 아직 SwiftUI를 제대로 배우지 않았기 때문에 Preview를 사용하는 용도로만 맛보기 차원에서 보도록 하자. 코드가 많이 생소할텐데 이렇게 하면 프리뷰를 볼 수 있다! - 정도로만 이해하자.

**경고) 프리뷰가 열리지 않고 crash가 발생한다. exc_crash (sigabrt) : 의외로 자주 발생하는 버그라고 하며**

**무조건 프로젝트 생성 후 프리뷰 먼저 생성하면 괜찮다. 이것 때문에 플젝을 한 번 갈아엎었다.**

```swift
//SwiftUI를 활용한 미리보기
struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) ->
        UIViewController {
            let layout = UICollectionViewLayout()
            let homeViewController = HomeViewController(collectionViewLayout: layout)
            return UINavigationController(rootViewController: homeViewController)
        }
        
        func updateUIViewController(_ uiViewController:
                                    UIViewController, context: Context) {}
        
        typealias UIViewControllerType = UIViewController
    }
}
```

짠 이렇게 나온다.
<img width="1535" alt="스크린샷 2024-01-08 오후 5 23 23" src="https://github.com/jinyongyun/Movie_Recommand_APP_FEAT.NETFLIX/assets/102133961/630fe9a5-f8d6-44df-a7b1-e6ed1c72c233">


이제 기본 CompositionalLayou을 설정해야한다. 지금까지는 .basic과 .large에 해당하는 cell을 만들었는데

우리가 원하는 레이아웃은 .basic 타입의 셀들이 일렬로 가로 스크롤이 되는, 이런 배너 형태의 레이아웃이다.

여기에 맞는 레이아웃을 CompositionalLayout으로 설정해줘야 한다. 섹션 별로 다른 레이아웃을 적용할 것이기 때문에 그에 맞게 클로저를 통해 분기를 칠 것이다.

```swift
//각각의 섹션 타입에 대한 UICollectionViewLayout 생성
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] 
            sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            switch self.contents[sectionNumber].sectionType {
            case .basic:
                return self.createBasicTypeSection()
            default:
                return nil
            }
            
        }
    }

private func createBasicTypeSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3) //스크롤의 방향과 함께
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous //스크롤의 행동 지정
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        return section
    }
```

이렇게 생성된 레이아웃을 collectionView에 적용해줘야한다.

viewDidLoad에서 컬렉션뷰를 등록해줬던 그 부분에 

**collectionView.collectionViewLayout = layout()** // collectionView의 collectionViewLayout은 layout 함수를 통해 설정해줘라! 

> **아마 당장은 numberOfItemInSecion 즉 섹션 당 보여질 셀의 개수에서 .basic인 경우만 만들었고, .large 등은 만들지 않았기 때문에 *에러*가 발생할 것이다. 당황하지 말고 프리뷰를 보기 위해 .basic 타입일 경우에만 1을 리턴하고 나머지는 0을 리턴하도록 짜준다.**
> 

```swift
//섹션당 보여질 셀의 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if contents[section].sectionType == .basic {
            switch section {
            case 0: // 첫번째 섹션에서는 무조건 하나의 셀만 보여줄거임
                return 1
            default:
                return contents[section].contentItem.count //전체 contents 배열에서 Item만 즉 하나의 섹션, 거기서 contentItem의 개수만큼이 row(가로)의 개수
            }
        }
        return 0
    }
```

그리고 이전에 빠진 것이 있었는데 createBasicTypeSection에서 

처럼 우리가 만든 ContentCollectionViewHeader를 추가하는 코드가 빠져있다. 이녀석도 별도로 레이아웃을 설정해줘야한다.

```swift
//SectionHeader layout 설정
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        //Section Header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        //section Header Layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
    }
```

이렇게 만들어 준 섹션 헤더를 위에서 만들어줬던 createBasicTypeSection에 넣어주면 된다!

```swift
private func createBasicTypeSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        //let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3) //이거 deprecated
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous //스크롤의 행동 지정
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        **let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]**
        
        return section
    }
```

이제 .basic 타입이 완성되었는데, 프리뷰에 잘 표시되는 것을 알 수 있다!
<img width="1792" alt="스크린샷 2024-01-08 오후 6 51 06" src="https://github.com/jinyongyun/Movie_Recommand_APP_FEAT.NETFLIX/assets/102133961/c42928f0-3ff6-411a-9824-c757d59abeae">


이젠 Large 셀을 만들어볼 것이다. *플릭스를 보면, 왜 메인 페이지에 가장 크게 나타나있는 포스터가 있지 않은가? 그런 셀을 만드려는 것이다. 

넷플릭스 화면을 보면, 포스터가 보이는 기본 셀 뿐만 아니라 .basic 과 이미지뷰 하나만을 갖는 아이템이라는 것을 알 수 있고, 단지 다른 건 크기 하나뿐이다.

따라서 아이템의 섹션 타입이 .Large인 경우에는  크게 보여질 수 있도록 별도로 레이아웃을 설정해줘야 한다. 

createBasicTypeSection 메서드 때와 같이 item→ group → section 순으로 쌓아가며 만들어주면 된다. 이제 이것을 레이아웃 분기 처리한 부분에 추가하면 되겠지? 그리고 당연히 .basic만 보여줬던  numberOfItemsInSection에도 .large 타입을 보여주도록 추가해줬다.

```swift
//큰 화면 Section Layout 설정
    private func createLargeTypeSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5) //왜 아이템 사이즈를 .basic과 똑같이 하냐면 group 사이즈를 다르게 할 것이기 때문, 그룹이 커지면 비율 설정이라 아이템도 같이 커지겠죠??
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(400)) // .basic에 비해 2배 height 커짐
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous //스크롤 시 액션
        
        let sectionHeader = self.createSectionHeader()  //섹션 헤더도 동일
        section.boundarySupplementaryItems = [sectionHeader] //섹션에 대한 SupplementaryItem으로 헤더가 있음을 알려줌
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5) //섹션 인셋 설정
        return section
        
    }

...

//각각의 섹션 타입에 대한 UICollectionViewLayout 생성
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            switch self.contents[sectionNumber].sectionType {
            case .basic:
                return self.createBasicTypeSection()
            **case .large:
                return self.createLargeTypeSection()**
            default:
                return nil
            }
            
        }
    }
...

//UICollectionView DataSource, Delegate
extension HomeViewController {
    //섹션당 보여질 셀의 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if contents[section].sectionType == .basic
            || contents[section].sectionType == .large {
            switch section {
            case 0: // 첫번째 섹션에서는 무조건 하나의 셀만 보여줄거임
                return 1
            default:
                return contents[section].contentItem.count //전체 contents 배열에서 Item만 즉 하나의 섹션, 거기서 contentItem의 개수만큼이 row(가로)의 개수
            }
        }
        return 0
    }
```
<img width="1622" alt="스크린샷 2024-01-08 오후 11 22 11" src="https://github.com/jinyongyun/Movie_Recommand_APP_FEAT.NETFLIX/assets/102133961/2ae20865-9523-4275-8b0c-5f3ae7a8e517">


프리뷰로 봐도 .large 섹션이 잘 표시되는 것을 알 수 있다!

이제 순위를 표시해주는 RankCell을 만들어보겠다. 왜 넷플릭스에서 현재 순위를 보여주는, 큼지막한 숫자가 포스터 위에 쓰여있는 그녀석 말이다. 

딱봐도 모양이 다르기 때문에 별도로 cell 파일을 만들어준다.

```swift
//  ContentCollectionViewRankCell.swift
//  MovieRecommand
//
//  Created by jinyong yun on 1/8/24.
//

import UIKit
import SnapKit

class ContentCollectionViewRankCell: UICollectionViewCell {
    let imageView = UIImageView()
    let rankLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //contentView
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        //imageView
        imageView.contentMode = .scaleToFill
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview() //탑, 옆, 바텀을 슈퍼뷰와 같게
            $0.width.equalToSuperview().multipliedBy(0.8) //가로 넓이를 슈퍼뷰와 같이 맞춰주는데 약간 작게
            
        }
        
        
        //rankLabel
        rankLabel.font = .systemFont(ofSize: 100, weight: .black)
        rankLabel.textColor = .white
        contentView.addSubview(rankLabel)
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(25)
        }
    }
    
    
    
}
```

만들어준 랭크셀을 CollectionView에 등록해줘야한다. viewDidLoad에 .basic 셀을 등록해줬던 바로 밑에 register 메서드를 이용해 넣어준다.

물론 cellForItemAt에도 변화가 생긴다. .basic, .large 섹션인 경우에 ContentCollectionViewCell 통칭 .basic 셀을 쓰라고 되어있는데, 이젠 .rank 섹션인 경우엔 RankCell (ContentCollectionViewRankCell)을 써줘야 한다는 것을 알려줘야한다.

```swift
// collectionView 셀 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType {
        case .basic, .large: //이 두 타입은 그냥 이미지만 보여줘서
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() } //인스턴스화
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image //이미지는 선택한 섹션의 contentItem의 이미지 요소 불러오기
            return cell
        case .rank:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewRankCell", for: indexPath) as? ContentCollectionViewRankCell else { return UICollectionViewCell() }
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            cell.rankLabel.text = String(describing: indexPath.row + 1) // 1위부터 표시
            return cell
        default:
            return UICollectionViewCell() //임시설정
        }
    }
```

.rank 섹션도 레이아웃을 가질 수 있게 별도의 레이아웃 생성 메서드를 만들어 줄 것이다.

이젠 세 번째니 상당히 익숙할 것이다. NSCollectionLayoutSection를 리턴해주고 item, group, section 순으로 쌓아가며 만들어준다.

```swift
 //순위 표시 Section Layout 설정
    private func createRankTypeSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        return section
    }
```

이 layout을 섹션 분기처리해준 layout 메서드에 추가해준다. 물론 numberOfItemsInSection에도 .basic, .large 만 보여주도록 되어있으니, .rank도 추가해줘야한다. 이렇게 하면 랭크 섹션까지 프리뷰에 잘 나타난다!
<img width="1622" alt="스크린샷 2024-01-08 오후 11 22 11" src="https://github.com/jinyongyun/Movie_Recommand_APP_FEAT.NETFLIX/assets/102133961/b1bdd3e8-ec26-498c-bfc6-79420dc2d896">


### 리스트 구현하기

이젠 거의 다 왔다! 코드를 활용해 레이아웃과 UI를 만들다보니 평소보다 배는 더 힘든 것 같다. 

하지만 자유도라던지 코드의 활용성은 훨씬 높아진 것이 여실히 느껴져 보람도 느낀다.

이제 마지막 셀인데, 넷플릭스 화면 상단에 위치한 가장 큰 셀이다.

포스터 이미지 밑에 영화에 대한 설명이 주석처럼 달려있다.

그래서 이렇게 짜보려고 한다.
![Untitled (Draft)-3 3](https://github.com/jinyongyun/Movie_Recommand_APP_FEAT.NETFLIX/assets/102133961/3989abef-e4df-40f3-8c82-1fa0c7ba3ac5)


menuStackView를 baseStackView위에, 즉 포함되는 것이 아니고 그냥 align만 맞춰서 넣을 것이다.

baseStackView는 imageView, descriptionLabel, contentStackView이 세가지 컴포넌트를 가질 것이다. 이 모든 걸 코드로 짜야하기 때문에 초반에 이렇게 그림으로 그려놓는 편이 더 편하다.

ContentCollectionViewMainCell.swift 파일을 만들어주고, 언제나 그렇듯 타입은 UICollectionViewCell로 지정해준다.

```swift
//
//  ContentCollectionViewMainCell.swift
//  MovieRecommand
//
//  Created by jinyong yun on 1/8/24.
//

import UIKit
import SnapKit

class ContentCollectionViewMainCell: UICollectionViewCell {
    let baseStackView = UIStackView()
    let menuStackView = UIStackView()
    
    //메뉴스택뷰의 세가지 버튼
    let tvButton = UIButton()
    let movieButton = UIButton()
    let categoryButton = UIButton()
    
    
    //baseStackView의 내부 컴포넌트
    let imageView = UIImageView()
    let descriptionLabel = UILabel()
    let contentStackView = UIStackView()
    
    //contentStackView 내부 컴포넌트
    let plusButton = UIButton()
    let playButton = UIButton()
    let infoButton = UIButton()
    
    override func layoutSubviews() { //레이아웃 설정
        super.layoutSubviews()
        
        [baseStackView, menuStackView].forEach {
            contentView.addSubview($0)
        }
        
        //baseStackView
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.distribution = .fillProportionally
        baseStackView.spacing = 5
        
        [imageView, descriptionLabel, contentStackView].forEach {
            baseStackView.addArrangedSubview($0) //스택뷰에 넣을 땐 addArrangeSubview를 해줘야 함! not addSubview
            
        }
        
        //ImageView
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.width.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        //DescriptionLabel
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .white
        descriptionLabel.sizeToFit()
        
        //ContentStackView
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .equalCentering
        contentStackView.spacing = 20
        
        [plusButton, infoButton].forEach {
            contentStackView.addArrangedSubview($0)
            $0.titleLabel?.font = .systemFont(ofSize: 13)
            $0.setTitleColor(.white, for: .normal)
            $0.imageView?.tintColor = .white
            $0.adjustVerticalLayout(5)
        }
        
        plusButton.setTitle("내가 찜한 컨텐츠", for: .normal)
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        infoButton.setTitle("정보", for: .normal)
        infoButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        
        contentStackView.addArrangedSubview(playButton)
        playButton.setTitle("▶︎ 재생", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.backgroundColor = .white
        playButton.layer.cornerRadius = 3
        playButton.snp.makeConstraints {
            $0.width.equalTo(90)
            $0.height.equalTo(30)
        }
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        
        contentStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        //menuStackView
        menuStackView.axis = .horizontal
        menuStackView.alignment = .center
        menuStackView.distribution = .equalSpacing
        menuStackView.spacing = 20
        
        [tvButton, movieButton, categoryButton].forEach {
            menuStackView.addArrangedSubview($0)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.shadowColor = UIColor.black.cgColor //shadowColor는 cgColor를 받음
            $0.layer.shadowOpacity = 1
            $00.layer.shadowRadius = 3
        }
        
        tvButton.setTitle("TV 프로그램", for: .normal)
        movieButton.setTitle("영화", for: .normal)
        categoryButton.setTitle("카테고리 ▼", for: .normal)
        
        //IBAction 처럼 함수 동작 추적
        tvButton.addTarget(self, action: #selector(tvButtonTapped), for: .touchUpInside)
        movieButton.addTarget(self, action: #selector(movieButtonTapped), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        
        menuStackView.snp.makeConstraints {
            $0.top.equalTo(baseStackView) //baseStackView와 맞춰줘
            $0.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    @objc func tvButtonTapped(sender: UIButton!) {
        print("TEST: TV Button Tapped")
    } 
    
    @objc func movieButtonTapped(sender: UIButton!) {
        print("TEST: movie Button Tapped")
    }
    
    @objc func categoryButtonTapped(sender: UIButton!) {
        print("TEST: category Button Tapped")
    }
    
    @objc func plusButtonTapped(sender: UIButton!) {
        print("TEST: plus Button Tapped")
    }
    
    @objc func infoButtonTapped(sender: UIButton!) {
        print("TEST: info Button Tapped")
    }
    
    @objc func playButtonTapped(sender: UIButton!) {
        print("TEST: play Button Tapped")
    }
    
    
}
```

중간에 plusButton이나 infoButton의 spacing을 위해서 UIButton 클래스의 extension으로 새로운 함수를 만들어줬다.

```swift
//  UIButton.swift
//  MovieRecommand
//
//  Created by jinyong yun on 1/9/24.
//

import UIKit

extension UIButton {
    func adjustVerticalLayout(_ spacing: CGFloat = 0) {
        let imageSize = self.imageView?.frame.size ?? .zero
        let titleLabelSize = self.titleLabel?.frame.size ?? .zero
        
        self.configuration?.imagePadding = spacing
        self.configuration?.titlePadding = spacing
        //self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0) 이거 deprecated됨
        //self.imageEdgeInsets = UIEdgeInsets(top: -(titleLabelSize.height + spacing), left: 0, bottom: 0, right: -titleLabelSize.width)
        
        
    }
    
}
```

MainCell의 구성이 완료됐으니, 이를 CollectionView에 등록시켜줘야 한다.

Cell들 register 해줬던 부분에 

```swift
collectionView.register(ContentCollectionViewMainCell.**self**, forCellWithReuseIdentifier: "ContentCollectionViewMainCell")
```

추가해주고…그리고 기존 Content.plist를 보면 mainCell의 데이터가 많은 것을 볼 수 있다. 우리는 화면 상에서 그 중 하나만 보여주면 되므로 랜덤으로 이를 보여주도록 해주겠다.

```swift
import UIKit
import SwiftUI

class HomeViewController: UICollectionViewController {
    ...
    var mainItem: Item? //메인 아이템 변수 설정

    ...
     //Data 설정, 가져오기
        contents = getContents()
        mainItem = contents.first?.contentItem.randomElement() //이렇게 하면 랜덤 뽑기!
```

이제 위에서 못해준 cellForItemAt에 ContentCollectionViewMainCell을 등록시켜주겠다.

```swift
// collectionView 셀 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType {
        case .basic, .large: //이 두 타입은 그냥 이미지만 보여줘서
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() } //인스턴스화
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image //이미지는 선택한 섹션의 contentItem의 이미지 요소 불러오기
            return cell
        case .rank:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewRankCell", for: indexPath) as? ContentCollectionViewRankCell else { return UICollectionViewCell() }
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            cell.rankLabel.text = String(describing: indexPath.row + 1) // 1위부터 표시
            return cell
        **case .main:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewMainCell", for: indexPath) as? ContentCollectionViewMainCell else { return UICollectionViewCell() }
            cell.imageView.image = mainItem?.image
            cell.descriptionLabel.text = mainItem?.description
            return cell**
        }
    }
```

마지막 mainCell에 맞는 레이아웃도 설정해주자, 물론 만든 다음 분기 치는 것도 잊지 말자!! (이젠 정말 익숙하죠?)

```swift
//각각의 섹션 타입에 대한 UICollectionViewLayout 생성
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            switch self.contents[sectionNumber].sectionType {
            case .basic:
                return self.createBasicTypeSection()
            case .large:
                return self.createLargeTypeSection()
            case .rank:
                return self.createRankTypeSection()
            case .main:
                return self.createMainTypeSection()
            }
        }
    }

...

//Main Section Layout 설정
    private func createMainTypeSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(450))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item]) //가로 스크롤 없다
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        //main은 헤더 없음
        return section
    }

...

//UICollectionView DataSource, Delegate
extension HomeViewController { //이제 모든 타입 완성됐으므로 numberOfItemsInSection에서 조건문 없애주기!
    //섹션당 보여질 셀의 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            switch section {
            case 0: // 첫번째 섹션에서는 무조건 하나의 셀만 보여줄거임
                return 1
            default:
                return contents[section].contentItem.count //전체 contents 배열에서 Item만 즉 하나의 섹션, 거기서 contentItem의 개수만큼이 row(가로)의 개수
            }
    }
```

<img width="1531" alt="스크린샷 2024-01-09 오전 10 27 38" src="https://github.com/jinyongyun/Movie_Recommand_APP_FEAT.NETFLIX/assets/102133961/2e915b5d-0ad1-431e-9f64-ab9204c5c0c4">

프리뷰를 리로드하면 의도한 mainCell이 잘 표시되는 것을 알 수 있다!

### 발견한 문제

plusButton하고 playButton의 순서가 엉망진창이다. 이는 ContentCollectionViewMainCell에서 addArrangeSubview를 했을 때 추가된 순서대로 나오기 때문이다. → 기존 addArrangeSubview를 주석처리하고 다음과 같이 한꺼번에 써주면 제대로 나온다.

```swift
[plusButton, playButton, infoButton].forEach {
            contentStackView.addArrangedSubview($0)
        }
```

## 실제 구동 화면


https://github.com/jinyongyun/Movie_Recommand_APP_FEAT.NETFLIX/assets/102133961/ee4b7a38-c41e-4950-9433-ba220f6aa4ee


