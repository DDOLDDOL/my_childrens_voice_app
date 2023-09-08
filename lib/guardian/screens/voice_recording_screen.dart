import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:my_childrens_voice_app/common/commons.dart';
import 'package:my_childrens_voice_app/guardian/guardian.dart';
import 'package:my_childrens_voice_app/home/home.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets/widgets.dart';

// TODO: state [needPermissionCheck] => [checkingPermission] 으로 수정
// TODO: 권한이 거부되었을 떄 화면 제작
class VoiceRecordingScreen extends StatefulWidget {
  const VoiceRecordingScreen({Key? key}) : super(key: key);

  @override
  State<VoiceRecordingScreen> createState() => _VoiceRecordingScreenState();
}

class _VoiceRecordingScreenState extends State<VoiceRecordingScreen> {
  @override
  void initState() {
    super.initState();
    _clearCacheFiles();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SentenceCubit(context.read<GuardianRepository>())
            ..getRecordingSentenceList(),
        ),
        BlocProvider(
          create: (_) => RecorderBloc(
            RecorderRepository(FlutterSoundRecorder()),
          )..add(const RecorderEvent.permissionCheckRequested()),
        ),
        BlocProvider(
          create: (_) => AudioPlayerBLoc(AudioPlayerRepository(AudioPlayer())),
        ),
        BlocProvider(
          create: (_) => AudioFileDetectCubit(context.read<HomeRepository>()),
        ),
      ],
      child: const _MultiBLocListeners(child: _VoiceRecordingView()),
    );
  }

  Future<void> _clearCacheFiles() async {
    final cacheDirectory = await getApplicationCacheDirectory();

    for (var file in cacheDirectory.listSync()) {
      await file.delete();
    }
  }
}

class _VoiceRecordingView extends StatelessWidget {
  const _VoiceRecordingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16).copyWith(top: 0),
          child: Column(
            children: [
              const _Header(),
              const SizedBox(height: 20),
              Expanded(
                child: Wrapper(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: _SentenceViewer()),
                      _RecordedFilePlayer(),
                      SizedBox(height: 20),
                      _RecordButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MultiBLocListeners extends StatelessWidget {
  const _MultiBLocListeners({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SentenceCubit, SentenceState>(
          listenWhen: (previous, current) => previous.index != current.index,
          listener: (_, state) {
            context
                .read<AudioFileDetectCubit>()
                .searchFileByNumber(state.index + 1);

            context.read<AudioPlayerBLoc>().add(
                  const AudioPlayerEvent.stopRequested(),
                );
          },
        ),
        BlocListener<RecorderBloc, RecorderState>(
          listenWhen: (previous, current) {
            return current.maybeWhen(
              orElse: () => false,
              onReady: () => previous.maybeWhen(
                orElse: () => true,
                checkingPermission: () => false,
              ),
            );
          },
          listener: (_, state) {
            context.read<AudioFileDetectCubit>().searchFileByNumber(
                  context.read<SentenceCubit>().state.index + 1,
                );
          },
        ),
      ],
      child: child,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '녹음하기',
          style: TextStyles.title.copyWith(fontSize: 22),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '회원님의 목소리 모델 학습을 위해\n아래의 모든 문장을 녹음해주세요',
            style: TextStyles.subtitle.copyWith(fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _SentenceViewer extends StatelessWidget {
  const _SentenceViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SentenceCubit, SentenceState>(
      buildWhen: (previous, current) {
        return previous.currentSentence != current.currentSentence;
      },
      listener: (_, state) {},
      builder: (_, state) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${state.index + 1} / ${state.sentences.length}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  state.currentSentence,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RecordedFilePlayer extends StatelessWidget {
  const _RecordedFilePlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioFileDetectCubit, bool>(
      builder: (_, isFileExists) {
        if (!isFileExists) return const SizedBox.shrink();

        return RecordedFilePlayer(
          onPlay: () async {
            final fileNumber = context.read<SentenceCubit>().state.index + 1;

            context.read<AudioPlayerBLoc>().add(
                  AudioPlayerEvent.playRequested(
                    (await getApplicationCacheDirectory()).uri.toString(),
                    'voice_training_$fileNumber',
                  ),
                );
          },
          onStop: () => context.read<AudioPlayerBLoc>().add(
                const AudioPlayerEvent.stopRequested(),
              ),
          onClose: () => context
              .read<AudioFileDetectCubit>()
              .deleteFileByNumber(context.read<SentenceCubit>().state.index),
          onNext: () {
            final sentenceCubit = context.read<SentenceCubit>();

            if (sentenceCubit.state.isLast) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SubmitRecordingScreen(
                    sentences: sentenceCubit.state.sentences,
                  ),
                ),
              );
            }
            context.read<SentenceCubit>().next();
          },
        );
      },
    );
  }
}

class _RecordButton extends StatelessWidget {
  const _RecordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecorderBloc, RecorderState>(
      builder: (_, state) => SubmitButton(
        enabledColor: Colors.red.shade400,
        loadingWhen: state.maybeWhen(
          orElse: () => false,
          checkingPermission: () => true,
        ),
        onPressed: state.when(
          checkingPermission: () => () {},
          permissionDenied: (_) => null,
          onRecording: () {
            return () => context
                .read<RecorderBloc>()
                .add(const RecorderEvent.stopRequested());
          },
          onReady: () {
            return () => _record(context);
          },
        ),
        child: Text(
          state.when(
            checkingPermission: () => '권한 확인 중',
            permissionDenied: (message) => message,
            onReady: () => '녹음 시작',
            onRecording: () => '녹음 완료',
          ),
        ),
      ),
    );
  }

  void _record(BuildContext context) {
    final fileNumber = context.read<SentenceCubit>().state.index + 1;

    context.read<RecorderBloc>().add(
          RecorderEvent.recordRequested('voice_training_$fileNumber'),
        );
  }
}