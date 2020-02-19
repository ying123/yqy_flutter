/**
 * This is an example of how to set up the [EventBus] and its events.
 */
import 'package:event_bus/event_bus.dart';

/// The global [EventBus] object.
EventBus eventBus = EventBus();
EventBus eventBus2 = EventBus();
/// Event       切换视频的url     搜索结果的显示   个人资料的修改通知  任务完成的刷新状态  都用到此类
class EventBusChange{

  String url;

  EventBusChange(this.url);

}

///
class EventBusChange2{

  String v;

  EventBusChange2(this.v);

}

///
///   医药咨询分类的筛选
///
class EventBusChangeNew{

  String v;

  EventBusChangeNew(this.v);

}