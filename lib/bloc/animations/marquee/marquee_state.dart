part of 'marquee_cubit.dart';

@immutable
final class MarqueeState {
  final MarqueeConfigModel config;
  const MarqueeState({this.config = const MarqueeConfigModel()});

  MarqueeState copyWith({MarqueeConfigModel? config}) {
    return MarqueeState(config: config ?? this.config);
  }
}
