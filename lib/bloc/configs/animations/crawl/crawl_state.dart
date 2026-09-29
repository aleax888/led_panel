part of 'crawl_cubit.dart';

@immutable
final class CrawlState {
  final CrawlConfigModel config;
  const CrawlState({CrawlConfigModel? config})
    : config = config ?? const CrawlConfigModel();

  CrawlState copyWith({CrawlConfigModel? config}) {
    return CrawlState(config: config ?? this.config);
  }
}
