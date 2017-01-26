import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';

@Component(selector: 'request-cc2', templateUrl: 'request_cc2_component.html')
class RequestCc2Component implements AfterViewInit {
  static const String route_name = 'RequestCc2';
  static const String route_path = 'cc-2';
  static const Route route = const Route(
      path: RequestCc2Component.route_path,
      component: RequestCc2Component,
      name: RequestCc2Component.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  RequestCc2Component(this._router, this._resourcesLoaderService) {}

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