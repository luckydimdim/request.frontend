import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(selector: 'request-ts', templateUrl: 'request_ts_component.html')
class RequestTsComponent implements AfterViewInit {
  static const String route_name = 'RequestTs';
  static const String route_path = 'time-sheet';
  static const Route route = const Route(
      path: RequestTsComponent.route_path,
      component: RequestTsComponent,
      name: RequestTsComponent.route_name);

  final Router _router;

  RequestTsComponent(this._router) {}

  @override
  void ngAfterViewInit() {
    document.body.classes.remove('mobile-open');
    document.body.classes.remove('aside-menu-open');
  }
}
