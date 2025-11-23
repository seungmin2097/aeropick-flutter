import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/aerok_colors.dart';
import '../widgets/aerok_top_app_bar.dart';
import '../providers/flight_provider.dart';
import '../providers/stamp_provider.dart';
import '../providers/user_provider.dart';
import 'flight_booking_calendar_screen.dart';

/// 항공권 예매 메인 화면 (왕복/편도 + 출발/도착 + 날짜/인원 + 프로모션 코드)
class FlightBookingScreen extends StatefulWidget {
  const FlightBookingScreen({super.key});

  @override
  State<FlightBookingScreen> createState() => _FlightBookingScreenState();
}

class _FlightBookingScreenState extends State<FlightBookingScreen> {
  bool isRoundTrip = true;

  // 출발/도착지
  String? _departure = '출발';
  String? _arrival = '도착';

  // 인원 수
  int _adultCount = 1;
  int _childCount = 0; // 소아
  int _infantCount = 0; // 유아

  // 날짜 (초기값: 선택 안됨)
  DateTime? _departureDate = null;
  DateTime? _returnDate = null;

  // 총 결제 금액
  int? _totalPrice;
  bool _isLoadingPrice = false;

  // 프로모션 코드 및 쿠폰
  final TextEditingController _promoCodeController = TextEditingController();
  String? _appliedPromoCode;
  bool _hasCoupon = false; // 쿠폰 보유 여부
  int _discountAmount = 0; // 할인 금액
  double? _couponDiscountRate; // 쿠폰 할인율 (0.3 = 30%, 1.0 = 100%)
  bool _showPromoCodeInput = false; // 프로모션 코드 입력 필드 표시 여부

