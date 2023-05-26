# Deeplink 

시뮬레이터에서 효율적으로 UI를 테스트하기 위해 Deeplink를 적용했다. 
URL Schemas는 `cookcode`다. 

`Product > Scheme > Edit Scheme > Environment Variables` 에서 Key값이 `-openURL` 인 곳에 Value를 입력해주면 된다. 

# 사용 방법 
cookcode://`type`=`value`?`path`=`id` 형태로 이용하면 된다. `://` 뒤의 `?`를 기준으로 파싱된다. 

# 사용 예제
![image](https://github.com/ajou-swef/cookcode-iOS/assets/83946805/9b2dbcce-4fa0-458e-be79-1274c418699d)

EditScheme에서 저런식으로 URL을 주면 탭은 홈, 홈의 72번 아이디 레시피로 이동할 수 있다. 

<img src="https://github.com/ajou-swef/cookcode-iOS/assets/83946805/e67e6ce1-5839-44ff-9d7a-be77ed8079ae" width="200" height="400">


문제는 위 이미지처럼 원치않는 여백이 생긴다는 점인데 이는 네비게이션 스택에 있는 문제로 보인다. 2단계의 뷰를 한번에 이동하면 저런식으로 빈 여백이 생기는데 이는 해결하지 못했다. 
