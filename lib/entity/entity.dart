// 엔티티 = 컬렉션 내용 전체
// user - userId, usrPw, email, birth, gender 등 컬렉션에 들어간 필드값 전체
// DTO

// 엔티티 폴더 = 엔티티 + 모델
// 엔티티만 쓰은다느 뜻과 비슷
// 컬렉션명 그대로 파일명 = user_TBL.dart

// 레파지토리 = 파이어베이스에 직접 데이터 접근
// 매개변수 유저인덱스 5

// 레파지토리를 쪼개 놓은게 useCase
// 이 기능에는 이 레파지토리만 쓸거라는 거 정의 가능
// alramUpdateUseCase