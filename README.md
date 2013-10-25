# nw-howabout
> Another new gen free music streaming player.

## Screenshots
<img src="http://s22.postimg.org/oxe4sshtd/Screen_Shot_2013_10_24_at_4_32_07_PM.png" width=240 />
<img src="http://s21.postimg.org/gahgsaz7b/Screen_Shot_2013_10_24_at_4_45_52_PM.png" width=240 />
<img src="http://s17.postimg.org/uaebunxfj/Screen_Shot_2013_10_24_at_4_43_47_PM.png" width=240 />
<img src="http://s21.postimg.org/kpvajtm7r/Screen_Shot_2013_10_24_at_4_30_36_PM.png" width=240 />
<img src="http://s24.postimg.org/vkd750z45/Screen_Shot_2013_10_24_at_4_47_16_PM.png" width=240 />


## for Korean people
node-webkit 으로 만들어 본 음악 스트리밍 클라이언트. 지난 주 node-webkit 다운로드 받고 만드는데 24시간 정도 들였으니 세상 참 좋아졌다. 디자인도 내 눈에는 이뻐 보임. 데스크탑 앞에서 그때 그때 듣고 싶은 음악 듣고 가사 보고 하기에 딱 좋은 프로그램임.

역시나 이번에도 Grunt, Bower로 빌드 및 프론트엔드 의존성 관리하고 기본 프레임워크 AngularJS 쓰고 jQuery, Bootstrap, FontAwesome UI 삼총사 들어가고 Jade, LESS, CoffeeScript 생산성 도우미들 갖다쓰고 usemin, uglify, cssmin, htmlmin으로 코드 마무리 하고 node-webkit으로 실행파일 뽑게 했음. 다시 말하지만 이 조합은 최고다. 이젠 손에 익어서 코딩 속도도 제법 나옴.

써볼 사람은 아래 링크에서 소스를 직접 컴파일해 사용하거나 개발자가 아닌 경우 댓글이나 메일 주면 실행파일 드리겠음. 집사람 windows machine에서 돌려보니 처음 로딩이 오래 걸리긴 하는데 사용하는데 문제 없이 잘 돌아가더라. 물론 개발 머신인 mac에서 돌리는게 더 빠르고 예뻤다.

브라우저에서는 보안이라던가 여러 한계점들 때문에 할 수 없었던 짓들을 node-webkit을 이용해 아주 손쉽게 처리해 낼 수 있었다. 클라이언트에서 프론트엔드 UI 기술들과 서버 사이드에서 쓰던 node.js를 아무 제약 없이 mix 할 수 있었는데 이건 환상적인 경험이었다.

이 프로그램으로 공짜로 음악 스트리밍이나 mp3 파일을 다운로드 받을 수는 있으나 저작권 이슈가 있을 수 있으니 이미 정당히 음원 권리를 갖고 있는 분들만 사용하시길 바람. 음원이 내 서버에 있는게 아니기 때문에 난 아무런 책임이 없으며, 이건 일종의 음원 검색 프로그램임.

https://www.facebook.com/xissysnd/posts/10202218332877527

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/xissy/nw-howabout/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
