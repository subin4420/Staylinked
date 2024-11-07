# StayLiked

## 목차

- [소개](#소개)
- [시작하기](#시작하기)
- [사용법](#사용법)
- [기여하기](../CONTRIBUTING.md)

## 소개 <a name = "소개"></a>
**StayLiked**는 요양병원과 환자의 보호자가 소통할 수 있도록 돕는 iOS 애플리케이션입니다. 병원 측에서 보호자에게 환자의 건강 상태, 식단 정보, 공지사항 등을 실시간으로 전달할 수 있어 신속한 정보 공유가 가능합니다. 또한 보호자는 앱을 통해 병원에 문의 사항을 전달하거나 요청할 수 있습니다.<br>
Firebase 인증(Firebase Authentication) 및 NoSQL 데이터베이스(Firebase Realtime Database)를 사용하여 안전하고 실시간으로 소통할 수 있는 환경을 제공합니다. 
<br>
앱은 Swift와 Xcode를 사용하여 개발되었으며, CocoaPods을 통해 의존성을 관리합니다.


## 화면 구성
![Image Alt Text](/StayLinked/img/요양병원%20측%20앱%20구성도.png)
- **로그인 화면**: 앱의 시작 화면으로, 사용자가 병원 측에서 제공된 계정으로 로그인할 수 있습니다.
- **메인 화면**: 로그인 후 메인 메뉴를 통해 환자 정보, 건강 기록, 공지사항, 식단 정보 등 다양한 정보를 확인할 수 있습니다.
  
### 주요 화면 설명

1. **환자 정보 공유**
   - 환자의 의료 정보를 보호자와 공유하는 화면입니다.
   - 환자의 기본 정보와 최신 건강 상태를 볼 수 있습니다.

2. **공지사항**
   - 병원 측에서 보호자에게 전달하는 공지사항 리스트 화면입니다.
   - 개별 공지사항을 선택하면 상세 화면으로 이동하여 공지 내용을 확인할 수 있습니다.

3. **식단 정보**
   - 환자의 주간 식단 정보를 제공하는 화면입니다.
   - 보호자가 환자의 식단을 확인하고 관리할 수 있습니다.

4. **면회 예약**
   - 보호자가 병원에 방문 예약을 할 수 있는 화면입니다.
   - 캘린더 형식으로 날짜를 선택하고 예약할 수 있습니다.

5. **환자 건강 관리**
   - 환자의 최근 건강 상태를 공유하는 화면으로, 최신 검진 결과 및 관리 사항을 볼 수 있습니다.

6. **문의하기**
   - 보호자가 병원에 문의사항을 남길 수 있는 화면입니다.
   - 문의 사항을 입력하고 전송하면 병원 측에서 답변을 받을 수 있습니다.


## 시작하기 <a name = "시작하기"></a>

이 지침에 따라 이 프로젝트의 복사본을 로컬 컴퓨터에서 개발 및 테스트 목적으로 실행할 수 있습니다.

### 필요 조건

앱을 실행하기 위해 필요한 소프트웨어와 설치 방법은 다음과 같습니다.
- Xcode (최신 버전)
- CocoaPods
- Firebase 계정 및 NoSQL

### 설치

개발 환경을 설정하기 위한 단계별 설명입니다.

1. 저장소를 클론합니다.

    ```
    git clone https://github.com/yourusername/CareConnect.git
    ```

2. 프로젝트 디렉토리로 이동합니다.

    ```
    cd CareConnect
    ```

3. CocoaPods을 사용해 Firebase와 기타 의존성을 설치합니다.

    ```
    pod install
    ```

4. `CareConnect.xcworkspace` 파일을 열어 Xcode에서 프로젝트를 실행합니다.

    ```
    open CareConnect.xcworkspace
    ```

5. Firebase 프로젝트를 설정하고 `GoogleService-Info.plist` 파일을 Xcode 프로젝트의 루트 디렉토리에 추가합니다.

이제 로컬 환경에서 앱을 실행할 준비가 되었습니다.

## 디렉토리 구조 <a name="디렉토리-구조"></a>

|—— AppDelegate.swift # 앱의 진입점 설정<br>
|—— Assets.xcassets # 앱에 사용되는 이미지 및 색상 리소스<br>
|—— Base.lproj # 기본 스토리보드 파일 (런치 스크린, 메인 화면)<br>
|—— ViewControllers # 주요 화면별 뷰 컨트롤러 폴더<br>
| |—— MainViewController.swift # 메인 화면<br>
| |—— LoginViewController.swift # 로그인 화면<br>
| |—— CareInfoViewController.swift # 환자 정보 화면<br>
| |—— HealthInfoViewController.swift # 건강 정보 화면<br>
| |—— NoticeViewController.swift # 공지 사항 화면<br>
| |—— QnAViewController.swift # QnA 화면<br>
| |—— DietViewController.swift # 식단 정보 화면<br>
|—— Models # 모델 파일 폴더<br>
| |—— Patient.swift # 환자 정보 모델<br>
| |—— Notice.swift # 공지사항 정보 모델<br>
|—— Resources # 리소스 파일 폴더<br>
| |—— GoogleService-Info.plist # Firebase 설정 파일<br>
| |—— Info.plist # 프로젝트 정보 설정 파일<br>
|—— SceneDelegate.swift # 씬 관리<br>

각 폴더 및 파일은 앱의 기능별로 구성되어 있으며, `ViewControllers` 폴더에는 화면별 로직이, `Models` 폴더에는 데이터 모델이 포함되어 있습니다. `Assets.xcassets`에는 앱에 사용되는 이미지와 색상 리소스가, `Resources` 폴더에는 Firebase 및 앱 설정 파일이 저장되어 있습니다.



## 사용법 <a name = "사용법"></a>
1. **로그인**: 앱을 처음 실행하면 보호자는 회원가입 및 로그인을 통해 계정을 생성할 수 있습니다.
2. **환자 정보 보기**: 보호자는 환자의 건강 상태, 최근 진료 기록 등을 확인할 수 있습니다.
3. **문의 사항 전송**: QnA 화면에서 보호자는 병원 측에 문의 사항을 전송하고 답변을 받을 수 있습니다.
4. **식단 정보 확인**: 식단 정보 화면에서 병원에서 제공하는 환자의 주간 식단을 확인할 수 있습니다.
5. **공지사항 확인**: 공지사항 화면에서 병원에서 제공하는 최신 공지를 확인할 수 있습니다.
