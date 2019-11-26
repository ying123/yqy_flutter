/**
 * This is an example of how to set up the [EventBus] and its events.
 */
import 'package:event_bus/event_bus.dart';

/// The global [EventBus] object.
EventBus eventBus = EventBus();

/// Event       切换视频的url     搜索结果的显示   个人资料的修改通知   都用到此类
class EventBusChange{

  String url;

  EventBusChange(this.url);

}

