import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/payment_bloc/payment_events.dart';
import 'package:sheba_pathway/bloc/payment_bloc/payment_states.dart';
import 'package:sheba_pathway/repository/payment_repository.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;

  PaymentBloc({required this.paymentRepository}) : super(PaymentInitial()) {
    on<StartPayment>((event, emit) async {
      emit(PaymentLoading());
      try {
       await paymentRepository.processPayment(
          event.context,
          event.amount,
          event.email,
          event.phone,
          event.firstName,
          event.lastName,
          event.txRef,
          event.title,
          event.desc,
          event.id
        );
        emit(PaymentSuccess());
      } catch (e) {
        emit(PaymentFailure(e.toString()));
      }
    });
  }
}