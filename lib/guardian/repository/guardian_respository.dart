import 'package:my_childrens_voice_app/api/api.dart';

class GuardianRepository {
  const GuardianRepository(this._client);

  final RestApiClient _client;

  List<String> getRecordingSentenceList() {
    return [
      '그는 괜찮은 척 하려고 애쓰는 것 같았다',
      '그녀의 사랑을 얻기 위해 애썼지만 헛수고였다',
      '용돈을 아껴 써라',
      '그는 아내를 많이 아낀다',
      '그 애 전화번호 알아?',
      '차에 대해 잘 아세요?',
      '거기 도착하면 나한테 알려줘',
      '그들은 내가 시험에 떨어졌다고 알려 왔다',
      '나는 살아오면서 감기를 앓은 적이 한 번도 없다',
      '사흘 동안 심하게 몸살을 앓았어요',
      '요즘 공부가 안 돼요',
      '장사가 잘 안돼서 우울해',
      '그녀는 이유를 묻지 않고 돈을 빌려 주었다',
      '내가 아기를 안고 있을게',
      '엄마는 말없이 나를 꼭 안아 주셨다',
      '자리에 앉으세요',
      '한 여자가 내 옆에 앉았다',
      '114에 전화를 해서 번호를 알아보시지 그러세요?',
      '그는 절대 다른 사람의 의견을 받아들이지 않는다',
      '어디에서 영어를 배우셨어요?',
      '이거 다른 걸로 바꿀 수 있을까요?',
      '색깔을 바꾸는 게 나을 거 같아',
      '소영이 좀 바꿔 주세요',
      '눈이 얼음으로 바뀌었어',
      '핸드폰이 네 거랑 바뀐 거 같아',
      '그 차는 들판에 버려진 채 발견됐다',
      '이번 달 초에 상어떼가 해안가에서 발견됐다',
      '오타를 발견하시는 분께 사례하겠습니다',
      '정신분석학은 20세기에 급격히 발전했다',
      '한국어 실력이 날이 갈수록 발전하는 것을 보니 기쁩니다',
      '죄송하지만 제 이름을 밝힐 수는 없어요',
      '정전이 되어 촛불을 밝혔다',
      '모두가 시험에 통과했음을 발표하게 되어 기쁘게 생각합니다',
      '그 밴드는 첫 음반을 발표한 직후에 해체했다',
      '화재가 발생하지 않도록 조심해라',
      '어제 일본에서 태풍이 발생했다',
      '돌고래는 지능이 발달했다',
      '이 지역에는 농업이 발달했어요',
      '그녀는 내 제안에 반대했다',
      '저는 무력 사용을 반대합니다',
      '밤늦게 남의 집을 방문하는 것은 실례다',
      '저희 회사에 방문해 주셔서 감사드립니다',
      '너는 브레이크를 너무 세게 밟아',
      '어떤 남자가 지하철에서 내 발을 밟고 모른 척했다',
      '그녀는 호기심으로 가득찬 눈으로 나를 바라보았다',
      '이 문제는 제3자의 시각에서 바라볼 필요가 있어',
      '저한테 너무 많은 걸 바라지 마세요',
      '빨리 나으시길 바랍니다',
      '입술에 침이나 바르고 말해',
      '나는 생일 선물로 책을 받았다',
    ];
  }

  Future<int> checkVoiceModelExists() async {
    // temp: 0 - no model, 1 - training, 2 - exists
    return 2;
  }

  Future<List<String>> fetchSentMessages() async {
    return [
      // '엄마 사랑해. 밥 먹었어?',
      // '엄마 사랑해. 밥 먹었어?',
      // '엄마 사랑해. 밥 먹었어?',
    ];
  }
}