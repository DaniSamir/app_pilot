// import 'package:app_lib_core/app_lib_core.dart';
// import 'package:dartz/dartz.dart';
// import '../domain/errors.dart';
// import '../infra/model/merchant_recipients_model.dart';
// import '../infra/model/pending_split_model.dart';
// import '../infra/model/recipients_body_model.dart';
// import '../infra/model/recipients_split_model.dart';
// import '../infra/model/split_body_model.dart';
// import '../infra/model/split_report_model.dart';
// import 'datasource.dart';

// HomeFailure getFailureError(GClientResponse? response) {
//   if (response == null) return SplitsUnkownError();
//   switch (response.statusCode) {
//     case 400:
//       return HomeRequestError(message: response.statusMessage, data: response.data);
//     case 401:
//       return HomeUnauthorizedError(message: response.statusMessage, data: response.data);
//     case 403:
//       return HomeForbiddenError(message: response.statusMessage, data: response.data);
//     case 404:
//       return HomeRequestError(message: response.statusMessage, data: response.data);
//     case 408:
//       return HomeRequestError(message: response.statusMessage, data: response.data);
//     case 500:
//       return HomeInternalError(message: response.statusMessage, data: response.data);
//     default:
//       if (response.statusMessage.toUpperCase() == "OK") response.statusMessage = "Ops, ocorreu um erro";
//       return HomeUnkownError(message: response.statusMessage, code: response.statusCode.toString(), data: response.data);
//   }
// }

// class HomeDatasourceImp implements HomeDatasource {
//   final HttpClientServices api;

//  HomeDatasourceImp({required this.api});

//   @override
//   Future<Either<HomeFailure, Model>> getRecipientsList() async {
//     try {
//       final GClientResponse response = await api.request(apiName: GranitoApiName.portal, endpoint: ApiRoutes.getRecipientsList, method: GHttpMethod.get);
//       if (response.statusCode != 200 || response.data == null || response.data is! Map || response.data['recipients'] == null) {
//         final SplitsFailure failure = getFailureError(response);
//         return left(failure);
//       } else {
//         Model model = Model.fromMap(Map<String, dynamic>.from(response.data));
//         return right(model);
//       }
//     } catch (e) {
//       return left(HomeUnkownError(message: e.toString()));
//     }
//   }

 
// }
