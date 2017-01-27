import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'request-summary', templateUrl: 'request_summary_component.html')
class RequestSummaryComponent implements AfterViewInit {
  static const String route_name = 'RequestSummary';
  static const String route_path = 'summary';
  static const Route route = const Route(
      path: RequestSummaryComponent.route_path,
      component: RequestSummaryComponent,
      name: RequestSummaryComponent.route_name);

  final Router _router;

  RequestSummaryComponent(this._router) {}

  @override
  void ngAfterViewInit() {
    document.body.classes.remove('mobile-open');
    document.body.classes.remove('aside-menu-open');
  }
}
