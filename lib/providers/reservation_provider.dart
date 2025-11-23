import 'package:flutter/foundation.dart';
import '../models/reservation.dart';
import '../models/passenger.dart';
import '../models/payment.dart';
import '../models/ticket.dart';

class ReservationProvider with ChangeNotifier {
  List<Reservation> _reservations = [];
  List<Passenger> _passengers = [];
  List<Payment> _payments = [];
  List<Ticket> _tickets = [];
  int _nextReservationId = 1;
  int _nextPassengerId = 1;
  int _nextPaymentId = 1;
  int _nextTicketId = 1;

  List<Reservation> get reservations => _reservations;
  List<Passenger> get passengers => _passengers;
  List<Payment> get payments => _payments;
  List<Ticket> get tickets => _tickets;

  // 사용자별 예약 조회
  List<Reservation> getReservationsByUserId(int userId) {
    return _reservations.where((r) => r.fkUserId == userId).toList();
  }

  // 예약 생성
  Future<Reservation> createReservation({
    required int userId,
    required String status,
  }) async {
    final reservation = Reservation(
      reservationId: _nextReservationId++,
      fkUserId: userId,
      reservationStatus: status,
    );
    _reservations.add(reservation);
    notifyListeners();
    return reservation;
  }

  // 승객 추가
  Future<Passenger> addPassenger({
    required int reservationId,
    required String passengerName,
    DateTime? birthDate,
    String? gender,
    String? nationality,
  }) async {
    final passenger = Passenger(
      passengerId: _nextPassengerId++,
      fkReservationId: reservationId,
      passengerName: passengerName,
      birthDate: birthDate,
      gender: gender,
      nationality: nationality,
    );
    _passengers.add(passenger);
    notifyListeners();
    return passenger;
  }

  // 결제 추가
  Future<Payment> addPayment({
    required int reservationId,
    required int amount,
  }) async {
    final payment = Payment(
      paymentId: _nextPaymentId++,
      fkReservationId: reservationId,
      amount: amount,
      paidAt: DateTime.now(),
    );
    _payments.add(payment);
    notifyListeners();
    return payment;
  }

  // 티켓 발행
  Future<Ticket> issueTicket({
    required int passengerId,
    required int flightId,
    String? seatNo,
    String status = 'issued',
  }) async {
    final ticket = Ticket(
      ticketId: _nextTicketId++,
      fkPassengerId: passengerId,
      fkFlightId: flightId,
      seatNo: seatNo,
      ticketStatus: status,
      issuedAt: DateTime.now(),
    );
    _tickets.add(ticket);
    notifyListeners();
    return ticket;
  }

  // 예약 상태 업데이트
  void updateReservationStatus(int reservationId, String status) {
    final index = _reservations.indexWhere((r) => r.reservationId == reservationId);
    if (index != -1) {
      _reservations[index] = Reservation(
        reservationId: _reservations[index].reservationId,
        fkUserId: _reservations[index].fkUserId,
        reservationStatus: status,
      );
      notifyListeners();
    }
  }

  // 예약 취소
  void cancelReservation(int reservationId) {
    updateReservationStatus(reservationId, 'cancelled');
  }
}



