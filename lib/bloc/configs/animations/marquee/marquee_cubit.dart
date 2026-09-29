import 'package:led_panel/data/enums/marquee_direction_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/marquee_config_model.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'marquee_state.dart';

class MarqueeCubit extends Cubit<MarqueeState> {
  MarqueeCubit({final MarqueeConfigModel? config}) : super(MarqueeState(config: config));

  void onSpeedChanged(double speed) {
    emit(state.copyWith(config: state.config.copyWith(speed: speed)));
  }

  void onDirectionChanged(MarqueeDirectionEnum direction) {
    emit(state.copyWith(config: state.config.copyWith(direction: direction)));
  }
}
