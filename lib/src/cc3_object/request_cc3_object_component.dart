import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';

@Component(
  selector: 'request-cc3',
  templateUrl: 'request_cc3_object_component.html')
class RequestCc3ObjectComponent implements AfterViewInit {
  static const String route_name = 'RequestCc3Object';
  static const String route_path = 'cc-3/:objectName';
  static const Route route = const Route(
      path: RequestCc3ObjectComponent.route_path,
      component: RequestCc3ObjectComponent,
      name: RequestCc3ObjectComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;
  final RouteParams _routeParams;

  RequestCc3ObjectComponent(this._router, this._resourcesLoaderService, this._routeParams) {}

  @override
  ngOnInit() {
    String objectName = _routeParams.get('objectName');
  }

  @override
  void ngAfterViewInit() {
    // TODO: Продумать показ/скрытие меню
    document.body.classes.remove('mobile-open');
    document.body.classes.remove('aside-menu-open');

    _resourcesLoaderService.loadScript(
      'vendor/moment/min/', 'moment.min.js', false);

    _resourcesLoaderService.loadScript(
      'vendor/bootstrap-daterangepicker/', 'daterangepicker.js', false);

    _resourcesLoaderService.loadStyle(
      'vendor/bootstrap-daterangepicker/', 'daterangepicker.css');

    _resourcesLoaderService.loadScript(
      'packages/request/src/settings/', 'init-date-range.js', false);
  }
}