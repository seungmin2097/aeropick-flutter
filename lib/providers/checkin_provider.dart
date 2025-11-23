import 'package:flutter/foundation.dart';
import '../models/checkin.dart';
import '../models/boarding_pass.dart';

class CheckinProvider with ChangeNotifier {
  List<Checkin> _checkins = [];
  List<BoardingPass> _boardingPasses = [];
  int _nextCheckinId = 1;
  int _nextBoardingPassId = 1;

  List<Checkin> get checkins => _checkins;
  List<BoardingPass> get boardingPasses => _boardingPasses;

  // 티켓 ID로 체크인 조회
  Checkin? getCheckinByTicketId(int ticketId) {
    try {
      return _checkins.firstWhere((c) => c.fkTicketId == ticketId);
    } catch (e) {
      return null;
    }
  }

  // 체크인 생성
  Future<Checkin> createCheckin({
    required int ticketId,
    required String channel,
    String? seatNo,
  }) async {
    final checkin = Checkin(
      checkinId: _nextCheckinId++,
      fkTicketId: ticketId,
      checkinTime: DateTime.now(),
      checkinChannel: channel,
      seatNo: seatNo,
    );
    _checkins.add(checkin);
    notifyListeners();
    return checkin;
  }

  // 탑승권 생성
  Future<BoardingPass> createBoardingPass({
    required int checkinId,
    required String qrCodeValue,
  }) async {
    final boardingPass = BoardingPass(
      boardingPassId: _nextBoardingPassId++,
      fkCheckinId: checkinId,
      qrCodeValue: qrCodeValue,
      issuedAt: DateTime.now(),
    );
    _boardingPasses.add(boardingPass);
    notifyListeners();
    return boardingPass;
  }

  // 체크인 및 탑승권 발급 (한 번에)
  Future<BoardingPass?> checkinAndIssueBoardingPass({
    required int ticketId,
    required String channel,
    String? seatNo,
  }) async {
    final checkin = await createCheckin(
      ticketId: ticketId,
      channel: channel,
      seatNo: seatNo,
    );

    // QR 코드 생성 (간단한 형식)
    final qrCodeValue = 'BP_${checkin.checkinId}_${DateTime.now().millisecondsSinceEpoch}';

    return await createBoardingPass(
      checkinId: checkin.checkinId,
      qrCodeValue: qrCodeValue,
    );
  }

  // 체크인 ID로 탑승권 조회
  BoardingPass? getBoardingPassByCheckinId(int checkinId) {
    try {
      return _boardingPasses.firstWhere((bp) => bp.fkCheckinId == checkinId);
    } catch (e) {
      return null;
    }
  }
}



