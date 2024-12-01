### 소개
- 터미널 환경에서 실행할 수 있는 셸 스크립트로 만든 타이머
- MacOS에서만 사용 가능하며, MacOS 10.14 버전에서 작동 확인

### 설치 방법
```
git clone https://github.com/rogarithm/timer.git
cd path/to/project
chmod +x *.sh
```

### 실행 방법
- `--` 옵션은 분 단위로 타이머를 설정하고, `--test` 옵션은 초 단위로 타이머를 설정
```
./timer.sh -- 25 #타이머 시간을 25분으로 설정
./timer.sh --test 10 #타이머 시간을 10초로 설정
```
- `t1 t2 t3`의 형식으로 한 번에 여러 시간을 설정할 수 있음
```
./timer.sh -- 25 5 #25분 후 알림을 띄우고, 바로 5분 후에도 알림을 띄움
```
- 설정한 시간이 지날 때마다 다음과 같이 화면 우측 상단에 알림을 띄워줌
![image](https://github.com/rogarithm/timer/assets/30012466/261c4f5f-940e-4b4c-86cb-bf006f493c04)
