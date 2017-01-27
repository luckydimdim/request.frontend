import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
  selector: 'request-cc2',
  templateUrl: 'request_cc2_object_component.html',
  directives: const [RouterLink])
class RequestCc2ObjectComponent implements AfterViewInit, OnInit {
  static const String route_name = 'RequestCc2Object';
  static const String route_path = 'cc-2/:objectName';
  static const Route route = const Route(
      path: RequestCc2ObjectComponent.route_path,
      component: RequestCc2ObjectComponent,
      name: RequestCc2ObjectComponent.route_name);

  final Router _router;
  final RouteParams _routeParams;

  RequestCc2ObjectComponent(this._router, this._routeParams) { }

  @override
  ngOnInit() {
    String objectName = _routeParams.get('objectName');
  }

  @override
  void ngAfterViewInit() {
    // TODO: Продумать показ/скрытие меню
    document.body.classes.remove('mobile-open');
    document.body.classes.remove('aside-menu-open');
  }
}