  String _formatDate(DateTime date) {
    const weekDays = ['월', '화', '수', '목', '금', '토', '일'];
    final w = weekDays[date.weekday - 1];
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}($w)';
  }

  /// 가격 정보 업데이트 (더미 가격 계산)
  void _updateTotalPrice() {
    if (_departure == null || _arrival == null || _departureDate == null) {
      setState(() {
        _totalPrice = null;
        _isLoadingPrice = false;
      });
      return;
    }

    final passengers = _adultCount + _childCount; // 유아는 무료이므로 계산에서 제외
    if (passengers == 0) {
      setState(() {
        _totalPrice = null;
        _isLoadingPrice = false;
      });
      return;
    }

    // 더미 가격 계산 (거리 기반)
    int basePrice = 0;
    
    // 공항 코드 추출
    final depCode = _departure?.split(' ').last ?? '';
    final arrCode = _arrival?.split(' ').last ?? '';
    
    // 출발지-도착지 조합에 따른 기본 가격
    if (depCode == 'ICN' && arrCode == 'CJU') {
      basePrice = 120000; // 인천-제주
    } else if (depCode == 'ICN' && (arrCode == 'NRT' || arrCode == 'KIX' || arrCode == 'NGO' || arrCode == 'OKA' || arrCode == 'FUK' || arrCode == 'CTS' || arrCode == 'IBR' || arrCode == 'OBO' || arrCode == 'KKJ' || arrCode == 'HIJ')) {
      basePrice = 450000; // 인천-일본
    } else if (depCode == 'ICN' && arrCode == 'CJJ') {
      basePrice = 80000; // 인천-청주
    } else if (depCode == 'CJJ' && arrCode == 'CJU') {
      basePrice = 150000; // 청주-제주
    } else if (depCode == 'CJJ' && (arrCode == 'NRT' || arrCode == 'KIX' || arrCode == 'NGO' || arrCode == 'OKA' || arrCode == 'FUK' || arrCode == 'CTS' || arrCode == 'IBR' || arrCode == 'OBO' || arrCode == 'KKJ' || arrCode == 'HIJ')) {
      basePrice = 480000; // 청주-일본
    } else if (depCode == 'CJU' && (arrCode == 'NRT' || arrCode == 'KIX' || arrCode == 'NGO' || arrCode == 'OKA' || arrCode == 'FUK' || arrCode == 'CTS' || arrCode == 'IBR' || arrCode == 'OBO' || arrCode == 'KKJ' || arrCode == 'HIJ')) {
      basePrice = 500000; // 제주-일본
    } else if (depCode == 'ICN' && (arrCode == 'TPE' || arrCode == 'HUN' || arrCode == 'RMQ' || arrCode == 'TAO')) {
      basePrice = 350000; // 인천-동북아시아
    } else if (depCode == 'ICN' && (arrCode == 'CEB' || arrCode == 'DAD' || arrCode == 'CXR' || arrCode == 'CRK')) {
      basePrice = 400000; // 인천-동남아시아
    } else {
      // 기본 가격
      basePrice = 200000;
    }
    
    // 왕복인 경우
    if (isRoundTrip && _returnDate != null) {
      setState(() {
        _totalPrice = (basePrice * 2 * passengers);
        // 쿠폰이 적용되어 있으면 할인 금액 재계산
        if (_hasCoupon && _totalPrice != null && _couponDiscountRate != null) {
          if (_couponDiscountRate == 1.0) {
            _discountAmount = _totalPrice!;
          } else {
            _discountAmount = (_totalPrice! * _couponDiscountRate!).toInt();
          }
        }
        _isLoadingPrice = false;
      });
    } else {
      // 편도인 경우
      setState(() {
        _totalPrice = (basePrice * passengers);
        // 쿠폰이 적용되어 있으면 할인 금액 재계산
        if (_hasCoupon && _totalPrice != null && _couponDiscountRate != null) {
          if (_couponDiscountRate == 1.0) {
            _discountAmount = _totalPrice!;
          } else {
            _discountAmount = (_totalPrice! * _couponDiscountRate!).toInt();
          }
        }
        _isLoadingPrice = false;
      });
    }
  }

  // 출발지별 가능한 도착지 목록
  List<String> _getAvailableDestinations(String? departure) {
    if (departure == null) return [];
    
    final depCode = departure.split(' ').last;
    
    switch (depCode) {
      case 'CJJ': // 청주 - 서울/인천, 화롄 제외하고 모두 가능
        return []; // 빈 리스트는 모든 목적지 가능을 의미 (제외 목록은 별도 처리)
      case 'CJU': // 제주
        return ['청주 CJJ', '히로시마 HIJ'];
      case 'ICN': // 서울/인천
        return ['이바라키 IBR', '오사카/간사이 KIX', '오비히로 OBO'];
      case 'NRT': // 도쿄/나리타
        return ['청주 CJJ'];
      case 'IBR': // 이바라키
        return ['청주 CJJ', '서울/인천 ICN'];
      case 'KIX': // 오사카/간사이
        return ['청주 CJJ', '서울/인천 ICN'];
      case 'CTS': // 삿포로/신치토세
        return ['청주 CJJ'];
      case 'OBO': // 오비히로
        return ['청주 CJJ', '서울/인천 ICN'];
      case 'FUK': // 후쿠오카
        return ['청주 CJJ'];
      case 'KKJ': // 기타큐슈
        return ['청주 CJJ'];
      case 'HIJ': // 히로시마
        return ['청주 CJJ', '제주 CJU'];
      case 'OKA': // 오키나와
        return ['청주 CJJ'];
      case 'NGO': // 나고야
        return ['청주 CJJ'];
      case 'TPE': // 타이베이/타오위안
        return ['청주 CJJ'];
      case 'HUN': // 화롄
        return ['서울/인천 ICN'];
      case 'RMQ': // 타이중
        return ['청주 CJJ'];
      case 'TAO': // 칭다오
        return ['청주 CJJ'];
      case 'CEB': // 세부
        return ['청주 CJJ'];
      case 'DAD': // 다낭
        return ['청주 CJJ'];
      case 'CXR': // 나트랑
        return ['청주 CJJ'];
      case 'CRK': // 클락
        return ['청주 CJJ'];
      default:
        return []; // 기본적으로 모든 목적지 가능 (또는 빈 리스트)
    }
  }

  void _showLocationPicker(BuildContext context, bool isDeparture) {
    // 지역별 여행지 목록
    final locationGroups = [
      {
        'region': '대한민국',
        'locations': [
          {'name': '청주', 'code': 'CJJ'},
          {'name': '제주', 'code': 'CJU'},
          {'name': '서울/인천', 'code': 'ICN'},
        ],
      },
      {
        'region': '일본',
        'locations': [
          {'name': '도쿄/나리타', 'code': 'NRT'},
          {'name': '이바라키', 'code': 'IBR'},
          {'name': '오사카/간사이', 'code': 'KIX'},
          {'name': '삿포로/신치토세', 'code': 'CTS'},
          {'name': '오비히로', 'code': 'OBO'},
          {'name': '후쿠오카', 'code': 'FUK'},
          {'name': '기타큐슈', 'code': 'KKJ'},
          {'name': '히로시마', 'code': 'HIJ'},
          {'name': '오키나와', 'code': 'OKA'},
          {'name': '나고야', 'code': 'NGO'},
        ],
      },
      {
        'region': '동북아시아',
        'locations': [
          {'name': '타이베이/타오위안', 'code': 'TPE'},
          {'name': '화롄', 'code': 'HUN'},
          {'name': '타이중', 'code': 'RMQ'},
          {'name': '칭다오', 'code': 'TAO'},
        ],
      },
      {
        'region': '동남아시아',
        'locations': [
          {'name': '세부', 'code': 'CEB'},
          {'name': '다낭', 'code': 'DAD'},
          {'name': '나트랑', 'code': 'CXR'},
          {'name': '클락', 'code': 'CRK'},
        ],
      },
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 헤더
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isDeparture ? '출발지 선택' : '도착지 선택',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // 지역별 확장 가능한 리스트
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: locationGroups.length,
                itemBuilder: (context, groupIndex) {
                  final group = locationGroups[groupIndex];
                  final region = group['region'] as String;
                  final locations = group['locations'] as List<Map<String, String>>;
                  
                  return ExpansionTile(
                    title: Text(
                      region,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: locations.map((location) {
                      final locationName = location['name']!;
                      final locationCode = location['code']!;
                      final fullName = '$locationName $locationCode';

                      // 출발지 선택 시: 도착지와 같으면 선택 불가
                      // 도착지 선택 시: 출발지와 같으면 선택 불가 + 출발지에서 갈 수 없는 곳이면 선택 불가
                      bool isDisabled = false;
                      if (isDeparture) {
                        isDisabled = (fullName == _arrival);
                      } else {
                        isDisabled = (fullName == _departure);
                        // 도착지 선택 시, 출발지가 선택되어 있으면 가능한 도착지만 허용
                        if (!isDisabled && _departure != null) {
                          final departureCode = _departure!.split(' ').last;
                          
                          // 청주(CJJ)의 경우: 서울/인천(ICN), 화롄(HUN) 제외하고 모두 가능
                          if (departureCode == 'CJJ') {
                            if (locationCode == 'ICN' || locationCode == 'HUN') {
                              isDisabled = true;
                            }
                          } else {
                            // 다른 출발지의 경우 기존 로직 사용
                            final availableDestinations = _getAvailableDestinations(_departure);
                            if (availableDestinations.isNotEmpty) {
                              isDisabled = !availableDestinations.contains(fullName);
                            }
                          }
                        }
                      }

                      return ListTile(
                        title: Text(fullName),
                        enabled: !isDisabled,
                        onTap: isDisabled
                            ? null
                            : () {
                                setState(() {
                                  if (isDeparture) {
                                    _departure = fullName;
                                    // 출발지 변경 시 도착지가 불가능하면 초기화
                                    if (_arrival != null) {
                                      final newDepCode = fullName.split(' ').last;
                                      
                                      // 청주(CJJ)의 경우: 서울/인천(ICN), 화롄(HUN) 제외하고 모두 가능
                                      if (newDepCode == 'CJJ') {
                                        final arrCode = _arrival!.split(' ').last;
                                        if (arrCode == 'ICN' || arrCode == 'HUN') {
                                          _arrival = null;
                                        }
                                      } else {
                                        // 다른 출발지의 경우 기존 로직 사용
                                        final availableDestinations = _getAvailableDestinations(fullName);
                                        if (availableDestinations.isNotEmpty && 
                                            !availableDestinations.contains(_arrival!)) {
                                          _arrival = null;
                                        }
                                      }
                                    }
                                  } else {
                                    _arrival = fullName;
                                  }
                                });
                                Navigator.pop(context);
                                // 가격 정보 업데이트
                                _updateTotalPrice();
                              },
                        trailing: isDisabled
                            ? const Icon(Icons.block, color: Colors.grey)
                            : null,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPassengerPicker(BuildContext context) {
    int tempAdult = _adultCount;
    int tempChild = _childCount;
    int tempInfant = _infantCount;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 헤더 (닫기 버튼 포함)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                        '탑승 인원 선택',
                    style: TextStyle(
                          fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // 성인
                  _buildPassengerRow(
                    context: context,
                    label: '성인',
                    ageCriteria: '국내선 : 만 13세, 국제선 : 만 12세 이상',
                    count: tempAdult,
                    onDecrease: tempAdult > 1
                        ? () {
                            setModalState(() {
                              tempAdult--;
                            });
                          }
                        : null,
                    onIncrease: () {
                      setModalState(() {
                        tempAdult++;
                      });
                    },
                  ),
                  const Divider(height: 1),
                  // 소아
                  _buildPassengerRow(
                    context: context,
                    label: '소아',
                    ageCriteria: '국내선 : 24개월 이상 만 13세 미만 / 국제선 : 24개월 이상 만 12세 미만',
                    count: tempChild,
                    onDecrease: tempChild > 0
                        ? () {
                            setModalState(() {
                              tempChild--;
                            });
                          }
                        : null,
                    onIncrease: () {
                      setModalState(() {
                        tempChild++;
                      });
                    },
                  ),
                  const Divider(height: 1),
                  // 유아
                  _buildPassengerRow(
                    context: context,
                    label: '유아',
                    ageCriteria: '24개월 미만',
                    count: tempInfant,
                    onDecrease: tempInfant > 0
                        ? () {
                            setModalState(() {
                              tempInfant--;
                            });
                          }
                        : null,
                    onIncrease: () {
                      setModalState(() {
                        tempInfant++;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // 나이계산기 (선택사항)
                  InkWell(
                    onTap: () {
                      // 나이계산기 기능 (선택사항)
                    },
                    child: Row(
                      children: [
                        const Text(
                          '나이계산기',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _adultCount = tempAdult;
                          _childCount = tempChild;
                          _infantCount = tempInfant;
                        });
                        Navigator.pop(context);
                        // 가격 정보 업데이트
                        _updateTotalPrice();
                      },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AeroKColors.darkNavy,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('확인'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPassengerRow({
    required BuildContext context,
    required String label,
    required String ageCriteria,
    required int count,
    required VoidCallback? onDecrease,
    required VoidCallback onIncrease,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ageCriteria,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Row(
            children: [
              // 마이너스 버튼 (회색)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: IconButton(
                  onPressed: onDecrease,
                  icon: const Icon(Icons.remove, size: 20),
                  color: onDecrease != null ? Colors.black : Colors.grey[400],
                  padding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(width: 16),
              // 카운트 표시
              SizedBox(
                width: 30,
                child: Text(
                  '$count',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // 플러스 버튼 (파란색 테두리)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: AeroKColors.darkBlue, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: IconButton(
                  onPressed: onIncrease,
                  icon: const Icon(Icons.add, size: 20),
                  color: AeroKColors.darkBlue,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _buildPassengerText() {
    final List<String> parts = [];
    if (_adultCount > 0) {
      parts.add('성인 $_adultCount');
    }
    if (_childCount > 0) {
      parts.add('소아 $_childCount');
    }
    if (_infantCount > 0) {
      parts.add('유아 $_infantCount');
    }
    return parts.isEmpty ? '성인 1' : parts.join(', ');
  }

  void _showCouponDialog(BuildContext context) {
    // 현재 사용자의 스탬프 개수 확인
    final userProvider = context.read<UserProvider>();
    final stampProvider = context.read<StampProvider>();
    final int userId = userProvider.userId;
    final int collectedCount = stampProvider.getUserStampsByUserId(userId).length;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          '쿠폰 선택',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 30% 할인 쿠폰 (스탬프 5개 이상일 때만 표시)
              if (collectedCount >= 5)
                _buildCouponItem(
                  context: context,
                  title: '30% 할인 쿠폰',
                  description: '스탬프 5개 달성 보상',
                  discount: 0.3,
                  onTap: () {
                    setState(() {
                      _hasCoupon = true;
                      _couponDiscountRate = 0.3;
                      if (_totalPrice != null) {
                        _discountAmount = (_totalPrice! * 0.3).toInt();
                      }
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('30% 할인 쿠폰이 적용되었습니다.'),
                        backgroundColor: AeroKColors.darkBlue,
                      ),
                    );
                  },
                ),
              // 두 쿠폰이 모두 표시될 때만 스페이서 추가
              if (collectedCount >= 5 && collectedCount >= 10)
                const SizedBox(height: 12),
              // 왕복 항공권 쿠폰 (100% 할인, 스탬프 10개 이상일 때만 표시)
              if (collectedCount >= 10)
                _buildCouponItem(
                  context: context,
                  title: '왕복 항공권 1인 2매',
                  description: '스탬프 10개 달성 보상',
                  discount: 1.0,
                  onTap: () {
                    setState(() {
                      _hasCoupon = true;
                      _couponDiscountRate = 1.0;
                      if (_totalPrice != null) {
                        _discountAmount = _totalPrice!;
                      }
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('왕복 항공권 쿠폰이 적용되었습니다.'),
                        backgroundColor: AeroKColors.darkBlue,
                      ),
                    );
                  },
                ),
              // 쿠폰이 없을 때 안내 메시지
              if (collectedCount < 5)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 48,
                        color: AeroKColors.gray,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '사용 가능한 쿠폰이 없습니다.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AeroKColors.gray,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '스탬프를 모아 쿠폰을 받아보세요!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AeroKColors.gray,
                        ),
                      ),
                      if (collectedCount < 5)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            '30% 할인 쿠폰: ${5 - collectedCount}개 더 필요',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: AeroKColors.gray,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              '취소',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponItem({
    required BuildContext context,
    required String title,
    required String description,
    required double discount,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AeroKColors.yellow.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AeroKColors.yellow,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.local_offer,
              color: AeroKColors.yellow,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AeroKColors.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AeroKColors.gray,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              discount == 1.0
                  ? '무료'
                  : '${(discount * 100).toInt()}% 할인',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AeroKColors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // 화면 로드 시 가격 정보 업데이트
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_departure != null && _arrival != null && _departureDate != null) {
        _updateTotalPrice();
      }
    });
  }

  @override
  void dispose() {
    _promoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AeroKColors.white,
      appBar: const AerokTopAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const SizedBox(height: 16),
              // 왕복 / 편도 토글
              Container(
                height: 44,
                decoration: BoxDecoration(
                  color: AeroKColors.chartGray,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    _TripTypeButton(
                      selected: isRoundTrip,
                      label: '왕복',
                      onTap: () {
                        setState(() {
                          isRoundTrip = true;
                        });
                        // 가격 정보 업데이트
                        _updateTotalPrice();
                      },
                    ),
                    _TripTypeButton(
                      selected: !isRoundTrip,
                      label: '편도',
                      onTap: () {
                        setState(() {
                          isRoundTrip = false;
                          // 편도로 전환 시 도착 날짜는 사용하지 않으므로 초기화
                          _returnDate = null;
                        });
                        // 가격 정보 업데이트
                        _updateTotalPrice();
              },
            ),
          ],
        ),
      ),
              const SizedBox(height: 24),
              // 출발 / 도착 카드
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: AeroKColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 14.7,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 출발지 선택 영역
                        GestureDetector(
                          onTap: () => _showLocationPicker(context, true),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLocationText(_departure, true),
                              const SizedBox(height: 2),
                              Text(
                                'From',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AeroKColors.gray,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 위치 변경 버튼
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              final temp = _departure;
                              _departure = _arrival;
                              _arrival = temp;
                            });
                            // 가격 정보 업데이트
                            _updateTotalPrice();
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AeroKColors.black),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.swap_horiz,
                                size: 18,
                                color: AeroKColors.gray,
                              ),
                            ),
                          ),
                        ),
                        // 도착지 선택 영역
                        GestureDetector(
                          onTap: () => _showLocationPicker(context, false),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildLocationText(_arrival, false),
                              const SizedBox(height: 2),
                              Text(
                                'To',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AeroKColors.gray,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(color: AeroKColors.lightGray),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FlightBookingCalendarScreen(
                              initialDeparture: _departureDate,
                              initialReturn: _returnDate,
                              isRoundTrip: isRoundTrip,
                            ),
                          ),
                        );

                        if (result is Map<String, DateTime?>) {
                          setState(() {
                            _departureDate = result['departure'];
                            _returnDate = result['return'];
                          });
                          // 가격 정보 업데이트
                          _updateTotalPrice();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 출발 날짜 (왼쪽)
                          Expanded(
                            child: Text(
                              _departureDate == null
                                  ? '가는날'
                                  : _formatDate(_departureDate!),
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: _departureDate == null
                                    ? AeroKColors.gray
                                    : AeroKColors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // 편도: 가는날만, 왕복: 가는날 + 오는날
                          if (isRoundTrip)
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Text(
                                      _returnDate == null
                                          ? '오는날'
                                          : _formatDate(_returnDate!),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: _returnDate == null
                                            ? AeroKColors.gray
                                            : AeroKColors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    size: 18,
                                    color: AeroKColors.gray,
                                  ),
                                ],
                              ),
                            )
                          else
                            const Icon(
                              Icons.calendar_today_outlined,
                              size: 18,
                              color: AeroKColors.gray,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // 성인 인원 선택 영역
              GestureDetector(
                onTap: () => _showPassengerPicker(context),
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AeroKColors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8.8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _buildPassengerText(),
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const Icon(
                        Icons.person_outline,
                        color: AeroKColors.gray,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // 프로모션 코드 입력 영역 (토글 방식)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showPromoCodeInput = !_showPromoCodeInput;
                    // 닫을 때 입력 필드 초기화
                    if (!_showPromoCodeInput) {
                      _promoCodeController.clear();
                      _appliedPromoCode = null;
                      if (!_hasCoupon) {
                        _discountAmount = 0;
                      }
                    }
                  });
                },
                child: Row(
                  children: [
                    Text(
                      '프로모션 코드 입력',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AeroKColors.gray,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      _showPromoCodeInput
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 20,
                      color: AeroKColors.gray,
                    ),
                  ],
                ),
              ),
              if (_showPromoCodeInput) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _promoCodeController,
                        decoration: InputDecoration(
                          hintText: '프로모션 코드를 입력하세요',
                          hintStyle: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: AeroKColors.gray,
                          ),
                          filled: true,
                          fillColor: AeroKColors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AeroKColors.gray.withOpacity(0.3),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AeroKColors.gray.withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AeroKColors.darkBlue,
                              width: 2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        final code = _promoCodeController.text.trim();
                        if (code.isNotEmpty) {
                          setState(() {
                            _appliedPromoCode = code;
                            // 프로모션 코드 적용 로직 (예: 10% 할인)
                            if (_totalPrice != null) {
                              _discountAmount = (_totalPrice! * 0.1).toInt();
                            }
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('프로모션 코드 "$code"가 적용되었습니다.'),
                              backgroundColor: AeroKColors.darkBlue,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AeroKColors.darkBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        '적용',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ] else
                const SizedBox(height: 16),
              // 쿠폰 사용 영역
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.local_offer,
                        size: 20,
                        color: AeroKColors.yellow,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '쿠폰 사용하기',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AeroKColors.darkBlue,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // 쿠폰 선택 다이얼로그 표시
                      _showCouponDialog(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _hasCoupon
                            ? AeroKColors.yellow
                            : AeroKColors.lightGray,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _hasCoupon ? '쿠폰 적용됨' : '쿠폰 선택',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _hasCoupon
                              ? AeroKColors.darkBlue
                              : AeroKColors.gray,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (_hasCoupon && _discountAmount > 0) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AeroKColors.yellow.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AeroKColors.yellow,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: AeroKColors.yellow,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '쿠폰 할인: ${_discountAmount.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AeroKColors.darkBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              // 가격 정보 표시 (로딩 중이거나 가격이 있을 때)
              if (_isLoadingPrice || _totalPrice != null) ...[
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AeroKColors.darkNavy,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: _isLoadingPrice
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_totalPrice != null) ...[
                              if (_discountAmount > 0)
                                Text(
                                  '할인 전: ${_totalPrice!.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withOpacity(0.7),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              Text(
                                '총 결제 금액 KRW ${(_totalPrice! - _discountAmount).toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ] else
                              const Text(
                                '총 결제 금액',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                ),
                const SizedBox(height: 24),
              ],
            ],
            ),
          ),
        ),
      ),
    );
  }

  // 지역명과 영문 코드를 분리하여 표시하는 위젯
  Widget _buildLocationText(String? location, bool isLeftAlign) {
    if (location == null || location == '출발' || location == '도착') {
      return Text(
        location ?? (isLeftAlign ? '출발' : '도착'),
        textAlign: isLeftAlign ? TextAlign.left : TextAlign.right,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AeroKColors.gray,
        ),
      );
    }

    // "CJU 제주" 또는 "제주 CJU" 형식 파싱
    final parts = location.split(' ');
    String cityName = '';
    String code = '';

    if (parts.length >= 2) {
      // 마지막 부분이 영문 코드인지 확인 (대문자 3글자)
      final lastPart = parts.last;
      if (lastPart.length == 3 && lastPart == lastPart.toUpperCase() && 
          lastPart.contains(RegExp(r'^[A-Z]+$'))) {
        code = lastPart;
        cityName = parts.sublist(0, parts.length - 1).join(' ');
      } else {
        // 첫 번째 부분이 영문 코드인지 확인
        final firstPart = parts.first;
        if (firstPart.length == 3 && firstPart == firstPart.toUpperCase() && 
            firstPart.contains(RegExp(r'^[A-Z]+$'))) {
          code = firstPart;
          cityName = parts.sublist(1).join(' ');
        } else {
          // 영문 코드를 찾지 못한 경우 전체를 지역명으로 표시
          cityName = location;
        }
      }
    } else {
      cityName = location;
    }

    // 지역명 길이에 따라 폰트 크기 조정
    double fontSize = 24;
    if (cityName.length > 8) {
      fontSize = 18; // 긴 이름 (9자 이상)
    } else if (cityName.length > 5) {
      fontSize = 20; // 중간 이름 (6-8자)
    }

    return Column(
      crossAxisAlignment: isLeftAlign ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          cityName,
          textAlign: isLeftAlign ? TextAlign.left : TextAlign.right,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: AeroKColors.darkBlue,
          ),
        ),
        if (code.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            code,
            textAlign: isLeftAlign ? TextAlign.left : TextAlign.right,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AeroKColors.gray,
            ),
          ),
        ],
      ],
    );
  }
}

class _TripTypeButton extends StatelessWidget {
  final bool selected;
  final String label;
  final VoidCallback onTap;

  const _TripTypeButton({
    required this.selected,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: selected ? AeroKColors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: selected
                ? Border.all(color: AeroKColors.darkBlue, width: 1)
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: selected ? AeroKColors.darkBlue : AeroKColors.gray,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


