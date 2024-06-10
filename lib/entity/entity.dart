// 엔티티 = 컬렉션 내용 전체
// user - userId, usrPw, email, birth, gender 등 컬렉션에 들어간 필드값 전체
// DTO

// 엔티티 폴더 = 엔티티 + 모델
// 엔티티만 쓰은다느 뜻과 비슷
// 컬렉션명 그대로 파일명 = user_TBL.dart

// 레파지토리 = 파이어베이스에 직접 데이터 접근
// 매개변수 유저인덱스 5
// 여기에 쿼리문

// 레파지토리를 쪼개 놓은게 useCase
// 이 기능에는 이 레파지토리만 쓸거라는 거 정의 가능
// alramUpdateUseCase



// 모델

// class MyModel {
//   late int id;
//   late String title;
//   late String body;
//
//   MyModel({
//     id,
//     title,
//     body,
//   });
//
//   MyModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     body = json['body'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.title;
//     data['body'] = this.body;
//     return data;
//   }
// }

//
// class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
//   final NumberTriviaRepository repository;
//
//   GetRandomNumberTrivia(this.repository);
//
//   @override
//   Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
//     return await repository.getRandomNumberTrivia();
//   }
// }


// class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
//   final NumberTriviaRepository repository;
//
//   GetConcreteNumberTrivia(this.repository);
//
//   @override
//   Future<Either<Failure, NumberTrivia>> call(Params params) async {
//     return await repository.getConcreteNumberTrivia(params.number);
//   }
// }
//
// class Params extends Equatable {
//   final int number;
//
//   Params({@required this.number});
//
//   @override
//   List<Object> get props => [number];
// }


// 엔티티

//
// class NumberTrivia extends Equatable {
//   final String text;
//   final int number;
//
//   NumberTrivia({
//     @required this.text,
//     @required this.number,
//   });
//
//   @override
//   List<Object> get props => [text, number];
// }