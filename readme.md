JSP를 이용한 게시판 만들기
==========================================
이전에 java로 작성했던 게시판 형식과 유튜버 동빈나의 jsp 게시판 만들기 강좌를 바탕으로 jsp를 이용해 게시판 웹페이지를 구현했다.

1. 프로젝트 생성이유
    - 이전에 생성한 java 게시판을 웹페이지 형태로 구현하면 보기 좋을것 같음
    - 게시판을 구현해보면서 jsp에 대한 이해를 돕기 위함

1. 구상
    - 값을 입력받는 것이 아닌 마우스로 버튼을 클릭하면서 페이지를 이동하는 게시판 만들기
    - 로그인 페이지, 회원가입 페이지, 글목록 페이지, 글쓰기 페이지, 글보기 페이지, 글수정 페이지로 구성됨
    
1. 기능

    1. 로그인 페이지
        - 로그인 기능 : 데이터베이스에 등록된 데이터와 입력받은 데이터를 비교하여 로그인
        - 회원가입 기능 : 아이디, 비밀번호, 이름, 휴대폰번호, 이메일 입력후 DB에 저장
    1. 게시판 페이지
        - 게시글 목록 : 순번, 제목(게시글 보기 링크), 작성자, 작성시간이 나타남
        - 게시글 작성 : 제목, 내용을 작성하면 순번, 작성시간, 작성자가 자동으로 등록됨
        - 게시글 보기 : 게시글 목록에서 글제목을 클릭하면 글보기 페이지로 이동, 작성자와 접속자가 동일하면 수정/삭제 버튼이 나타남
        - 게시글 수정 : 글보기 페이지에서 수정 버튼을 누르고 새로운 제목과 내용을 입력
        - 게시글 삭제 : 글보기 페이지에서 삭제버튼을 누르고 알림창의 확인버튼을 누르면 삭제됨
        - 로그아웃 : 세션을 삭제하여 로그인 페이지로 돌아가게함
        
1. 사용방법
    - oracledatabase와 사용하려는 프로그램(eclipse등)를 연동시킴
    - sql파일의 내용을 수행
    - login.jsp를 실행
    
1. 실행화면

<img width="300" height="200" src="https://postfiles.pstatic.net/MjAyMDEwMDRfMjMy/MDAxNjAxNzg3MjI2NDU2._XWdnA4-38xDJ_DgoK1w_MvGNWxFuirXh_dxqnWPljcg.UbtWuTrnEM77AANJniIN9TwPG0Mdb0Pg3ziWbuPmfjUg.PNG.zndn121/image.png?type=w773"><img width="300" height="200" src="https://postfiles.pstatic.net/MjAyMDEwMDRfMTkg/MDAxNjAxNzg3NTAwNjk1.2DSa0Qg6IqXSCFkDRzB_Zf7ccoayNQFkFiOYM2jlUZog.wr3ejCxEpntBIACSLuZVqyRGPsiM5FSbLbK1wmP9uQsg.PNG.zndn121/image.png?type=w773"><img width="300" height="200" src="https://postfiles.pstatic.net/MjAyMDEwMDRfMjk4/MDAxNjAxNzg3NTM2OTky.-ZPAMp10U03X2Gj8ULO8gsoPf7ekZ1wNd6285Y7D3iYg.OnAVUHDnkIso8569xr0Va1e0Ax_sJ1L7RnOZIjSrOC8g.PNG.zndn121/image.png?type=w773"><img width="300" height="200" src="https://postfiles.pstatic.net/MjAyMDEwMDRfNDYg/MDAxNjAxNzg3NTY2MzUy.aUptlNfKp_Thcm8lTTZ3RT_WLLZbzg_Ktxjxt1kb9PIg.j2P2Qx_1Yh5V8qs27Uss6sW4BVASlxzwc8-ibjLqdKIg.PNG.zndn121/image.png?type=w773"><img width="300" height="200" src="https://postfiles.pstatic.net/MjAyMDEwMDRfMjg1/MDAxNjAxNzg3NTk5NjU1.nLqs610oab5TGf9HiyeeEBLcAWH3YPKqMt1eeDWhxNEg.mPuKOFrrKyJRLtu44puN7eCQ9G7UGx23FH7EmYA-F8Ag.PNG.zndn121/image.png?type=w773"><img width="300" height="200" src="https://postfiles.pstatic.net/MjAyMDEwMDRfNzQg/MDAxNjAxNzg3NTQ2MTg3.Z8Ys1IelSmvdMdLzaZIqvzWEBPP7seaGVNIrvUrxiKUg.35pvPVSMB_yMivjbC_V_fuQXWx9ykqfl2GM2fKdD2pIg.PNG.zndn121/image.png?type=w773"><img width="300" height="200" src="https://postfiles.pstatic.net/MjAyMDEwMDRfMTkw/MDAxNjAxNzg3NjIxNTkz.8Q8TtxFt2l1JHxpFg5D2AkNQBC8ua7nJ-RMwpJSLXZ4g.gEfHC-hAP115LFd5Nbl3hSf0Zl0BStTKrIU7wqIL8Cwg.PNG.zndn121/image.png?type=w773"><img width="400" height="200" src="https://postfiles.pstatic.net/MjAyMDEwMDRfMTEw/MDAxNjAxNzg3NjM4MDg1.RRmrRrALvUvNwqcjIwdMBXxmalm4QGVixs2NCWZ8wl8g.ShVjuTJidqBmx_mEvYR9jI7cv21mhNu86JvNptYa_N0g.PNG.zndn121/image.png?type=w773">
