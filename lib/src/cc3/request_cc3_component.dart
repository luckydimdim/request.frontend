import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';

@Component(selector: 'request-cc3', templateUrl: 'request_cc3_component.html')
class RequestCc3Component implements AfterViewInit {
  static const String route_name = 'RequestCc3';
  static const String route_path = 'cc-3';
  static const Route route = const Route(
      path: RequestCc3Component.route_path,
      component: RequestCc3Component,
      name: RequestCc3Component.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  RequestCc3Component(this._router, this._resourcesLoaderService) {}

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
