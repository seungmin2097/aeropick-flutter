import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:file_picker/file_picker.dart';
import '../providers/stamp_provider.dart';
import '../providers/user_provider.dart';
import '../theme/aerok_colors.dart';
import '../widgets/aerok_top_app_bar.dart';
import '../widgets/main_bottom_nav_bar.dart';
import 'stamp_earned_screen.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isScanning = false;
  bool _isFlashOn = false;
  bool _isAnalyzingImage = false;

  Future<void> _handleQrCode(String qrCode) async {
    if (_isScanning) return;

    setState(() {
      _isScanning = true;
    });

    final userProvider = context.read<UserProvider>();
    final stampProvider = context.read<StampProvider>();

    // 테스트 용도: 로그인 여부와 상관없이 userId 0번을 사용
    final int userId = userProvider.userId; // 기본값이 0이면 그대로 사용

    // QR 코드로 스탬프 등록
    final userStamp = await stampProvider.scanStamp(
      userId: userId,
      qrCode: qrCode,
    );

    setState(() {
      _isScanning = false;
    });

    if (userStamp != null) {
      // 스탬프 등록 성공
      if (mounted) {
        _controller.stop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const StampEarnedScreen(),
          ),
        );
      }
    } else {
      // 스탬프 등록 실패 (이미 등록됨 또는 유효하지 않은 QR 코드)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('이미 등록된 스탬프이거나 유효하지 않은 QR 코드입니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 파일 탐색기에서 이미지 선택 후 QR 코드 분석
  Future<void> _pickImageAndScan() async {
    if (_isAnalyzingImage) return;

    setState(() {
      _isAnalyzingImage = true;
    });

    try {
      // 파일 탐색기 열기 (이미지 파일만)
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        // 사용자가 취소한 경우
        setState(() {
          _isAnalyzingImage = false;
        });
        return;
      }

      final file = result.files.first;

      // 웹에서는 path 접근 자체가 예외를 발생시키므로, 현재 구조에서는
      // 카메라 스캔만 지원하고 파일로부터 스캔은 안내 메시지만 표시
      if (kIsWeb) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('웹(Chrome)에서는 파일에서 직접 QR 스캔은 지원하지 않고, 카메라 스캔만 가능합니다.'),
              backgroundColor: Colors.red,
            ),
          );
        }
        setState(() {
          _isAnalyzingImage = false;
        });
        return;
      }

      // 선택한 이미지에서 QR 코드 분석 (파일 경로 기반 - 모바일/데스크톱)
      BarcodeCapture? capture;
      if (file.path != null) {
        capture = await _controller.analyzeImage(file.path!);
      } else {
        capture = null;
      }

      final barcodes = capture?.barcodes ?? const <Barcode>[];

      if (barcodes.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('선택한 이미지에서 QR 코드를 찾지 못했습니다.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // 첫 번째 인식된 코드만 사용
        final qr = barcodes.first.rawValue;
        if (qr != null) {
          await _handleQrCode(qr);
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('QR 코드 데이터를 읽지 못했습니다.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('이미지 분석 중 오류가 발생했습니다: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isAnalyzingImage = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AeroKColors.lightGrayBg,
      appBar: const AerokTopAppBar(),
      body: Stack(
        children: [
          // 메인 스캔 영역 (카메라 뷰 + 오버레이)
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 96, // 하단 메뉴 높이만큼 위로 올림
            child: Stack(
              children: [
                // 카메라 뷰
                MobileScanner(
                  controller: _controller,
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      if (barcode.rawValue != null) {
                        _handleQrCode(barcode.rawValue!);
                        break;
                      }
                    }
                  },
                ),
                // 오버레이 (어두운 배경 + 투명한 스캔 영역)
                CustomPaint(
                  painter: _OverlayPainter(
                    scanAreaWidth: 243,
                    scanAreaHeight: 250,
                  ),
                  child: Stack(
                    children: [
                      // 안내 텍스트
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 90,
                        child: Center(
                          child: Text(
                            'QR CODE를 사각형 안에 맞춰주세요.',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 22 / 12,
                              letterSpacing: -0.18,
                              color: AeroKColors.white,
                            ),
                          ),
                        ),
                      ),
                      // 주황색 L자 모서리 브래킷
                      Center(
                        child: SizedBox(
                          width: 243,
                          height: 250,
                          child: Stack(
                            children: [
                              // 왼쪽 상단 (┌)
                              Positioned(
                                left: 0,
                                top: 0,
                                child: CustomPaint(
                                  size: const Size(16, 15),
                                  painter: _CornerBracketPainter(
                                    color: AeroKColors.yellow,
                                    corner: CornerType.topLeft,
                                  ),
                                ),
                              ),
                              // 오른쪽 상단 (┐)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: CustomPaint(
                                  size: const Size(16, 15),
                                  painter: _CornerBracketPainter(
                                    color: AeroKColors.yellow,
                                    corner: CornerType.topRight,
                                  ),
                                ),
                              ),
                              // 왼쪽 하단 (└)
                              Positioned(
                                left: 0,
                                bottom: 0,
                                child: CustomPaint(
                                  size: const Size(16, 16),
                                  painter: _CornerBracketPainter(
                                    color: AeroKColors.yellow,
                                    corner: CornerType.bottomLeft,
                                  ),
                                ),
                              ),
                              // 오른쪽 하단 (┘)
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: CustomPaint(
                                  size: const Size(16, 16),
                                  painter: _CornerBracketPainter(
                                    color: AeroKColors.yellow,
                                    corner: CornerType.bottomRight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // 플래쉬/갤러리 + 테스트 버튼 (하단 고정)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 플래쉬 버튼
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isFlashOn = !_isFlashOn;
                                    _controller.toggleTorch();
                                  });
                                },
                                child: Container(
                                  width: 50.18,
                                  height: 50.18,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AeroKColors.white,
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(
                                    _isFlashOn
                                        ? Icons.flash_on
                                        : Icons.flash_off,
                                    color: AeroKColors.white,
                                    size: 26.18,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '플래쉬',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 22 / 12,
                                  letterSpacing: -0.18,
                                  color: AeroKColors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 60),
                          // 갤러리/파일 탐색기 버튼
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _pickImageAndScan,
                                child: Container(
                                  width: 50.18,
                                  height: 50.18,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AeroKColors.white,
                                      width: 1,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.image,
                                    color: AeroKColors.white,
                                    size: 26.18,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                              _isAnalyzingImage ? '분석 중...' : '갤러리',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 22 / 12,
                                  letterSpacing: -0.18,
                                  color: AeroKColors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // 테스트용 버튼들: QR 없이 여러 스탬프 코드 적립 테스트
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            '테스트로 스탬프 적립하기',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 8,
                            runSpacing: 8,
                            children: List.generate(10, (index) {
                              final code = 'STAMP_${(index + 1).toString().padLeft(3, '0')}';
                              return ElevatedButton(
                                onPressed: () => _handleQrCode(code),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AeroKColors.darkBlue,
                                  foregroundColor: AeroKColors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  code,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Aero Pick! 탭(인덱스 1) 기준 하단 네비게이션 유지
      bottomNavigationBar: const MainBottomNavBar(currentIndex: 1),
    );
  }
}

// 오버레이를 그리는 CustomPainter (중앙 투명 영역)
class _OverlayPainter extends CustomPainter {
  final double scanAreaWidth;
  final double scanAreaHeight;

  _OverlayPainter({
    required this.scanAreaWidth,
    required this.scanAreaHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.31)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final scanArea = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: scanAreaWidth,
      height: scanAreaHeight,
    );

    final scanPath = Path()
      ..addRect(scanArea);

    final combinedPath = Path.combine(
      PathOperation.difference,
      path,
      scanPath,
    );

    canvas.drawPath(combinedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 모서리 타입 정의
enum CornerType {
  topLeft, // ┌
  topRight, // ┐
  bottomLeft, // └
  bottomRight, // ┘
}

// 주황색 L자 모서리 브래킷을 그리는 CustomPainter
class _CornerBracketPainter extends CustomPainter {
  final Color color;
  final CornerType corner;

  _CornerBracketPainter({
    required this.color,
    required this.corner,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path();

    switch (corner) {
      case CornerType.topLeft:
      // ┌ (왼쪽 상단: 왼쪽 세로선 + 위쪽 가로선)
        path.moveTo(0, size.height);
        path.lineTo(0, 0);
        path.lineTo(size.width, 0);
        break;
      case CornerType.topRight:
      // ┐ (오른쪽 상단: 위쪽 가로선 + 오른쪽 세로선)
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);
        path.lineTo(size.width, size.height);
        break;
      case CornerType.bottomLeft:
      // └ (왼쪽 하단: 왼쪽 세로선 + 아래쪽 가로선)
        path.moveTo(0, 0);
        path.lineTo(0, size.height);
        path.lineTo(size.width, size.height);
        break;
      case CornerType.bottomRight:
      // ┘ (오른쪽 하단: 아래쪽 가로선 + 오른쪽 세로선)
        path.moveTo(size.width, 0);
        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height);
        break;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}