import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(selector: 'request-cc2', templateUrl: 'request_cc2_component.html')
class RequestCc2Component implements AfterViewInit {
  static const String route_name = 'RequestCc2';
  static const String route_path = 'cc-2';
  static const Route route = const Route(
      path: RequestCc2Component.route_path,
      component: RequestCc2Component,
      name: RequestCc2Component.route_name);

  final Router _router;

  RequestCc2Component(this._router) {}

  @override
  void ngAfterViewInit() {
    document.body.classes.remove('mobile-open');
    document.body.classes.remove('aside-menu-open');
  }
}
