# Deeplink 

시뮬레이터에서 효율적으로 UI를 테스트하기 위해 Deeplink를 적용했다. 
URL Schemas는 `cookcode`다. 

`Product > Scheme > Edit Scheme > Environment Variables` 에서 Key값이 `-openURL` 인 곳에 Value를 입력해주면 된다. 

# 사용 방법 
cookcode://`type`=`value`?`type`=`value` 형태로 이용하면 된다. `://` 뒤의 `?`를 기준으로 파싱된다. 

# 첫번째 타입 

탭 내부에서 탐색(navigate)을 하고싶으면 첫번째 타입은 `Tab.swift`에 정의된 쿠키, 홈, 냉장고 셋 중 하나를 입력해야한다. 
ex) `cookcode://tab=cookie` 

탭바가 사라지는 outer는 `OuterPath.swift`에 정의되어 있다.
ex) `cookcode://outer=profile` 

`NavigateViewModel.swift`에 URL에 입력된 값들이 어떤 Type으로 바뀌는지 정의되어 있다. 