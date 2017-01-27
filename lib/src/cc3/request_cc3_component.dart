import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'request-cc3',
    templateUrl: 'request_cc3_component.html',
    directives: const [RouterLink])
class RequestCc3Component implements AfterViewInit {
  static const String route_name = 'RequestCc3';
  static const String route_path = 'cc-3';
  static const Route route = const Route(
      path: RequestCc3Component.route_path,
      component: RequestCc3Component,
      name: RequestCc3Component.route_name);

  final Router _router;

  RequestCc3Component(this._router) {}

  @override
  void ngAfterViewInit() {
    // TODO: Продумать показ/скрытие меню
    document.body.classes.remove('mobile-open');
    document.body.classes.remove('aside-menu-open');
  }
}
