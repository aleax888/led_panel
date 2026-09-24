import 'package:led_panel/data/enums/crawl_direction_enum.dart';
import 'package:led_panel/data/models/animations/crawl_config_model.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'crawl_state.dart';

class CrawlCubit extends Cubit<CrawlState> {
  CrawlCubit() : super(CrawlState());

  void onSpeedChanged(double speed) {
    emit(state.copyWith(config: state.config.copyWith(speed: speed)));
  }

  void onTiltChanged(double tilt) {
    emit(
      state.copyWith(config: state.config.copyWithPreservedDepth(tilt: tilt)),
    );
  }

  void onDirectionChanged(CrawlTextDirectionEnum direction) {
    emit(state.copyWith(config: state.config.copyWith(direction: direction)));
  }
}
